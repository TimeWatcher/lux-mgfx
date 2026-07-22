# Paint, Patterns, Transforms, and Capabilities

Paint helpers create records consumed by shape, image, widget, and text style fields.

Plain GLua calls `MGFX.*`. Lux calls the same helpers as lowerCamelCase methods on `mgfx.api`.

## Paint Functions

```lua
MGFX.Solid(color)

MGFX.LinearGradient(x1, y1, x2, y2, colorA, colorB)
MGFX.LinearGradientStops(x1, y1, x2, y2, stops)

MGFX.RadialGradient(cx, cy, radius, colorA, colorB)
MGFX.ConicGradient(cx, cy, rotationDeg, stops)

MGFX.ShapeAngularGradient(stops, rotationDeg)
MGFX.RingRadialGradient(stops)
MGFX.RingAngularGradient(stops, rotationDeg)
MGFX.SectorRadialGradient(stops)
MGFX.SectorAngularGradient(stops, rotationDeg)
```

Stops can use compact or named forms:

::: code-group

```lua [GLua]
local fill = MGFX.LinearGradientStops(0, 0, 1, 0, {
    {0.00, Color(80, 170, 255)},
    {pos = 0.55, color = Color(90, 220, 180)},
    {offset = 1.00, color = Color(255, 210, 90)},
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

local draw = mgfx.api

local fill = draw.linearGradientStops(0, 0, 1, 0, {
  {0.00, Color(80, 170, 255)},
  {pos = 0.55, color = Color(90, 220, 180)},
  {offset = 1.00, color = Color(255, 210, 90)},
})
```

:::

## Patterns

```lua
MGFX.StripePattern({
    color = Color(255, 255, 255, 18),
    spacing = 10,
    width = 2,
    angle = 135,
})

MGFX.SmokePattern({
    color = Color(80, 170, 255, 24),
    scale = 140,
    density = 0.45,
    softness = 0.32,
    seed = "panel",
})

MGFX.WornPattern({
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
    seed = "shop-card",
})
```

Patterns should be passed as `style.pattern`, `fillPattern`, or `trackPattern`. Do not emulate stripes, smoke, or worn surface texture with many primitive calls.

`WornPattern` is a shader-native surface pass. It combines subtle dulling, fine roughness, directional hairline scratches, sparse soft scuffs, and broken edge wear without using render targets or data textures. It uses matrix parameter pages (`c11` and `c15`) and intentionally avoids `$c0..$c3` float uploads.

Recommended `WornPattern` ranges:

| Field | Practical Range | Meaning |
| --- | --- | --- |
| `color / tint` | alpha `24..70` | Main worn overlay. Dark tint lowers brightness/contrast; light tint can be used on dark metal. |
| `edgeColor / highlight` | alpha `40..120` | Broken edge highlight. Keep it material-colored, not pure white. |
| `fractal` | `0.20..0.70` | Sparse soft scuff intensity. It should create uneven worn patches, not smoke. |
| `grain` | `0.35..0.90` | Fine surface roughness and contrast breakup. This is the main "not perfectly smooth" control. |
| `scratches` | `0.12..0.55` | Sparse short scratch density. Raise slowly; too high becomes random drawn lines. |
| `edge` | `0.25..0.85` | Broken edge wear intensity inside the shape boundary. |
| `scale` | `24..48` | Soft scuff scale in pixels. Lower values look busier; higher values look cleaner. |
| `grainScale` | `3.5..7` | Fine roughness density. |
| `scratchScale` | `20..34` | Scratch cell spacing. Larger values produce fewer, farther-apart scratches. |
| `scratchWidth` | `0.03..0.07` | Scratch thickness. Keep narrow for UI. |
| `edgeWidth` | `4..9` | Edge-wear band width in pixels. |
| `angle` | degrees | Scratch direction. |
| `softness` | reserved | Kept in the pattern record for compatibility with older tuning presets. |
| `warp` | `0..0.08` | Slightly bends the procedural field. Keep low for UI panels. |
| `offset / speed` | number | Sampling offset; speed animates when the caller wants motion. |
| `seed` | number or string | Stable variation seed. |

Tuning notes:

- For dark inventory/shop cards, start with the default values above and adjust only `color.a` and `edgeColor.a` first.
- `grain` gives the surface roughness; `fractal` gives larger uneven scuffs; `scratches` should remain sparse.
- Edge wear should be broken and local. If it reads as inner glow or a continuous border, lower `edge`, `edgeColor.a`, or `edgeWidth`.

## Transforms

```lua
local transform = MGFX.Transform({
    origin = "50% 50%",
    rotate = 6,
    scale = 1.02,
    translate = {x = 0, y = -2},
})

local tilt = MGFX.PointerTilt(mx, my, {
    perspective = 900,
    maxRotateX = 4,
    maxRotateY = 6,
})
```

Use `style.transform` for a single draw call:

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = Color(12, 20, 28, 210),
    transform = tilt,
})
```

Use a transform stack for multiple calls:

```lua
if MGFX.PushTransform(transform, x, y, w, h) then
    MGFX.RoundedBoxEx(x, y, w, h, panelStyle)
    MGFX.RingEx(cx, cy, 42, 6, ringStyle)
    MGFX.PopTransform()
end
```

Transforms are visual only. They do not change layout, hit testing, or input coordinates.

## Projected Quads

`ProjectedQuad` is an expert helper for perspective-like visual quads. Prefer `Transform` or `PointerTilt` unless you need explicit corner positions.

```lua
local q = MGFX.ProjectedQuad({
    tl = {x = x + 8, y = y},
    tr = {x = x + w - 3, y = y + 5},
    br = {x = x + w, y = y + h},
    bl = {x = x, y = y + h - 7},
    steps = 12,
})
```

## Capability Queries

```lua
MGFX.GetCapabilities(target)
MGFX.Supports(target, key)
```

Common targets:

| Target | Meaning |
| --- | --- |
| `MGFX.TARGET.ROUNDED_BOX` | Rounded box, circle, capsule family. |
| `MGFX.TARGET.CHAMFER_BOX` | Chamfer box. |
| `MGFX.TARGET.POLY` | Convex polygon. |
| `MGFX.TARGET.LINE` | Line primitive. |
| `MGFX.TARGET.IMAGE` | Image and icon mask path. |
| `MGFX.TARGET.PROGRESS_BAR` | Progress bar. |
| `MGFX.TARGET.SEGMENT_BAR` | Segment bar. |
| `MGFX.TARGET.TEXT` | Text route. |

Capabilities describe implemented render slots, not future plans.

[Back to API Reference](./index)
