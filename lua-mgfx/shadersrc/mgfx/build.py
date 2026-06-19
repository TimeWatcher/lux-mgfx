import base64
import io
import os
import struct
import subprocess
import time


class GMAWriter:
    def __init__(self, name):
        self.name = name
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
        buffer.write(struct.pack("<Q", int(time.time())))
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


def main():
    root = os.path.dirname(os.path.abspath(__file__))
    subprocess.check_call([os.path.join(root, "build_shaders.bat")], cwd=root, shell=True)

    version = str(int(time.time()))
    writer = GMAWriter(f"MGFX_{version}")
    fxc_dir = os.path.join(root, "src", "shaders", "fxc")

    for filename in sorted(os.listdir(fxc_dir)):
        if not filename.startswith("mgfx_") or not filename.endswith(".vcs"):
            continue
        with open(os.path.join(fxc_dir, filename), "rb") as handle:
            writer.add_file(f"shaders/fxc/{version}_{filename}", handle.read())

    encoded = base64.b64encode(writer.data()).decode("ascii")
    out_path = os.path.abspath(os.path.join(root, "..", "..", "lua", "mgfx", "cl_mgfx_shaderpack.lua"))

    with open(out_path, "w", encoding="utf-8") as handle:
        handle.write("MGFXShaderPack = MGFXShaderPack or {}\n")
        handle.write(f"MGFXShaderPack.Version = {version!r}\n")
        handle.write("MGFXShaderPack.GMA = [========[")
        handle.write(encoded)
        handle.write("]========]\n")

    print(f"Wrote {out_path}")


if __name__ == "__main__":
    main()
