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


def run_shader_compile(root, compiler):
    env = os.environ.copy()
    if compiler:
        env["MGFX_SHADERCOMPILE"] = str(Path(compiler).resolve())

    subprocess.check_call(["cmd", "/c", str(root / "build_shaders.bat")], cwd=root, env=env)


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

    return base64.b64encode(writer.data()).decode("ascii"), count


def chunk_text(value, size):
    return [value[index : index + size] for index in range(0, len(value), size)]


def write_shaderpack(path, version, encoded, chunk_size):
    path.parent.mkdir(parents=True, exist_ok=True)
    for stale in path.parent.glob("cl_mgfx_shaderpack_chunk_*.lua"):
        stale.unlink()

    chunks = chunk_text(encoded, chunk_size)
    chunk_names = []
    for index, chunk in enumerate(chunks, start=1):
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
    lines.extend(
        [
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
        ]
    )
    path.write_text("\n".join(lines), encoding="utf-8", newline="\n")
    return len(chunks)


def parse_args(argv):
    root = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(
        description="Compile MGFX shaders and generate the split legacy GLua shaderpack."
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
        default=str(root.parent.parent / "lua" / "mgfx" / "cl_mgfx_shaderpack.lua"),
        help="legacy GLua shaderpack manifest output path",
    )
    parser.add_argument(
        "--chunk-size",
        type=int,
        default=40000,
        help="base64 characters per generated GLua chunk file",
    )
    return parser.parse_args(argv)


def main(argv=None):
    args = parse_args(argv or sys.argv[1:])
    root = Path(__file__).resolve().parent

    if not args.version.isdigit():
        raise ValueError("--version must be a decimal Unix timestamp string")
    if args.chunk_size < 1024:
        raise ValueError("--chunk-size must be at least 1024")

    if not args.pack_only:
        run_shader_compile(root, args.shader_compiler)

    timestamp = args.gma_timestamp if args.gma_timestamp is not None else int(args.version)
    encoded, shader_count = build_shaderpack(root, args.version, timestamp)
    out_path = Path(args.out).resolve()
    chunk_count = write_shaderpack(out_path, args.version, encoded, args.chunk_size)
    print(
        f"Wrote split GLua shaderpack: {out_path} "
        f"({shader_count} shaders, {chunk_count} chunks, version {args.version})"
    )


if __name__ == "__main__":
    main()
