#!/usr/bin/env python3
import argparse
import base64
import io
import os
import struct
import subprocess
import sys
import time
from pathlib import Path


class GMAWriter:
    def __init__(self, name, timestamp):
        self.name = name
        self.timestamp = timestamp
        self.entries = []

    def add_file(self, name, content):
        self.entries.append((name.replace("\\", "/"), content))

    @staticmethod
    def _cstring(buffer, text):
        buffer.write(text.encode("utf-8") + b"\0")

    def data(self):
        buffer = io.BytesIO()
        buffer.write(b"GMAD")
        buffer.write(struct.pack("B", 3))
        buffer.write(struct.pack("<Q", 12345678901234567))
        buffer.write(struct.pack("<Q", self.timestamp))
        buffer.write(b"\0")
        self._cstring(buffer, self.name)
        self._cstring(buffer, "")
        self._cstring(buffer, "mgfx")
        buffer.write(struct.pack("<i", 1))

        for index, (name, content) in enumerate(self.entries, start=1):
            buffer.write(struct.pack("<I", index))
            self._cstring(buffer, name)
            buffer.write(struct.pack("<Q", len(content)))
            buffer.write(struct.pack("<I", 0))

        buffer.write(struct.pack("<I", 0))
        for _, content in self.entries:
            buffer.write(content)
        buffer.write(struct.pack("<I", 0))
        return buffer.getvalue()


def repo_path(*parts):
    return Path(__file__).resolve().parent.joinpath(*parts)


def run_shader_compile(root, compiler):
    env = os.environ.copy()
    if compiler:
        env["MGFX_SHADERCOMPILE"] = str(Path(compiler).resolve())

    # ShaderCompile's incremental check does not reliably invalidate pixel
    # shaders when only an included common header changes. Remove generated
    # MGFX outputs first so a successful build can never package stale bytecode.
    fxc_dir = root / "src" / "shaders" / "fxc"
    if fxc_dir.exists():
        for path in fxc_dir.glob("mgfx_*.vcs"):
            path.unlink()

    script = root / "build_shaders.bat"
    subprocess.check_call(["cmd", "/c", str(script)], cwd=root, env=env)


def build_shaderpack(root, version, gma_timestamp):
    writer = GMAWriter(f"MGFX_{version}", gma_timestamp)
    fxc_dir = root / "src" / "shaders" / "fxc"

    if not fxc_dir.exists():
        raise FileNotFoundError(f"missing shader output directory: {fxc_dir}")

    count = 0
    for path in sorted(fxc_dir.iterdir(), key=lambda item: item.name.lower()):
        if not path.name.startswith("mgfx_") or path.suffix.lower() != ".vcs":
            continue
        writer.add_file(f"shaders/fxc/{version}_{path.name}", path.read_bytes())
        count += 1

    if count == 0:
        raise RuntimeError(f"no MGFX .vcs files found in {fxc_dir}")

    encoded = base64.b64encode(writer.data()).decode("ascii")
    return encoded, count


def quote_lux_string(value):
    return '"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"'


def chunk_text(value, size):
    return [value[index : index + size] for index in range(0, len(value), size)]


def write_lux_module(path, version, encoded, chunk_size):
    chunks = chunk_text(encoded, chunk_size)
    chunk_package_count = 5
    if len(chunks) > chunk_package_count:
        raise ValueError(
            f"shaderpack needs {len(chunks)} Lux chunk packages; "
            f"increase the {chunk_package_count} declared package slots"
        )

    path.parent.mkdir(parents=True, exist_ok=True)
    for stale in path.parent.glob("chunk_[0-9][0-9]"):
        module_path = stale / "cl_module.lux"
        if module_path.is_file():
            module_path.unlink()
        if stale.is_dir():
            stale.rmdir()

    chunk_root = path.parent.parent.parent / "shaderpack_chunks"
    chunk_names = []
    for index in range(1, chunk_package_count + 1):
        chunk = chunks[index - 1] if index <= len(chunks) else ""
        name = f"chunk{index:02d}"
        chunk_names.append(name)
        module_path = chunk_root / f"chunk_{index:02d}" / "src" / "cl_module.lux"
        module_path.parent.mkdir(parents=True, exist_ok=True)
        module_path.write_text(
            f"export client const {name} = {quote_lux_string(chunk)}\n",
            encoding="utf-8",
            newline="\n",
        )

    lines = []
    for index, name in enumerate(chunk_names, start=1):
        lines.append(f'import {{ {name} }} from "@lux/mgfx/shaderpack/chunk{index:02d}"')

    lines.extend([
        "",
        "local tableConcat = table.concat",
        "",
        f"export client const VERSION = {quote_lux_string(version)}",
        "",
        "local chunks = {",
    ])
    lines.extend(f"  {name}," for name in chunk_names)

    lines.extend(
        [
            "}",
            "",
            "local cachedGma = nil",
            "",
            "export client fn gma() {",
            "  if cachedGma == nil {",
            "    cachedGma = tableConcat(chunks)",
            "  }",
            "",
            "  cachedGma",
            "}",
            "",
            "export client fn pack() {",
            "  return {",
            "    Version = VERSION,",
            "    GMA = gma()",
            "  }",
            "}",
            "",
            "export client fn current() {",
            "  local globalPack = MGFXShaderPack",
            '  if globalPack ~= nil and globalPack.GMA ~= nil and globalPack.GMA ~= "" {',
            "    return globalPack",
            "  }",
            "",
            "  pack()",
            "}",
            "",
            'export client fn installGlobal(name = "MGFXShaderPack") {',
            "  local target = _G[name] ?? {}",
            "  target.Version = VERSION",
            "  target.GMA = gma()",
            "  _G[name] = target",
            "  target",
            "}",
            "",
        ]
    )

    path.write_text("\n".join(lines), encoding="utf-8", newline="\n")


def write_legacy_lua(path, version, encoded, chunk_size):
    path.parent.mkdir(parents=True, exist_ok=True)
    for stale in path.parent.glob("cl_mgfx_shaderpack_chunk_*.lua"):
        stale.unlink()

    chunk_names = []
    for index, chunk in enumerate(chunk_text(encoded, chunk_size), start=1):
        name = f"cl_mgfx_shaderpack_chunk_{index:02d}.lua"
        chunk_names.append(name)
        (path.parent / name).write_text(
            f"return [========[{chunk}]========]\n",
            encoding="utf-8",
            newline="\n",
        )

    lines = [
        "MGFXShaderPack = MGFXShaderPack or {}",
        f"MGFXShaderPack.Version = {version!r}",
        "",
        'local base_path = "mgfx/"',
        "local chunk_files = {",
    ]
    lines.extend(f'    "{name}",' for name in chunk_names)
    lines.extend([
        "}",
        "local chunks = {}",
        "",
        "for i = 1, #chunk_files do",
        "    local chunk = include(base_path .. chunk_files[i])",
        '    if not isstring(chunk) or chunk == "" then',
        '        error("MGFX shaderpack chunk did not load: " .. chunk_files[i])',
        "    end",
        "    chunks[i] = chunk",
        "end",
        "",
        "MGFXShaderPack.GMA = table.concat(chunks)",
        "",
    ])
    path.write_text("\n".join(lines), encoding="utf-8", newline="\n")


def parse_args(argv):
    root = repo_path()
    parser = argparse.ArgumentParser(
        description="Compile MGFX shaders and generate the Lux shaderpack module."
    )
    parser.add_argument(
        "--pack-only",
        action="store_true",
        help="skip ShaderCompile.exe and pack the existing src/shaders/fxc/*.vcs files",
    )
    parser.add_argument(
        "--shader-compiler",
        help="path to ShaderCompile.exe; also available through MGFX_SHADERCOMPILE",
    )
    parser.add_argument(
        "--version",
        default=str(int(time.time())),
        help="shaderpack version/prefix; defaults to the current Unix timestamp",
    )
    parser.add_argument(
        "--gma-timestamp",
        type=int,
        help="GMA header timestamp; defaults to --version for reproducible output",
    )
    parser.add_argument(
        "--out",
        default=str(root.parent / "shaderpack" / "src" / "cl_module.lux"),
        help="Lux module output path",
    )
    parser.add_argument(
        "--lua-out",
        help="optional legacy GLua shaderpack output path",
    )
    parser.add_argument(
        "--chunk-size",
        type=int,
        default=40000,
        help="base64 characters per generated Lux/GLua chunk module",
    )
    return parser.parse_args(argv)


def main(argv=None):
    args = parse_args(argv or sys.argv[1:])
    root = repo_path()

    if not args.version.isdigit():
        raise ValueError("--version must be a decimal Unix timestamp string")
    if args.chunk_size < 1024:
        raise ValueError("--chunk-size must be at least 1024")

    if not args.pack_only:
        run_shader_compile(root, args.shader_compiler)

    gma_timestamp = args.gma_timestamp if args.gma_timestamp is not None else int(args.version)
    encoded, count = build_shaderpack(root, args.version, gma_timestamp)
    out_path = Path(args.out).resolve()
    write_lux_module(out_path, args.version, encoded, args.chunk_size)
    print(f"Wrote Lux shaderpack: {out_path} ({count} shaders, version {args.version})")

    if args.lua_out:
        lua_out = Path(args.lua_out).resolve()
        write_legacy_lua(lua_out, args.version, encoded, args.chunk_size)
        print(f"Wrote legacy GLua shaderpack: {lua_out}")


if __name__ == "__main__":
    main()
