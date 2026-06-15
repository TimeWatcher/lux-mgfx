# MGFX build tools

This directory contains repository-level build tools used by MGFX maintenance.
It is intentionally outside `lux/mgfx` so the binary shader toolchain is not
part of the Lux package module tree.

`sdk_screenspace_shaders` includes the shader compiler used by
`lux/mgfx/shadersrc/build_shaders.bat`:

```text
sdk_screenspace_shaders/shadersrc/bin/ShaderCompile.exe
```

Lux projects consume the generated package module under
`lux/mgfx/shaderpack/src/cl_module.lux`; they do not copy this `tools/` directory
into a generated addon.
