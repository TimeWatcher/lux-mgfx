# MGFX shader source

This directory contains the HLSL source and compiled `.vcs` shader outputs used by
the Lux MGFX shaderpack module.

The canonical generated runtime files are:

```text
../shaderpack/src/cl_module.lux
../shaderpack_chunks/chunk_01/src/cl_module.lux
...
../shaderpack_chunks/chunk_05/src/cl_module.lux
```

Common commands:

```powershell
# Rebuild the Lux shaderpack from committed .vcs files.
python .\build.py --pack-only

# Reproduce a stable shaderpack version.
python .\build.py --pack-only --version 1781243087

# Compile HLSL with the bundled shader compiler, then generate the Lux shaderpack.
python .\build.py

# Override the bundled compiler when testing another ShaderCompile.exe build.
$env:MGFX_SHADERCOMPILE = "C:\Path\To\ShaderCompile.exe"
python .\build.py

# Reproduce the historical MGFX Lua shaderpack byte-for-byte for inspection.
python .\build.py --pack-only --version 1781243087 --gma-timestamp 1781243088

# Optionally emit the historical GLua shaderpack shape for inspection.
python .\build.py --pack-only --lua-out .\cl_mgfx_shaderpack.lua
```

`build.py` writes the base64 encoded GMA across five independent Lux chunk
packages. The shaderpack facade concatenates them once. At runtime MGFX decodes
the GMA, writes it into Garry's Mod `data/`, mounts it through `game.MountGMA`,
and uses the version-prefixed shader names.

The bundled compiler is stored outside the Lux package tree:

```text
../../../tools/mgfx/sdk_screenspace_shaders/shadersrc/bin/ShaderCompile.exe
```

That repository-level `tools/` directory is build infrastructure, not part of
the `lux/mgfx` package runtime or module source layout. Garry's Mod itself does
not ship a shader compiler. Do not depend on a `garrysmod/bin` fallback.
