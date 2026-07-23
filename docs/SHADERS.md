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

lux-mgfx/lux/mgfx/shaderpack_chunks/
  chunk_01/src/cl_module.lux
  ...
  chunk_05/src/cl_module.lux
```

The SDK helper tools are build-time only and must not be shipped as runtime files.

## Rebuild Shaderpack

From the repository root:

```powershell
python .\lua-mgfx\shadersrc\mgfx\build.py
python .\lux-mgfx\lux\mgfx\shadersrc\build.py
```

The build script:

1. Runs the shader compile list.
2. Produces `.vcs` files under `src/shaders/fxc`.
3. Packs them into the embedded shaderpack.
4. Writes a small facade plus 40,000-character GLua files or independent Lux
   chunk packages, so the generated runtime never depends on one oversized
   source artifact.

## Parameter Layout

Hot shape shaders use matrix parameter pages, read in HLSL through the MGFX common helpers:

```hlsl
const float4x4 MGFXExtraParams : register(c11);
const float4x4 MGFXAuxParams   : register(c15);
```

Lua writes them with `Matrix():SetUnpacked(...)` followed by `SetMatrix("$viewprojmat", matrix)` for `c11` and `SetMatrix("$invviewprojmat", matrix)` for `c15`. This avoids the high cost of many individual `SetFloat("$cN_*", ...)` calls in hot paths.

`MGFXExtraParams` is the main 16-float page. `MGFXAuxParams` is the auxiliary 16-float page for fused shaders and shape families that need more data, such as polygon vertices, chamfer cuts, ring stroke/inner glow data, text atlas data, and combined shadow/glow parameters. `$c0..$c3` remain declared for compatibility and diagnostics, but new hot rendering paths should prefer the matrix pages.

Rules:

- Prefer `MGFXExtraParams` / `$viewprojmat` (`c11`) for the common page.
- Use `MGFXAuxParams` / `$invviewprojmat` (`c15`) for extra fused-shader data.
- Avoid `$c0..$c3` in hot paths unless a measured engine constraint leaves no matrix alternative.
- Do not invent temporary registers such as `$c8`; they may compile but read as zero or undefined in GMod.
- Document parameter layout changes in this file.

## Image Mask Samplers

`mgfx_image_mask` keeps `$basetexture` fixed to `color/white`. It is the stable mapping carrier used by the `DrawTexturedRectUV` half-pixel correction, not the image being rendered. The shader sampler layout is:

- `TexBase`: fixed local-UV mapping carrier.
- `Tex1`: source image or render target.
- `Tex2`: optional texture mask.

The corrected `i.uv` is reserved for normalized shape coordinates, while `SOURCE_UV` maps it into the source image. Do not bind a source image back to `$basetexture`: changing the material mapping dimensions couples source sampling to procedural SDF coordinates and distorts circle and rounded-mask coverage.

## ShapeClip Composite

`mgfx_shape_clip` is a framebuffer transaction shader, not a stencil mask. Its sampler layout deliberately leaves `TexBase` alone:

- `TexBase`: fixed `color/white`; it is never replaced at draw time.
- `Tex1`: framebuffer after the Clip callback.
- `Tex2`: custom coverage RT when the Mask is painter-defined.
- `Tex3`: framebuffer before the Clip callback.

The shader computes analytical rounded/chamfer/circle/capsule coverage—or samples custom coverage—then returns `lerp(before, after, coverage)`. Custom Mask rasters include up to a one-pixel transparent border on each side; padding is reduced at framebuffer edges so full-screen masks remain valid. The shader samples that border without clamping or multiplying by a second rectangular coverage term; otherwise vector AA approaching the Clip bounds is visibly cut off. A rectangular scissor bounds the composite work only and never defines the shape edge.

### Do not dynamically replace `$basetexture`

`surface.DrawTexturedRectUV` applies an implicit half-texel adjustment derived from the currently bound `$basetexture` dimensions. Changing a shared material's `$basetexture` from its fixed placeholder to a full-screen render target after local UVs were prepared changes that hidden adjustment. The result is a second, wrong UV correction: local Mask coverage shifts, stretches, or loses pixels at its bounds.

For a shader that samples runtime render targets, declare `$texture1`, `$texture2`, and `$texture3` as texture-typed variables when the material is created, bind the RTs there, and keep `$basetexture` stable. A per-target blit material may use an RT as `$basetexture` only when that binding is fixed for the material's lifetime and the submitted UVs were computed for that texture size. This is why the internal coverage-copy materials are safe while the Clip composite material must not replace `$basetexture`.

## Gradient LUT

Multi-stop gradients use a cached 256x4 `BGRA8888` LUT. Each RGBA channel is
encoded as 16-bit fixed point while the render target alpha remains opaque:

```text
row 0      high bytes of RGB
row 1      low bytes of RGB
rows 2..3  high/low bytes of alpha in the R/G channels
```

The pixel shader performs three filtered samples and reconstructs the original
RGBA values. Keeping gradient alpha in color channels avoids Source render
target alpha-write/sampling inconsistencies, while the high/low-byte encoding
prevents the LUT itself from collapsing low-alpha ramps into repeated 8-bit
steps.

Before returning a gradient color, the same pixel shader applies stable
screen-space interleaved-gradient-noise dithering at half of one 8-bit LSB.
The noise is derived from integer `VPOS`, uses correlated RGBA noise to avoid
colored speckle, preserves exact 0/1 endpoints, and adds no sampler, texture, or
draw pass.

## Adding a Shader

Add a new shader only when the feature cannot be expressed cleanly through an existing shader/fallback path.

Checklist:

- HLSL source is added to both source trees if needed.
- Compile list includes the shader.
- Generated `.vcs` files are updated.
- Material creation maps the runtime key to the pixel shader.
- Fallback behavior is defined, or shader-only behavior fails explicitly when a lower-quality result would violate the API contract.
- API docs describe the field or function that uses the shader.

## Layering

MGFX may use small focused fused shaders, but they must reproduce the original layered result.

Current fused paths include:

- `roundrect_fx`: fill/stroke plus inner glow when that saves a pass.
- `roundrect_shadow_outer`: rounded-box shadow plus outer glow.
- `chamfer`: chamfer fill/stroke plus optional inner glow.
- `chamfer_shadow_outer`: chamfer shadow plus outer glow.
- `ring_fx`: ring/arc/sector fill/stroke plus optional inner glow.
- `ring_shadow_outer`: ring/arc/sector shadow plus outer glow.
- `image_mask_shadow_outer`: rounded/chamfer/circle/capsule/texture image-mask shadow plus outer glow.

The fused shadow/glow paths keep the API semantics separate: shadow is a CSS-like projected solid shape mask, while outer glow is exterior-only edge light. Convex polygon shadow/outer-glow paths remain separate because the polygon vertex data already consumes the auxiliary parameter page. Backdrop blur remains a separate pass because it samples the framebuffer and its source texture and blend order are visible behavior.
