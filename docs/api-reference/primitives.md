# Primitive API

Primitive APIs draw shape-level building blocks. Advanced visual effects live in the `Ex` style table.

## Functions

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

## Shared Style Fields

| Field | Meaning |
| --- | --- |
| `fill` / `color` | Color or paint record used for the shape body. |
| `stroke` / `strokeWidth` | Optional border color and width. |
| `shadow` | External soft shadow. `x/y` moves the shadow shape. |
| `outerGlow` | External glow. `x/y` biases glow direction without moving the source shape. |
| `innerGlow` | Inner edge glow for supported shapes. |
| `backdrop` | Shape-clipped framebuffer blur/tint. |
| `pattern` | Shader pattern such as `StripePattern` or `SmokePattern`. |
| `transform` | Visual-only transform record. |

## Rounded Boxes

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(18, 24, 32, 220),
    stroke = Color(255, 255, 255, 32),
    strokeWidth = 1,
})
```

`radius` accepts a number or `{tl, tr, br, bl}`.

## Chamfer Boxes

```lua
MGFX.ChamferBoxEx(x, y, w, h, {
    cuts = {24, 8, 24, 8},
    fill = Color(5, 12, 18, 180),
    outerGlow = {color = Color(60, 180, 255, 76), width = 14, x = 8, y = -4},
})
```

`cuts` accepts a number or `{tl, tr, br, bl}`.

## Convex Polygons

```lua
MGFX.PolyEx({
    {x = x, y = y},
    {x = x + 96, y = y + 20},
    {x = x + 76, y = y + 72},
}, {
    fill = Color(80, 170, 255, 90),
    outerGlow = {color = Color(80, 170, 255, 80), width = 12},
})
```

`PolyEx` accepts 3..8 convex points. Complex shapes should be split into convex pieces.

## Lines

```lua
MGFX.LineEx(x1, y1, x2, y2, {
    width = 3,
    fill = Color(80, 170, 255),
    caps = false,
})
```

Use `caps = false` or `noCaps = true` for square-ended line quads.

## Shape-aware Effects

`shadow`, `outerGlow`, `backdrop`, and `pattern` are clipped or evaluated against the current shape where supported. `outerGlow.x/y` is directional glow bias, not a duplicate shifted shape. Use `shadow.x/y` when you want a projected offset.

[Back to API Reference](./index)
