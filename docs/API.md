# MGFX API Overview

MGFX is a low-level immediate renderer for Garry's Mod. It draws explicit arguments supplied by your code every frame. It does not own layout, input, focus, component lifecycle, animation state, or hit testing.

For full per-function tables, caveats, return values, and examples, use the grouped [API Reference](./api-reference/).

## Basic Model

Public drawing functions use two layers:

```text
Name(...)    short hot-path signature for simple drawing
NameEx(...)  table style signature for advanced effects and readable arguments
```

Non-`Ex` functions keep stable short parameters. Advanced features such as shadow, glow, pattern, backdrop, mask, fit/crop, transform, and per-corner radius belong in the `Ex` style table.

All draw arguments are explicit. MGFX has no global fill/stroke state.

Stroke order is always:

```lua
fill, stroke, strokeWidth
```

`stroke == nil`, `strokeWidth == nil`, or `strokeWidth <= 0` means no stroke.

## Pick the API by What You Draw

| Need | Preferred API | When to use `Ex` or a specialized API |
| --- | --- | --- |
| Panels, buttons, rows | `RoundedBox` / `RoundedBoxEx` | Use `RoundedBoxEx` for shadow, backdrop, glow, pattern, or per-corner radius. |
| Sci-fi chamfer panels | `ChamferBoxEx` | `cuts = 6..14` works well for HUD cards; use `{tl, tr, br, bl}` for per-corner cuts. |
| Badges and regular shapes | `RegularPoly` / `RegularPolyEx` | `sides = 3..8`; use `sides = 3` for an equilateral triangle. |
| Direction arrows | `Caret` / `CaretEx` | Use `direction = "left"`, `"right"`, `"up"`, or `"down"`. |
| Convex custom polygons | `PolyEx` | Pass 3..8 convex points. Split complex paths into convex pieces. |
| Avatars, icons, loadout art | `ImageEx` / `IconEx` | Use `fit = "cover"` for avatars and `fit = "contain"` for full icons. |
| Health, ammo, loading bars | `ProgressBarEx` | `h = 8..18`, `padding = 1..3`, `radius = h * 0.5` is a good default. |
| Discrete charge or ammo cells | `SegmentBarEx` | `segments = 6..24` is common; ensure each segment remains wider than the gap. |
| Circular meters | `RingEx` / `ArcEx` | Small HUD rings often use `width = 4..12`; large meters use `12..24`. |
| Radial menu wedges | `SectorEx` | Use `innerRadius`, `outerRadius`, `startDeg`, and `endDeg` for real sectors. |
| Plain text, tables, player names | `Text` or native GMod text | Use `TextEx` only for stroke, glow, gradient face, or shader-side shadow. |
| Gradients and patterns | `LinearGradient`, `RadialGradient`, `StripePattern`, `SmokePattern`, `WornPattern` | Pass them as `fill` or `pattern`; do not expand them into many primitives. |

## Lux Usage

Lux users should import the public facade:

```lux
import * as mgfx from "@lux/mgfx"

client fn drawPanel() {
  mgfx.api.roundedBoxEx(16, 16, 220, 48, {
    radius = 8,
    fill = mgfx.api.linearGradient(
      0, 0, 1, 0,
      Color(80, 170, 255),
      Color(90, 220, 180)
    ),
  })
}
```

`mgfx.api` initializes the default runtime. You do not need to import primitive/widget internals or call `installGlobal` for normal Lux code. The old `@lux/mgfx/paint` package has been removed; paint records such as gradients and patterns are created through `mgfx.api` helpers and passed as `fill` or `pattern` values.

## Plain GLua Usage

MGFX also ships a precompiled GLua runtime. It is intended for projects that do not use Lux at all.

Load the bundled loader once, then call the global API:

```lua
include("mgfx/loader_client.lua")

hook.Add("HUDPaint", "MyMGFXHud", function()
    MGFX.StartScreen(ScrW(), ScrH())

    MGFX.ChamferBoxEx(64, 64, 360, 120, {
        cuts = {24, 8, 24, 8},
        fill = Color(5, 12, 18, 180),
        backdrop = {blur = 6, tint = Color(0, 0, 0, 70)},
        outerGlow = {
            color = Color(60, 180, 255, 76),
            width = 14,
            x = 8,
            y = -4,
        },
    })

    MGFX.EndScreen()
end)
```

`installGlobal("MGFX")` is the plain-GLua bridge. The precompiled loader calls it for the default runtime, so normal GLua users can use `MGFX.RoundedBoxEx`, `MGFX.ImageEx`, `MGFX.ProgressBarEx`, and the rest of the API directly.

## Frame Scope

```lua
MGFX.StartPanel(panel, w, h)
MGFX.EndPanel()

MGFX.StartScreen(w, h)
MGFX.EndScreen()

MGFX.PushClip(x, y, w, h)
MGFX.PopClip()
```

All coordinates are relative to the current active frame. `StartPanel` reads the panel's screen position and establishes panel-local coordinates. Callers should not manually convert panel-local positions to screen positions.

Shapes, images, and HUD meters are usually drawn immediately. Text and clip commands are recorded inside the frame and flushed at `EndPanel` / `EndScreen`, so text routing and the composer remain stable.

`PushClip` / `PopClip` are rectangular scissor operations. Arbitrary shape masks are handled by each primitive's own shader coverage.

## Shape Functions

```lua
MGFX.RoundedBox(x, y, w, h, radius, fill, stroke, strokeWidth)
MGFX.RoundedBoxEx(x, y, w, h, style)

MGFX.ChamferBox(x, y, w, h, cuts, fill, stroke, strokeWidth)
MGFX.ChamferBoxEx(x, y, w, h, style)

MGFX.RegularPoly(cx, cy, radius, sides, rotation, fill, stroke, strokeWidth)
MGFX.RegularPolyEx(cx, cy, radius, sides, style)

MGFX.Diamond(x, y, w, h, fill, stroke, strokeWidth)
MGFX.DiamondEx(x, y, w, h, style)

MGFX.Caret(x, y, w, h, direction, fill, stroke, strokeWidth)
MGFX.CaretEx(x, y, w, h, style)

MGFX.Poly(points, fill, stroke, strokeWidth)
MGFX.PolyEx(points, style)

MGFX.Line(x1, y1, x2, y2, width, fill)
MGFX.LineEx(x1, y1, x2, y2, style)

MGFX.Circle(cx, cy, radius, fill, stroke, strokeWidth)
MGFX.CircleEx(cx, cy, radius, style)

MGFX.Capsule(x, y, w, h, fill, stroke, strokeWidth)
MGFX.CapsuleEx(x, y, w, h, style)
```

`RoundedBoxEx` uses `style.radius`, `ChamferBoxEx` uses `style.cuts`, and `LineEx` uses `style.width`. `Poly` and `PolyEx` accept convex polygons only.

## Shadow, Glow, and Backdrop

`shadow`, `outerGlow`, and `backdrop` are separate style fields:

- `shadow` is a soft external shadow pass. It defaults to `x = 0, y = 4` and is meant for projection.
- `outerGlow` is an external glow pass. It defaults to no offset and is meant for luminous edges.
- `outerGlow.x/y` is directional bias for one-sided glow. It does not move the source shape like `shadow.x/y` does.
- `backdrop` blurs and tints the framebuffer inside the current shape or image mask. It is not a shadow.

The first blurred backdrop in an engine render frame captures the framebuffer,
finishes both full-screen blur axes, and establishes the shared source and
intensity. Later backdrops reuse it with a single masked texture sample.
If a later backdrop must see content drawn after that capture, or must establish
a different blur intensity, opt in explicitly with
`backdrop = {blur = 8, recapture = true}`. The new capture is then reused by
subsequent backdrops in the same frame. Tint and opacity remain per shape;
tint-only backdrops do not capture the framebuffer.

`shadow` and `outerGlow` stay separate style fields, but compatible rounded-box, chamfer, ring, and image-mask paths may evaluate both in one fused shader pass. This is an implementation optimization; the CSS-like shadow mask and exterior glow semantics do not change.

`RoundedBoxEx.shadow` may be a single shadow spec or an array of specs. Use the
array form for CSS-style layered shadows instead of drawing the same rounded box
several times with different shadow-only styles. MGFX parses the list once, draws
each shadow layer through the shadow-only path, and draws fill, stroke, backdrop,
pattern, and inner glow once.

| Goal | Field | Typical value |
| --- | --- | --- |
| Lift a control from the background | `shadow` | `{x = 0, y = 4, blur = 10, spread = 1, color = Color(0,0,0,120), softness = 0.68}` |
| Add selected-edge light | `outerGlow` | `{width = 12, color = Color(80,190,255,72), softness = 0.58}` |
| Push glow to one side | `outerGlow` | `{x = 8, y = -4, width = 16, color = Color(80,190,255,72)}` |
| Frosted glass panel | `backdrop` | `{blur = 5, tint = Color(8,14,24,110), opacity = 1}` |
| Inner edge polish | `innerGlow` | `{width = 6, color = Color(255,255,255,34), softness = 0.70}` |

Example:

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    shadow = {
        {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 90)},
        {x = 0, y = 8, blur = 18, spread = 2, color = Color(0, 0, 0, 120), softness = 0.62},
    },
    outerGlow = {
        x = 8,
        y = -4,
        width = 16,
        color = Color(70, 205, 255, 76),
        softness = 0.55,
    },
})
```

## Images and Masks

```lua
MGFX.Image(x, y, w, h, source, radius, tint)
MGFX.ImageEx(x, y, w, h, source, style)

MGFX.Icon(x, y, w, h, source, tint)
MGFX.IconEx(x, y, w, h, source, style)
```

Use `ImageEx` when you need `fit`, `crop`, `uv`, `mask`, `shadow`, `outerGlow`, background fill, or advanced stroke.

Mask examples:

```lua
MGFX.ImageEx(x, y, size, size, avatarMaterial, {
    fit = "cover",
    mask = MGFX.Mask("chamfer", {cuts = 10}),
    stroke = Color(80, 190, 255, 120),
    strokeWidth = 1,
})
```

## HUD Meters and Sectors

```lua
MGFX.ProgressBarEx(x, y, w, h, value, style)
MGFX.SegmentBarEx(x, y, w, h, value, style)
MGFX.RingEx(cx, cy, radius, width, style)
MGFX.ArcEx(cx, cy, radius, width, startDeg, endDeg, style)
MGFX.SectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, style)
```

Widgets are still immediate primitives. They do not store state. Pass the current value every frame.

## Text

Plain text should remain native where possible. MGFX text APIs are for explicit effects:

```lua
MGFX.Text("READY", "DermaLarge", x, y, Color(220, 245, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

MGFX.TextEx("OVERTIME", "DermaLarge", x, y, {
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(255, 210, 90), Color(255, 80, 70)),
    glow = {color = Color(255, 96, 78, 120), blur = 10},
    shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 150)},
})
```

## Paint Records

Paint helpers return records consumed by `fill`, `track`, `pattern`, and related fields:

```lua
MGFX.Solid(color)
MGFX.LinearGradient(x1, y1, x2, y2, colorA, colorB)
MGFX.LinearGradientStops(x1, y1, x2, y2, stops)
MGFX.RadialGradient(cx, cy, radius, colorA, colorB)
MGFX.ConicGradient(cx, cy, rotationDeg, stops)
MGFX.StripePattern(options)
MGFX.SmokePattern(options)
MGFX.WornPattern(options)
```

Patterns are shader paint slots. Do not draw smoke, stripes, or worn surface texture by emitting many primitive calls.

`WornPattern` adds subtle material wear to otherwise flat UI fills. It is an independent shader pass over the source shape. The intended look is a slightly dulled rough surface, sparse fine scratches, occasional soft scuffs, and broken edge wear. It is not a smoke/noise/grunge decal and should not create a continuous dirty border:

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 8,
    fill = Color(28, 34, 40, 235),
    pattern = MGFX.WornPattern({
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
    }),
})
```

Good starting ranges: `fractal = 0.20..0.70`, `grain = 0.35..0.90`, `scratches = 0.12..0.55`, `edge = 0.25..0.85`, `scale = 24..48`, `grainScale = 3.5..7`, `scratchScale = 20..34`, `scratchWidth = 0.03..0.07`, `edgeWidth = 4..9`, `warp = 0..0.08`. `fractal` controls sparse soft scuffs, `grain` controls fine roughness, `scratches` controls short hairline marks, and `edge` controls broken edge wear. Increase one layer at a time; high `scratches` plus high `edgeColor` alpha turns into drawn lines instead of natural wear.

## Visual Transforms

Transforms are visual-only. They affect drawing, not layout or hit testing.

```lua
local tilt = MGFX.PointerTilt(mx, my, {
    perspective = 900,
    maxRotateX = 4,
    maxRotateY = 6,
})

MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = Color(12, 20, 28, 210),
    transform = tilt,
})
```

For repeated draws under the same transform, use:

```lua
if MGFX.PushTransform(transform, x, y, w, h) then
    MGFX.RoundedBoxEx(x, y, w, h, style)
    MGFX.RingEx(cx, cy, 42, 6, ringStyle)
    MGFX.PopTransform()
end
```

## Capability Queries

```lua
local caps = MGFX.GetCapabilities(MGFX.TARGET.POLY)
if MGFX.Supports(MGFX.TARGET.POLY, "outerGlow") then
    MGFX.PolyEx(points, {fill = Color(30, 80, 120), outerGlow = {width = 12}})
end
```

Capabilities describe implemented render slots, not future plans.
