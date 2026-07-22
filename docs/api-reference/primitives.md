# Shapes and Lines

These APIs draw shape-level building blocks. Advanced visual effects live in the `Ex` style table.

Plain GLua calls `MGFX.*`. Lux calls the same APIs as lowerCamelCase methods on `mgfx.api`.

## Functions

```lua [GLua]
MGFX.RoundedBox(x, y, w, h, radius, fill, stroke, strokeWidth)
MGFX.RoundedBoxBackdrop(x, y, w, h, radius, backdrop)
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
MGFX.LineNoCaps(x1, y1, x2, y2, width, fill)
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
| `backdrop` | Shape-clipped framebuffer blur/tint. Table form accepts integer `level` and explicit `recapture`. |
| `pattern` | Shader pattern such as `StripePattern`, `SmokePattern`, or `WornPattern`. |
| `transform` | Visual-only transform record. |

For repeated hot-path draws, normalize tables once with
`MGFX.CompileStyle(style, target)` or `MGFX.CompileBackdrop(backdrop)`, then
reuse the returned record. `RoundedBoxBackdrop` is the positional backdrop-only
path; `LineNoCaps` draws a line whose endpoints are not extended by half its
width. These APIs avoid constructing a temporary style table per draw.

## Shape Stroke Styles

Shape strokes are centered on the shape boundary: half of the width is drawn
inside and half outside. The existing `stroke = Color(...)` plus
`strokeWidth` API remains supported. To select a line pattern, pass a stroke
record instead:

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

| Stroke field | Meaning |
| --- | --- |
| `color` | Required stroke `Color`. `tint` is accepted as an alias. |
| `width` | Stroke width in pixels. A separate `style.strokeWidth` takes precedence for compatibility. |
| `kind` | `"solid"`, `"dot"`, `"dash"`, or `"dot-dash"`; defaults to `"solid"`. |
| `length` | Visible dash length in pixels. |
| `gap` | Spacing between dots or dashes in pixels. |
| `offset` | Pattern phase in pixels; animate it to move the pattern. |

Patterned strokes use a separate stroke pass so fills, gradients, shadows,
glows, and backdrop effects retain their existing paths. The record is
supported by rounded boxes, chamfer boxes, circles, capsules, convex polygon
shapes, progress/segment bars, rings, arcs, and sectors. Unknown `kind` values
raise an error instead of silently becoming solid.

## Rounded Boxes

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(18, 24, 32, 220),
    stroke = Color(255, 255, 255, 32),
    strokeWidth = 1,
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

local draw = mgfx.api

draw.roundedBoxEx(x, y, w, h, {
  radius = 10,
  fill = Color(18, 24, 32, 220),
  stroke = Color(255, 255, 255, 32),
  strokeWidth = 1,
});
```

:::

`radius` accepts a number or `{tl, tr, br, bl}`.

`RoundedBoxEx.shadow` can also be an array of shadow specs for CSS-style layered
box shadows:

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(18, 24, 32, 220),
    shadow = {
        {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 90)},
        {x = 0, y = 8, blur = 24, color = Color(0, 0, 0, 80)},
    },
})
```

The renderer loops only the shadow path for these layers. It does not repeat
fill, stroke, backdrop, pattern, or inner glow work.

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

Blurred backdrops share a framebuffer capture and completed two-axis blur per
engine frame, integer `level`, and intensity. Later matching shapes only perform
one masked sample. A higher `{blur = value, level = 1}` captures after lower
layers have drawn. Changing intensity reruns the axes from the current level's
raw capture; `recapture = true` forces a newer source inside that level.
Tint-only backdrops do not use the shared blur resource.

For rounded boxes and chamfer boxes, compatible `shadow` and `outerGlow` layers may be rendered by one fused shader pass. The style fields and visual semantics remain separate.

[Back to API Reference](./index)
