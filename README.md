# MGFX

<p align="center">
  <strong>Shader-backed immediate rendering for modern Garry's Mod interfaces.</strong>
</p>

<p align="center">
  Smooth analytical shapes · rich gradients · procedural materials · text effects<br>
  antialiased coverage clipping · shared backdrop blur · Plain GLua + Lux
</p>

<p align="center">
  <a href="https://timewatcher.github.io/mgfx-docs-site/"><img alt="Documentation" src="https://img.shields.io/badge/docs-online-5eead4?style=flat-square"></a>
  <img alt="Garry's Mod" src="https://img.shields.io/badge/Garry's%20Mod-client-49a9e8?style=flat-square">
  <img alt="Implementations" src="https://img.shields.io/badge/runtime-GLua%20%2B%20Lux-8b5cf6?style=flat-square">
  <img alt="Rendering" src="https://img.shields.io/badge/rendering-shader%20%2B%20fallback-f59e0b?style=flat-square">
  <a href="LICENSE-MGFX-NC"><img alt="License" src="https://img.shields.io/badge/license-non--commercial-ef4444?style=flat-square"></a>
</p>

MGFX helps build polished HUDs, scoreboards, shops, inventories, status panels,
radial menus, and other game interfaces without turning every visual effect
into a pile of temporary geometry and Lua-side bookkeeping.

> **MGFX is a renderer, not a UI framework.** It owns drawing, effects,
> clipping, and shader/fallback routing. Your code still owns layout, input,
> focus, animation state, hit testing, component lifecycle, and panel behavior.

**[Read the docs](https://timewatcher.github.io/mgfx-docs-site/)** ·
**[Plain GLua quick start](docs/guide/glua.md)** ·
**[Lux quick start](docs/guide/lux.md)** ·
**[API reference](docs/api-reference/index.md)**

---

## ✨ Why MGFX?

A modern Source UI often needs more than a flat `draw.RoundedBox`: gradients,
soft shadows, worn materials, masked images, glowing headings, non-rectangular
clipping, and blurred surfaces all have different rendering and state needs.
MGFX gives those operations one consistent immediate API.

| Common hand-built approach | MGFX approach |
| --- | --- |
| High-segment Lua polygons for smooth shapes | Analytical/SDF shape coverage on focused shader paths |
| Stacked boxes or generated textures for gradients | Multi-stop shader gradients with curves, high-precision LUTs, and dithering |
| Repeating a complete shape for each shadow layer | Explicit layered shadows; the source body is drawn once |
| Capturing and blurring the framebuffer per glass panel | Shared backdrop capture and separable blur per frame/level |
| Binary stencil edges for a mixed-content shape clip | Continuous coverage composite with real antialiased edges |
| Geometry recipes for stripes, smoke, and wear | Procedural pattern paint clipped inside the existing shape pass |
| One expensive text route for every label | Native text by default; composed shader text only when effects need it |

This is not a promise that every effect costs one draw. Blur, framebuffer
transactions, shadows, and glows still have real GPU costs. MGFX makes those
costs explicit, reusable where possible, and diagnosable at runtime.

### A short hot path

Simple drawing stays simple and immediate:

```lua
MGFX.RoundedBox(40, 40, 320, 72, 10, Color(18, 25, 34, 235))
```

No style table, command object, intermediate target, or general end-of-frame
scheduler is created for that call.

### A richer surface

Use an `Ex` style when the design needs named effects:

```lua
local cardStyle = MGFX.CompileStyle({
    radius = 14,

    fill = MGFX.LinearGradientStops(0, 0, 1, 1, {
        {0.00, Color(25, 36, 47, 238)},
        {0.55, Color(15, 25, 34, 232)},
        {1.00, Color(8, 15, 22, 238)},
    }, "smoothstep"),

    stroke = {
        color = Color(130, 255, 174, 72),
        width = 2,
        kind = "dash",
        length = 12,
        gap = 6,
    },

    shadow = {
        x = 0,
        y = 8,
        blur = 22,
        spread = 2,
        color = Color(0, 0, 0, 135),
    },

    backdrop = {
        blur = 10,
        level = 0,
        tint = Color(7, 15, 22, 110),
    },

    pattern = MGFX.WornPattern({
        color = Color(0, 0, 0, 34),
        edgeColor = Color(150, 255, 180, 45),
        grain = 0.55,
        fractal = 0.34,
        scratches = 0.18,
        edge = 0.38,
        seed = "scoreboard-card",
    }),
})

MGFX.RoundedBoxEx(40, 40, 420, 180, cardStyle)
```

---

## 🧩 Two maintained implementations

| Directory | Use it when | Public API |
| --- | --- | --- |
| [`lua-mgfx/`](lua-mgfx/) | Your addon or gamemode uses ordinary GLua | global `MGFX.*` |
| [`lux-mgfx/`](lux-mgfx/) | Your project is compiled with Lux | `mgfx.api.*` |
| [`docs/`](docs/) | You need shared behavior and API documentation | applies to both runtimes |

The implementations share the same renderer model and are maintained in
behavioral sync. Plain GLua is not generated from Lux; `lua-mgfx/` is the
canonical ordinary-addon implementation.

```lua
-- Plain GLua
MGFX.RoundedBoxEx(x, y, w, h, style)
```

```lux
// Lux
import * as mgfx from "@lux/mgfx"

mgfx.api.roundedBoxEx(x, y, w, h, style)
```

---

## 🎨 Feature map

MGFX is substantially more than a rounded-box replacement.

### Shapes, strokes, and HUD primitives

- Rounded rectangles with scalar or independent corner radii
- Chamfered rectangles with independent corner cuts
- Circles, capsules, convex polygons, and regular polygons
- Diamonds, directional carets, lines, and capless lines
- Progress bars and segmented bars
- Rings, arcs, and straight-edged sectors
- Centered `solid`, `dot`, `dash`, and `dot-dash` strokes

Patterned strokes use an isolated shader pass and retain a CPU fallback.
Closed-shape periods are fitted to the perimeter so the returning pattern does
not visibly disagree with its mathematical start phase.

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = Color(18, 24, 32),
    stroke = {
        color = Color(90, 190, 255),
        width = 3,
        kind = "dot-dash",
        length = 12,
        gap = 6,
        offset = 0,
    },
})
```

The legacy `stroke = Color(...)` plus `strokeWidth` form remains supported.

### Gradients and light fields

- Solid colors
- Two-color and multi-stop linear gradients
- Circular and elliptical radial gradients
- Conic gradients
- Shape-, ring-, and sector-local radial/angular gradients
- Shader-native gradient curves: `linear`, `smoothstep`, `smootherstep`,
  `ease-in`, `ease-out`, `ease-in-out`, `exponential`, `gaussian`, and
  `inverse-square`

Curves remap the existing shader coordinate before LUT sampling; they do not
add a draw pass. Multi-stop gradients use a packed 16-bit RGBA LUT and stable
screen-space dithering to reduce visible low-alpha banding.

```lua
local topLight = MGFX.EllipticalRadialGradient(0.5, -0.15, 0.72, 1.35, {
    {0.00, Color(132, 255, 148, 224)},
    {1.00, Color(18, 48, 30, 0)},
}, nil, "exponential")
```

Centers may sit outside the primitive, which makes top-origin spotlights and
wide non-circular light fields possible without a separate shader or pass.

### Procedural material patterns

Patterns are shader paint slots clipped to their shape—not recipes that emit
dozens of extra boxes, lines, or polygons.

- `StripePattern`
- `SmokePattern`
- `WornPattern`
- Image and material paint sources

```lua
local worn = MGFX.WornPattern({
    color = Color(0, 0, 0, 44),
    edgeColor = Color(218, 208, 184, 78),
    fractal = 0.44,
    grain = 0.64,
    scratches = 0.30,
    edge = 0.54,
    scale = 32,
    grainScale = 5.6,
    scratchScale = 26,
    scratchWidth = 0.045,
    edgeWidth = 7,
    angle = -14,
    warp = 0.035,
    seed = "inventory-card",
})
```

`WornPattern` is tuned for subdued roughness, sparse scuffs, short directional
scratches, and broken edge wear—not as a generic smoke overlay.

### Effects with distinct semantics

| Effect | What it means |
| --- | --- |
| `shadow` | A projected soft pass derived from the full solid shape mask; supports offset, blur, spread, softness, opacity, and multiple layers. |
| `outerGlow` | Exterior-only edge light; offset biases the glow without turning it into a projected shadow. |
| `innerGlow` | Edge light clipped inside the source shape. |
| `backdrop` | Samples and tints the framebuffer inside the current shape or image mask; it is not a shadow. |

Compatible `shadow + outerGlow` work is fused for rounded boxes, chamfers,
rings, and image masks while their style fields and visual semantics remain
separate.

Layered shadows avoid redrawing the entire source shape for each layer:

```lua
shadow = {
    {x = 0, y = 1, blur = 2,  color = Color(0, 0, 0, 90)},
    {x = 0, y = 8, blur = 24, color = Color(0, 0, 0, 80)},
}
```

Backdrop blur is shared by engine frame and integer `backdrop.level`. The first
blurred backdrop at a level captures the framebuffer and runs the horizontal
and vertical axes; matching later shapes reuse that prepared result. Use
`recapture = true` only when a later draw must deliberately include newer
framebuffer content at the same level.

### Images and icons

- Materials, textures, render targets, texture names, and icons
- `contain`, `cover`, `fill`, and `stretch` fit modes
- UV and crop control
- Rounded, chamfer, circle, capsule, and texture masks
- Image-local shadow, glow, backdrop, stroke, and transforms
- Allocation-light positional `ImageUV(...)`

An image style mask belongs to one image draw. Reusable mixed-content clipping
uses the separate coverage Mask API below.

### 🔠 Text: native when cheap, composed when expressive

Plain labels, player names, table rows, and changing counters stay on the
native GMod text path by default. The composer route is used only when a style
needs gradient fill, stroke, glow, shadow, weight, italic, or tracking.

```lua
MGFX.TextEx("OVERTIME", "DermaLarge", x, y, nil,
    TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, {
        fill = MGFX.LinearGradient(0, 0, 1, 0,
            Color(255, 210, 90), Color(255, 80, 70)),
        glow = {color = Color(255, 96, 78, 120), blur = 10},
        shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 150)},
    })
```

Useful APIs include `Text`, `TextEx`, `TextBoxEx`, `MeasureText`,
`MeasureTextBox`, and `PrewarmText`. Prewarm predictable display strings, not
ordinary native labels.

### ✂️ Reusable antialiased coverage clipping

MGFX deliberately separates two concepts:

1. `ImageEx(..., {mask = ...})` masks one image draw.
2. `MGFX.Mask(painter)` defines reusable coverage for `MGFX.Clip(...)`, which
   can clip any mixture of MGFX shapes, images, text, and native drawing.

```lua
local badgeMask = MGFX.Mask(function(m, w, h)
    local radius = math.min(w, h) * 0.48

    m:Draw(function()
        MGFX.Circle(w * 0.5, h * 0.5, radius, color_white)
    end)

    m:Subtract(function()
        MGFX.Circle(w * 0.69, h * 0.31, radius * 0.38, color_white)
    end)
end)

MGFX.Clip(badgeMask, x, y, 120, 72, function()
    MGFX.Image(x - 16, y, 152, 72, material)
    MGFX.Text("READY", "DermaLarge", x + 60, y + 36, color_white,
        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)
```

The recorder supports exact coverage operations:

| Operation | Coverage formula |
| --- | --- |
| `Draw` / `Union` | `max(A, B)` |
| `Subtract` | `A * (1 - B)` |
| `Intersect` | `A * B` |
| `Xor` | `A + B - 2AB` |
| `Invert` | `1 - A` inside the current bounds |

Built-in analytical presets include `Masks.Circle`, `Masks.Capsule`,
`Masks.Rounded(...)`, and `Masks.Chamfer(...)`. Custom coverage is rasterized
into local bucketed accumulator/scratch targets and cached. Integer translation
normally reuses the raster; call `mask:Invalidate()` when painter inputs change.

Supported shapes can also clip their own children without repeating a Mask:

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 18,
    fill = Color(8, 18, 24, 230),
    stroke = Color(100, 220, 170, 180),
    strokeWidth = 2,
}, function(cx, cy, cw, ch)
    MGFX.ImageEx(cx, cy, cw, ch, material, {fit = "cover"})
end)
```

The container order is `background/effects → clipped children → foreground
stroke`, so children cannot cover the inner half of a centered border.

Coverage Clip is antialiased and does **not** use stencil or a binary fallback.
It is a framebuffer transaction, so use the cheaper rectangular scissor stack
for ordinary scrolling regions. See the [complete Mask and Clip reference](docs/api-reference/masks-and-clip.md)
for cache, nesting, return-value, and state guarantees.

### Visual transforms

MGFX can rotate, scale, translate, tilt, and project drawing without taking
ownership of layout or input mapping.

```lua
local lift = MGFX.Transform({
    origin = "50% 50%",
    rotate = 4,
    scale = 1.02,
    translate = {x = 0, y = -2},
})

MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = Color(12, 20, 28, 220),
    transform = lift,
})
```

Use `PushTransform` / `PopTransform` to apply one transform to multiple draws.
`PointerTilt` and `ProjectedQuad` cover common 2.5D presentation cases.
Transforms are visual only; callers remain responsible for matching hit tests
and interaction coordinates.

---

## ⚡ Performance model

MGFX optimizes immediate rendering rather than hiding all work behind a large
general batching scheduler. Garry's Mod UI time is often lost to temporary
tables, repeated normalization, material parameter churn, and unnecessary
Source API calls—not draw count alone.

### What the hot path does

- Keeps common shape calls direct and immediate
- Parses public style tables once at the API boundary
- Passes prepared scalar/fill/stroke/effect values through internal layers
- Uploads hot parameters through shared matrix pages instead of many floats
- Reuses Matrix objects and material state
- Pools temporary frame, command, and rectangular-clip records
- Fuses only effect combinations that remain visually equivalent
- Caches pattern seeds, text measurements, glyph runs, and reusable coverage
- Offers allocation-light `RoundedBoxBackdrop`, `LineNoCaps`, and `ImageUV`
- Keeps readable CPU fallback routes where fidelity can degrade safely

Stable styles can be normalized once:

```lua
local style = MGFX.CompileStyle({
    radius = 12,
    fill = Color(15, 22, 30, 235),
    backdrop = {blur = 8, tint = Color(5, 12, 18, 100)},
})
```

### Shared backdrop comparison

For `N` blurred backdrop shapes at one level with no forced recapture:

```text
MGFX:       1 framebuffer capture + 2 separable blur passes + N masked samples
Naive path: N framebuffer captures + 2N blur passes + N masked samples
```

This reuse is level- and frame-specific; it does not make blur free.

### Measured baseline

A representative complex shop UI with many rounded surfaces, gradients,
strokes, shadows, glows, images, and text rows recently held:

```text
Full item list       stable 130+ FPS
Lighter categories   stable 160+ FPS
```

These are local in-game observations, not universal guarantees. A useful
benchmark should also report resolution, GPU/CPU, FPS cap/VSync, other HUD and
addon workload, median frame time, tail frame times, and enabled diagnostics.
Disable profiling and draw counters before measuring normal production cost.

See [Performance Notes](docs/PERFORMANCE.md) for the practical checklist and
current architecture.

---

## 📦 Installation

### Plain GLua addon

Use [`lua-mgfx/`](lua-mgfx/) as the addon root:

```text
garrysmod/
└── addons/
    └── mgfx/
        ├── lua/
        ├── materials/
        ├── resource/
        └── addon.json
```

Garry's Mod loads the autorun files automatically and exposes `MGFX.*` on the
client. Do not manually include internal files from `lua/mgfx`.

### Lux package

Install the public package from the repository root:

```powershell
luxc install @lux/mgfx --from github:TimeWatcher/lux-mgfx --tag v0.1.0
```

Or use a local checkout:

```powershell
luxc install @lux/mgfx --from C:\Development\gmod\lux-mgfx
```

```lux
import * as mgfx from "@lux/mgfx"

local draw = mgfx.api
draw.roundedBox(...)
draw.roundedBoxEx(...)
draw.imageEx(...)
draw.textEx(...)
```

The facade initializes its default runtime automatically. Only call
`mgfx.installGlobal("MGFX")` when non-Lux code intentionally needs the global
GLua-style table. Application code should not import primitive, widget, text,
or style internals as separate rendering entry points.

---

## 🚀 Quick start

```lua
function PANEL:Paint(w, h)
    MGFX.StartPanel(self, w, h)

    MGFX.RoundedBoxEx(0, 0, w, h, {
        radius = 10,
        fill = MGFX.LinearGradient(0, 0, 1, 1,
            Color(18, 28, 38, 235),
            Color(8, 14, 22, 240),
            "smoothstep"),
        shadow = {
            x = 0,
            y = 6,
            blur = 14,
            color = Color(0, 0, 0, 110),
        },
    })

    MGFX.ProgressBarEx(16, h - 24, w - 32, 8, 0.72, {
        radius = 4,
        track = Color(255, 255, 255, 18),
        fill = MGFX.LinearGradient(0, 0, 1, 0,
            Color(72, 220, 138),
            Color(120, 255, 186)),
    })

    MGFX.Text("READY", "DermaDefaultBold", 16, 18, color_white,
        TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    MGFX.EndPanel()
end
```

`StartPanel` makes coordinates panel-local. Use `StartScreen` / `EndScreen`
for `HUDPaint` and screen-space overlays. Direct primitive calls remain valid
when coordinated frame state is not needed.

---

## 🧪 Runtime tools

Useful client commands:

| Command | Purpose |
| --- | --- |
| `mgfx_status` | Shader mount, draw, blur, Clip, gradient, text, and material status |
| `mgfx_selftest` | Validate the installed public API and runtime invariants |
| `mgfx_reload` / `mgfx_hot_reload` | Reload MGFX development files |
| `mgfx_demo` | Open the main visual feature demo |
| `mgfx_stroke_demo` | Compare solid and patterned stroke variants |
| `mgfx_perf_demo` | Open the controlled renderer workload demo |
| `mgfx_wheel_demo` | Open the radial wheel demo |
| `mgfx_profile_status` | Print rolling profiler totals |
| `mgfx_profile_panels` | Inspect panel/screen scope costs |
| `mgfx_profile_hud` | Toggle the profiling overlay |
| `mgfx_profile_reset` | Reset profiler samples |
| `mgfx_text_status` | Inspect text composer/cache state |
| `mgfx_text_cache_clear` | Clear text measurement/cache state |
| `mgfx_text_atlas` | Inspect composed text atlas contents |

Useful client CVars:

```text
mgfx_force_fallback 0/1
mgfx_profile 0/1
mgfx_profile_window 120
mgfx_profile_top 18
mgfx_draw_counts 0/1
mgfx_text_composed 0/1
mgfx_text_composed_budget 6
```

Profiling and draw counters are opt-in because observation has a cost.

---

## 🛡️ Shader and fallback routing

Shader rendering is the normal path. Capability detection and readable CPU
fallbacks keep basic interfaces usable when shaders are missing, disabled, or
unsupported on a platform.

```lua
PrintTable(MGFX.ShaderStatus())

if MGFX.Supports(MGFX.TARGET.TEXT, "gradient") then
    -- Use composed display text.
end
```

Fallbacks may simplify procedural patterns, exact blur softness, glow, or text
composition. APIs that cannot degrade without violating their contract fail
explicitly instead: reusable coverage `Clip`, for example, has no stencil or
binary-edge fallback.

---

## 🛠️ Development and packaging

### Documentation site

The shared source lives in [`docs/`](docs/):

```powershell
npm install
npm run docs:dev
npm run docs:build
```

The local VitePress output is written to `docs-site/`. The public Pages site is
published from the separate `mgfx-docs-site` repository.

### Shader build

MGFX embeds compiled Source `.vcs` shaders in a Lua/Lux shaderpack that the
runtime mounts as a temporary GMA.

From the repository root:

```powershell
python .\lua-mgfx\shadersrc\mgfx\build.py
python .\lux-mgfx\lux\mgfx\shadersrc\build.py
```

Both source trees must remain synchronized when shared HLSL behavior changes.
The SDK helper tools are build-time infrastructure and must not ship in the
runtime addon.

### Lux precompiled output

```powershell
.\lux-mgfx\tools\build-precompiled.ps1
```

### Plain addon validation

The plain tree is intended to be GMA-valid:

```powershell
gmad.exe create -folder ".\lua-mgfx" -out "$env:TEMP\mgfx.gma"
```

`lua-mgfx/addon.json` excludes shader source, build tools, and Markdown from
the published runtime package.

---

## 🗂️ Repository layout

```text
docs/           Shared English and Chinese documentation source
lua-mgfx/       Canonical Plain GLua addon and its shader source
lux-mgfx/       Lux packages, shader source/tools, and generated distribution
scripts/        Shared repository/documentation tooling

package.json
lux.package.toml
README.md
LICENSE*
NOTICE
```

`lux-mgfx/dist/lua` is the Lux-generated loader distribution. It does not
replace `lua-mgfx/` as the canonical non-Lux implementation.

---

## 🧭 Maintenance principles

- Public draw calls remain immediate and explicit.
- Public style tables are normalized at the API boundary.
- Internal hot layers receive prepared values instead of repeatedly copying
  and normalizing style records.
- Common drawing calls avoid per-frame allocation.
- Patterns remain shader paint fields rather than geometry recipes.
- Coverage clipping uses continuous shader coverage, never stencil emulation.
- Native text stays the default for ordinary operational labels.
- Shader text is reserved for effects that need composition.
- Render-target, camera, matrix, scissor, blend, and alpha-write mutations use
  symmetric protected cleanup paths.
- Plain GLua, Lux, generated output, shaderpacks, Ashline integrations, and docs
  stay synchronized when shared behavior changes.
- A general batching layer requires representative in-game evidence, not only
  a synthetic microbenchmark.

---

## 📚 Documentation

- [Online documentation](https://timewatcher.github.io/mgfx-docs-site/)
- [Plain GLua quick start](docs/guide/glua.md)
- [Lux quick start](docs/guide/lux.md)
- [Core concepts](docs/guide/concepts.md)
- [Effects](docs/guide/effects.md)
- [Coverage Masks and antialiased Clip](docs/guide/masks-and-clip.md)
- [Complete Mask and Clip API](docs/api-reference/masks-and-clip.md)
- [API reference](docs/api-reference/index.md)
- [Performance notes](docs/PERFORMANCE.md)
- [Internal architecture](docs/ARCHITECTURE.md)
- [Text renderer](docs/TEXT.md)
- [Shader build and packaging](docs/SHADERS.md)

---

## 🌟 Recent highlights

- Reusable antialiased coverage Masks with exact Boolean composition
- Shape self-clipping callbacks and foreground stroke ordering
- Local bucketed custom-Mask accumulator/scratch targets
- Elliptical radial gradients for top-origin and anisotropic light fields
- Shader-native gradient curves, 16-bit stops LUTs, and stable dithering
- Mathematically fitted patterned-stroke periods and corrected start phases
- Centered `solid`, `dot`, `dash`, and `dot-dash` strokes across shape families
- Layered and shared backdrop blur
- Layered shadows and compatible shadow/outer-glow fusion
- Prepared style records and allocation-light raw helpers
- Native text measurement and per-character layout caching
- Failure-safe Clip render-state transactions and idempotent runtime install
- Synchronized Plain GLua, Lux, shaderpack, Ashline, and bilingual docs output

For exact implementation history, see the
[commit log](https://github.com/TimeWatcher/lux-mgfx/commits/main/).

---

## 🚧 What MGFX deliberately does not own

- Panel, flex, or grid layout
- Input dispatch and focus management
- Navigation and component state
- Data binding and animation timelines
- Panel lifecycle
- Hit testing and interaction-coordinate transforms

Use MGFX beneath Derma, a custom component system, Lux UI code, or an existing
gamemode framework. Keeping this boundary narrow is what lets MGFX focus on
rendering quality and predictable cost.

---

## 📜 License

MGFX source under `lux-mgfx/lux/mgfx/`, `lua-mgfx/lua/mgfx/`, and the shader
tooling is available under the **Lux MGFX Non-Commercial License**. Commercial
use requires separate written authorization from the copyright holder.

Documentation prose is available under CC BY 4.0. Documentation code examples
are licensed MIT OR Apache-2.0. Branding assets are not licensed for reuse by
those licenses.

Review [`LICENSE`](LICENSE), [`LICENSE-MGFX-NC`](LICENSE-MGFX-NC), and
[`NOTICE`](NOTICE) before distribution or commercial integration.

---

<p align="center">
  Built for Garry's Mod interfaces that need more than another stack of boxes. ✦
</p>
