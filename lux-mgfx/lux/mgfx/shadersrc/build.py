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
    lines = [
        "local tableConcat = table.concat",
        "",
        f"export client const VERSION = {quote_lux_string(version)}",
        "",
        "local chunks = {",
    ]

    for chunk in chunks:
        lines.append(f"  {quote_lux_string(chunk)},")

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

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines), encoding="utf-8", newline="\n")


def write_legacy_lua(path, version, encoded):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        "\n".join(
            [
                "MGFXShaderPack = MGFXShaderPack or {}",
                f"MGFXShaderPack.Version = {version!r}",
                f"MGFXShaderPack.GMA = [========[{encoded}]========]",
                "",
            ]
        ),
        encoding="utf-8",
        newline="\n",
    )


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
        default=1000,
        help="base64 characters per Lux string chunk",
    )
    return parser.parse_args(argv)


def main(argv=None):
    args = parse_args(argv or sys.argv[1:])
    root = repo_path()

    if not args.version.isdigit():
        raise ValueError("--version must be a decimal Unix timestamp string")
    if args.chunk_size < 256:
        raise ValueError("--chunk-size must be at least 256")

    if not args.pack_only:
        run_shader_compile(root, args.shader_compiler)

    gma_timestamp = args.gma_timestamp if args.gma_timestamp is not None else int(args.version)
    encoded, count = build_shaderpack(root, args.version, gma_timestamp)
    out_path = Path(args.out).resolve()
    write_lux_module(out_path, args.version, encoded, args.chunk_size)
    print(f"Wrote Lux shaderpack: {out_path} ({count} shaders, version {args.version})")

    if args.lua_out:
        lua_out = Path(args.lua_out).resolve()
        write_legacy_lua(lua_out, args.version, encoded)
        print(f"Wrote legacy GLua shaderpack: {lua_out}")


if __name__ == "__main__":
    main()
