# Paint, Patterns, Transforms, and Capabilities

Paint helpers create records consumed by shape, image, widget, and text style fields.

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

```lua
local fill = MGFX.LinearGradientStops(0, 0, 1, 0, {
    {0.00, Color(80, 170, 255)},
    {pos = 0.55, color = Color(90, 220, 180)},
    {offset = 1.00, color = Color(255, 210, 90)},
})
```

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
```

Patterns should be passed as `style.pattern`, `fillPattern`, or `trackPattern`. Do not emulate stripes or smoke with many primitive calls.

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
