# Effects

`shadow`, `outerGlow`, `innerGlow`, `backdrop`, and `pattern` are style fields on the shape, image, widget, or text call that owns the coverage. They are not separate layout objects.

## Shadow, Glow, Backdrop

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = Color(8, 14, 20, 180),
    shadow = {x = 0, y = 8, blur = 18, spread = 2, color = Color(0, 0, 0, 120)},
    outerGlow = {width = 12, color = Color(70, 205, 255, 64)},
    backdrop = {blur = 6, tint = Color(0, 8, 12, 110)},
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

local draw = mgfx.api

draw.roundedBoxEx(x, y, w, h, {
  radius = 12,
  fill = Color(8, 14, 20, 180),
  shadow = {x = 0, y = 8, blur = 18, spread = 2, color = Color(0, 0, 0, 120)},
  outerGlow = {width = 12, color = Color(70, 205, 255, 64)},
  backdrop = {blur = 6, tint = Color(0, 8, 12, 110)},
});
```

:::

| Field | Meaning | Typical Use |
| --- | --- | --- |
| `shadow` | External soft projected shadow. `x/y` moves the shadow shape. | Lift cards and panels. |
| `outerGlow` | External glow around the source coverage. `x/y` biases the glow direction. | Selection, rarity, energy edges. |
| `innerGlow` | Edge light clipped inside the source coverage. | Subtle bevel or polished rim. |
| `backdrop` | Framebuffer blur/tint inside the shape or image mask. | Frosted glass and translucent panels. |
| `pattern` | Shader paint layer clipped to the source coverage. | Stripes, smoke, worn material surfaces. |

`backdrop` is not a shadow. It only samples and tints the background inside the current shape or image mask.

## Layered Shadows

Rounded boxes support CSS-style layered shadows:

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(18, 24, 32, 220),
    shadow = {
        {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 90)},
        {x = 0, y = 8, blur = 24, color = Color(0, 0, 0, 80)},
    },
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

mgfx.api.roundedBoxEx(x, y, w, h, {
  radius = 10,
  fill = Color(18, 24, 32, 220),
  shadow = {
    {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 90)},
    {x = 0, y = 8, blur = 24, color = Color(0, 0, 0, 80)},
  },
});
```

:::

MGFX loops only the shadow path for those layers. It does not redraw fill, stroke, backdrop, pattern, or inner glow for every shadow.

## Shared Backdrop Blur

Backdrop blur is shared by `level` inside an engine render frame. Same-level,
same-intensity backdrops reuse one capture and two-axis blur. A higher
`backdrop = {blur = 8, level = 1}` captures at that draw point and can include
level `0` UI beneath it. Changing only the intensity reruns the blur axes from
the current level's raw capture; use `recapture = true` only to force a newer
source inside the same level.

## Patterns

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 8,
    fill = Color(28, 34, 40, 235),
    pattern = MGFX.WornPattern({
        color = Color(0, 0, 0, 44),
        edgeColor = Color(218, 208, 184, 78),
        grain = 0.64,
        scratches = 0.30,
        edge = 0.54,
        seed = "inventory-card",
    }),
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

local draw = mgfx.api
draw.roundedBoxEx(x, y, w, h, {
  radius = 8,
  fill = Color(28, 34, 40, 235),
  pattern = draw.wornPattern({
    color = Color(0, 0, 0, 44),
    edgeColor = Color(218, 208, 184, 78),
    grain = 0.64,
    scratches = 0.30,
    edge = 0.54,
    seed = "inventory-card",
  }),
});
```

:::

Patterns are shader paint slots. Do not emulate stripes, smoke, or worn surface texture by drawing many extra boxes, lines, or polygons.

For exact fields and ranges, see [Paint, Patterns, Transforms](../api-reference/paint).
