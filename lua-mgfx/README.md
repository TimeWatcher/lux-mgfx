# Modern GMod FX

Modern GMod FX, abbreviated as MGFX, is a Garry's Mod UI rendering addon built
around shader-backed immediate draw calls. It provides high-quality rounded
shapes, gradients, patterns, image masks, glow effects, and optional shader text
effects without depending on gamemode code.

MGFX is intentionally a renderer, not a UI framework. It does not own layout,
input, component state, transitions, or panel lifecycle. Callers pass explicit
draw arguments every frame.

## Install

Place this folder at:

```text
garrysmod/addons/mgfx
```

The addon loads itself through:

```text
lua/autorun/server/mgfx_loader.lua
lua/autorun/client/mgfx_loader.lua
```

Gamemodes should not include files from `lua/mgfx` directly. Use the public
`MGFX.*` API after the addon has loaded.

## Quick Start

```lua
function PANEL:Paint(w, h)
    MGFX.StartPanel(self, w, h)

    MGFX.RoundedBoxEx(0, 0, w, h, {
        radius = 8,
        fill = Color(5, 18, 26, 150),
        shadow = {
            x = 0,
            y = 8,
            blur = 18,
            spread = 2,
            color = Color(0, 0, 0, 118),
            softness = 0.62,
        },
        backdrop = {
            blur = 8,
            tint = Color(0, 8, 12, 150),
        },
    })

    MGFX.RoundedBox(
        16, 16, w - 32, 72,
        6,
        Color(5, 18, 26, 185),
        Color(70, 160, 220, 60),
        1
    )

    MGFX.ProgressBarEx(24, 104, w - 48, 10, 0.72, {
        radius = 5,
        track = Color(10, 18, 24, 190),
        fill = MGFX.LinearGradient(0, 0, 1, 0,
            Color(30, 130, 255, 230),
            Color(60, 200, 255, 230)
        ),
    })

    MGFX.EndPanel()
end
```

## Runtime Commands

```text
mgfx_status
mgfx_selftest
mgfx_reload
mgfx_demo
mgfx_wheel_demo
mgfx_emote_wheel_demo
mgfx_text_status
mgfx_text_cache_clear
```

Useful client cvars:

```text
mgfx_force_fallback 0/1
mgfx_profile 0/1
mgfx_draw_counts 0/1
mgfx_text_composed 0/1
mgfx_text_composed_budget 6
```

Zombie Survival scoreboard override is a separate addon:
`mgfx_zs_scoreboard`. It depends on MGFX but is not part of the core renderer.

## Features

- Rounded boxes, chamfer boxes, circles, capsules, convex polygons, lines,
  progress bars, segmented bars, rings, arcs, and straight-edged sectors.
- Solid color, linear/radial/conic gradients, multi-stop gradients, stripe
  patterns, smoke patterns, image fills, and ring/sector-local radial or
  angular gradients.
- Shader masks for rounded, chamfer, circle, capsule, and texture masks.
- External soft shadow, offset outer glow, inner glow, thin strokes,
  shape-aware backdrop blur, and image tint/crop/fit.
- Text APIs with native plain-text routing plus composer-based shader effects:
  gradient fill, outline, shadow, glow, tracking, weight bias, italic/slant, and
  text boxes.

## Effect Model

`shadow`, `outerGlow`, and `backdrop` are intentionally separate:

- `shadow` is an external soft SDF pass with offset support.
- `outerGlow` is an external glow pass and also accepts offsets.
- `backdrop` samples/tints the background inside the shape or image mask.

Compatible rounded-box, chamfer, ring, and image-mask `shadow + outerGlow`
layers can share one shader pass. The fields remain separate because their
visual semantics are different: shadow is a projected solid mask, while
outerGlow is exterior edge light.

Use `shadow = {x = 0, y = 8, blur = 18, spread = 2, color = Color(...)}` for
drop shadows. Use `outerGlow = {x = 0, y = 0, width = 16, color = Color(...)}`
for glow. `backdrop` should be reserved for glass/blur/tint surfaces, not
treated as a shadow substitute.

Rounded boxes can use multiple shadow layers in one style:

```lua
shadow = {
    {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 90)},
    {x = 0, y = 8, blur = 24, color = Color(0, 0, 0, 80)},
}
```

This replaces the old pattern of stacking several `RoundedBoxEx` calls for
shadow only. The renderer loops the shadow-only path and still draws the body
once.

## Performance Model

MGFX keeps the immediate drawing model. It does not hide calls behind a general
batch scheduler. Public `NameEx(..., style)` functions remain table-based for
readability, but hot internal layers now flatten those records once and pass
prepared scalar, fill, stroke, and effect parameters to the shader/fallback
draw path.

Recent shop UI profiling with diagnostics disabled holds 130+ FPS with a full
item list and 160+ FPS in lighter categories.

## Documentation

Shared MGFX documentation lives one level up in `../docs`:

- [Online Documentation](https://timewatcher.github.io/mgfx-docs-site/)
- [API Reference](../docs/API.md)
- [Performance Notes](../docs/PERFORMANCE.md)
- [Internal Architecture](../docs/ARCHITECTURE.md)
- [Retired Batching Notes](../docs/BATCHING.md)
- [Retired Batch Coverage](../docs/BATCH_COVERAGE.md)
- [Text Renderer](../docs/TEXT.md)
- [Shader Build And Packaging](../docs/SHADERS.md)

## Build Shaders

Shader source lives in `shadersrc/mgfx`. To rebuild the embedded shaderpack:

```powershell
python .\shadersrc\mgfx\build.py
```

The script writes:

```text
lua/mgfx/cl_mgfx_shaderpack.lua
```

The generated shaderpack is mounted by MGFX at runtime. The raw shader source
and SDK helper tools are excluded from published GMA builds by `addon.json`.

## Packaging

The addon is GMA-valid. A validation package can be generated with:

```powershell
gmad.exe create -folder "garrysmod/addons/mgfx" -out "%TEMP%/mgfx.gma"
```

Runtime package contents are Lua and the bundled lowercase TTF font. Shared
repository docs live outside this addon directory; shader source, demo-only
assets, and build tools are ignored for Workshop packaging.

## Maintenance Rules

- Keep public draw calls immediate and explicit.
- Keep style table parsing at the public API boundary; internal draw helpers
  should use prepared parameters.
- Do not add global paint state or hidden component lifecycle.
- Do not use stencil to emulate shape masks; use shader coverage.
- Keep shape rendering on the immediate path unless a new prototype proves a
  representative GMod UI win; see `../docs/BATCHING.md` before rebuilding batch.
- Keep runtime Lua modules below 2000 lines.
- Keep gamemode-specific UI code outside MGFX.
