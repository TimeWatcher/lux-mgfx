# Shaders and Packaging

MGFX embeds compiled Source shader `.vcs` files into a Lua shaderpack. At runtime the shaderpack is mounted as a temporary GMA, then MGFX creates `screenspace_general` materials that reference the mounted pixel shaders.

## Layout

```text
lua-mgfx/shadersrc/mgfx/
  build.py
  build_shaders.bat
  compile_shader_list.txt
  src/*.hlsl
  src/shaders/fxc/*.vcs

lux-mgfx/lux/mgfx/shaderpack/
  src/cl_module.lux
```

The SDK helper tools are build-time only and must not be shipped as runtime files.

## Rebuild Shaderpack

From the repository root:

```powershell
python .\lua-mgfx\shadersrc\mgfx\build.py
```

The build script:

1. Runs the shader compile list.
2. Produces `.vcs` files under `src/shaders/fxc`.
3. Packs them into the embedded shaderpack.
4. Updates the Lua/Lux shaderpack source used by the runtime.

## Parameter Layout

Hot shape shaders use the shared matrix parameter page, read in HLSL through the MGFX common helpers. Extra `$c0..$c3` float constants are reserved for shaders that genuinely need more than the main 16 float slots.

Rules:

- Prefer the main parameter page.
- Use `$c0..$c3` only for fused shaders or extra effect data.
- Do not invent temporary registers such as `$c8`; they may compile but read as zero or undefined in GMod.
- Document parameter layout changes in this file.

## Gradient LUT

Multi-stop gradients use a cached 256-sample LUT. The shader reconstructs color and alpha from the LUT path. This avoids fragile alpha behavior across Source render targets and blend states.

## Adding a Shader

Add a new shader only when the feature cannot be expressed cleanly through an existing shader/fallback path.

Checklist:

- HLSL source is added to both source trees if needed.
- Compile list includes the shader.
- Generated `.vcs` files are updated.
- Material creation maps the runtime key to the pixel shader.
- Fallback behavior is defined.
- API docs describe the field or function that uses the shader.

## Layering

MGFX may use small focused fused shaders, but they must reproduce the original layered result. `pattern`, `shadow`, `outerGlow`, and `backdrop` often remain separate passes because their draw bounds, source texture, and blend order are visible behavior.
