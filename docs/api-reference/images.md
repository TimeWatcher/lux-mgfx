# Images and Masks

Image APIs draw materials, render targets, texture sources, and icons with optional fit, crop, mask, stroke, backdrop, and glow.

## Functions

```lua
MGFX.Image(x, y, w, h, source, radius, tint)
MGFX.ImageEx(x, y, w, h, source, style)

MGFX.Icon(x, y, w, h, source, tint)
MGFX.IconEx(x, y, w, h, source, style)

MGFX.Mask(kind, options)
MGFX.MaterialSource(material)
MGFX.TextureSource(texture)
```

## Image Style Fields

| Field | Meaning |
| --- | --- |
| `fit` / `objectFit` | `"cover"`, `"contain"`, `"fill"`, or `"stretch"`. |
| `position` | Alignment for fitted content. |
| `crop` | Crop rectangle or crop table. |
| `uv` | Explicit UV rectangle. |
| `mask` | `MGFX.Mask(...)`, string alias, `false`, or `"none"`. |
| `radius` | Rounded mask radius for rounded image paths. |
| `tint` / `color` / `alpha` | Image tint and opacity. |
| `fill` / `background` | Background paint behind the image. |
| `stroke` / `strokeWidth` | Optional image border. |
| `outerGlow` | Mask-aware external glow. |
| `backdrop` | Mask-aware framebuffer blur/tint. |
| `transform` | Visual-only transform. |

## Fit Examples

```lua
MGFX.ImageEx(x, y, 96, 96, avatarMaterial, {
    fit = "cover",
    mask = MGFX.Mask("chamfer", {cuts = 12}),
    stroke = Color(80, 190, 255, 120),
    strokeWidth = 1,
})
```

Use `cover` for avatars and `contain` for icons or item art that must remain fully visible.

## Masks

```lua
MGFX.Mask("rounded", {radius = 8})
MGFX.Mask("chamfer", {cuts = {12, 4, 12, 4}})
MGFX.Mask("circle")
MGFX.Mask("capsule")
```

Texture masks can use alpha or color channels depending on the source. Prefer procedural masks for common rounded/chamfer/circle/capsule cases.

## Icons

`IconEx` is the image path tuned for icon usage. It usually uses `contain`-style behavior and tinting.

```lua
MGFX.IconEx(x, y, 32, 32, material, {
    tint = Color(220, 245, 255),
    outerGlow = {color = Color(80, 190, 255, 70), width = 8},
})
```

[Back to API Reference](./index)
