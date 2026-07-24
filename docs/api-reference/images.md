# Images and Per-Image Masks

Image APIs draw materials, render targets, texture sources, and icons with optional fit, crop, mask, stroke, shadow, backdrop, and glow.

Plain GLua calls `MGFX.*`. Lux calls the same APIs as lowerCamelCase methods on `mgfx.api`.

## Functions

```lua
MGFX.Image(x, y, w, h, source, radius, tint)
MGFX.ImageUV(x, y, w, h, source, u0, v0, u1, v1, tint)
MGFX.ImageEx(x, y, w, h, source, style)

MGFX.Icon(x, y, w, h, source, tint)
MGFX.IconEx(x, y, w, h, source, style)

```

`ImageUV` is the allocation-free positional path for an already-known UV
rectangle. It intentionally skips fit, crop, masks, and effect-style parsing.

## Image Style Fields

| Field | Meaning |
| --- | --- |
| `fit` / `objectFit` | `"cover"`, `"contain"`, `"fill"`, or `"stretch"`. |
| `position` | Alignment for fitted content. |
| `crop` | Crop rectangle or crop table. |
| `uv` | Explicit UV rectangle. |
| `mask` | Image-mask record such as `{kind = "circle"}`, string alias, `false`, or `"none"`. |
| `radius` | Rounded mask radius for rounded image paths. |
| `tint` / `color` / `alpha` | Image tint and opacity. |
| `fill` / `background` | Background paint behind the image. |
| `stroke` / `strokeWidth` | Optional image border. |
| `shadow` | Mask-aware external soft shadow. |
| `outerGlow` | Mask-aware external glow. |
| `backdrop` | Mask-aware framebuffer blur/tint. |
| `transform` | Visual-only transform. |

## Fit Examples

::: code-group

```lua [GLua]
MGFX.ImageEx(x, y, 96, 96, avatarMaterial, {
    fit = "cover",
    mask = {kind = "chamfer", cuts = 12},
    stroke = Color(80, 190, 255, 120),
    strokeWidth = 1,
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

local draw = mgfx.api

draw.imageEx(x, y, 96, 96, avatarMaterial, {
  fit = "cover",
  mask = {kind = "chamfer", cuts = 12},
  stroke = Color(80, 190, 255, 120),
  strokeWidth = 1,
});
```

:::

Use `cover` for avatars and `contain` for icons or item art that must remain fully visible.

## Masks

```lua
{kind = "rounded", radius = 8}
{kind = "chamfer", cuts = {12, 4, 12, 4}}
{kind = "circle"}
{kind = "capsule"}
```

Texture masks can use alpha or color channels depending on the source. Prefer procedural masks for common rounded/chamfer/circle/capsule cases.

These records belong to one `ImageEx` draw. They are intentionally different from reusable `MGFX.Mask(painter)` coverage objects used by [`MGFX.Clip`](./masks-and-clip).

Mask-aware `shadow` and `outerGlow` can share one fused shader pass. `backdrop` still samples and tints only the content behind the image or mask coverage.

## Icons

`IconEx` is the image path tuned for icon usage. It usually uses `contain`-style behavior and tinting.

```lua
MGFX.IconEx(x, y, 32, 32, material, {
    tint = Color(220, 245, 255),
    outerGlow = {color = Color(80, 190, 255, 70), width = 8},
})
```

[Back to API Reference](./index)
