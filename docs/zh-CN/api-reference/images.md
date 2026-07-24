# 图像与单图遮罩

图像 API 用于绘制材质、render target、纹理来源和图标，并支持 fit、crop、单图遮罩、描边、阴影、backdrop 与 glow。

普通 GLua 调用 `MGFX.*`；Lux 通过 `mgfx.api` 上对应的 lowerCamelCase 方法调用同一组 API。

## 函数

```lua
MGFX.Image(x, y, w, h, source, radius, tint)
MGFX.ImageUV(x, y, w, h, source, u0, v0, u1, v1, tint)
MGFX.ImageEx(x, y, w, h, source, style)

MGFX.Icon(x, y, w, h, source, tint)
MGFX.IconEx(x, y, w, h, source, style)
```

`ImageUV` 是已知 UV 矩形的低分配 positional 路径，刻意跳过 fit、crop、mask 和 effect style 解析。

## Image style 字段

| 字段 | 说明 |
| --- | --- |
| `fit` / `objectFit` | `"cover"`、`"contain"`、`"fill"` 或 `"stretch"`。 |
| `position` | fit 后内容的对齐位置。 |
| `crop` | 裁切矩形或 crop table。 |
| `uv` | 显式 UV 矩形。 |
| `mask` | `{kind = "circle"}` 这样的单图 mask record、字符串别名、`false` 或 `"none"`。 |
| `radius` | rounded image path 的圆角半径。 |
| `tint` / `color` / `alpha` | 图像 tint 与透明度。 |
| `fill` / `background` | 图像后方的背景 paint。 |
| `stroke` / `strokeWidth` | 可选图像边框。 |
| `shadow` | 感知 mask 的外部柔和阴影。 |
| `outerGlow` | 感知 mask 的外部 glow。 |
| `backdrop` | 感知 mask 的 framebuffer blur/tint。 |
| `transform` | 仅影响视觉的 transform。 |

## Fit 示例

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

头像通常使用 `cover`；必须完整显示的图标或物品图使用 `contain`。

## 单图遮罩

```lua
{kind = "rounded", radius = 8}
{kind = "chamfer", cuts = {12, 4, 12, 4}}
{kind = "circle"}
{kind = "capsule"}
```

纹理遮罩使用普通 style record：

```lua
MGFX.ImageEx(x, y, w, h, sourceMaterial, {
    fit = "cover",
    mask = {
        kind = "texture",
        source = maskMaterial,
        channel = "a", -- a, r, g, b, luma
        invert = false,
        uv = {u0 = 0, v0 = 0, u1 = 1, v1 = 1},
    },
})
```

常见 rounded/chamfer/circle/capsule 情况应优先使用 procedural mask。上述 record 只属于当前一次 `ImageEx` 绘制，与 [`MGFX.Mask(painter)` + `MGFX.Clip`](./masks-and-clip) 使用的可复用 coverage Mask 是两个刻意分开的概念。

感知 mask 的 `shadow` 与 `outerGlow` 可以共享 fused shader pass；`backdrop` 仍然只采样并 tint 图像或 mask coverage 后方的内容。

## 图标

`IconEx` 是针对图标使用方式调整的图像路径，通常采用 `contain` 与 tint：

```lua
MGFX.IconEx(x, y, 32, 32, material, {
    tint = Color(220, 245, 255),
    outerGlow = {color = Color(80, 190, 255, 70), width = 8},
})
```

[返回详细 API 入口](./index)
