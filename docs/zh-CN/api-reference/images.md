# 图像与遮罩

图像、图标、fit/crop/uv、shape mask、texture mask 和 image-specific glow/backdrop。

## 适用边界

- 普通图像用 `Image`，需要遮罩、布局或特效时用 `ImageEx`。
- 圆形头像、切角头像和纹理遮罩都通过 `style.mask = MGFX.Mask(...)` 表达。
- 任意形状 backdrop 应挂在当前 shape/image 的 `style.backdrop` 上，而不是画独立 blur primitive。

## 本页 API

- [Image](#image) - 带可选圆角和 tint 的简单图像 helper。
- [ImageEx](#imageex) - 支持布局、遮罩和特效的高级图像绘制路径。
- [Icon](#icon) - 简单图标 helper。默认 contain 适配。
- [IconEx](#iconex) - 高级图标路径，支持 ImageEx 风格字段，默认 contain 布局。
- [Mask](#mask) - 为 ImageEx/IconEx 创建显式图像遮罩记录。

## 图像布局配方

#### 圆形头像

```lua
MGFX.ImageEx(x, y, 64, 64, avatarMat, {
    fit = "cover",
    mask = MGFX.Mask("circle"),
    stroke = Color(255, 255, 255, 42),
    strokeWidth = 1,
    shadow = {x = 0, y = 4, blur = 10, color = Color(0, 0, 0, 120), softness = 0.68},
})
```

头像通常用 `fit = "cover"`，让图片填满方框并裁掉多余部分。圆形不是特殊头像组件，而是 `ImageEx + Mask("circle")`。

#### 图标完整显示

```lua
MGFX.IconEx(x, y, 20, 20, "icon16/star.png", {
    tint = Color(255, 220, 120),
    alpha = 0.92,
    outerGlow = {width = 8, color = Color(255, 190, 66, 42), softness = 0.55},
})
```

图标默认应保持比例，所以优先用 `Icon` / `IconEx`。如果改用 `ImageEx`，请显式写 `fit = "contain"`，避免小图标被拉伸。

#### 固定画幅裁切

```lua
MGFX.ImageEx(x, y, 220, 96, bannerMat, {
    fit = "cover",
    position = {x = 0.5, y = 0.35},
    radius = 8,
    fill = Color(8, 12, 16, 180),
})
```

`position.x/y` 是 `0..1` 的对齐因子。`cover` 下用于决定裁掉哪边：`y = 0` 偏上，`0.5` 居中，`1` 偏下。

#### 图集 / atlas 裁切

```lua
MGFX.ImageEx(x, y, 32, 32, atlasMat, {
    fit = "contain",
    crop = {x = 64, y = 32, w = 32, h = 32, pixels = true},
    tint = Color(255, 255, 255),
})
```

`crop` 可以用归一化单位，也可以加 `pixels = true` 用源图像像素。`uv` 更底层，适合已经算好 `{u0, v0, u1, v1}` 的工具链。

#### 纹理遮罩

```lua
local mask = MGFX.Mask("texture", {
    source = maskMat,
    channel = "a", -- a, r, g, b, luma
})

MGFX.ImageEx(x, y, w, h, sourceMat, {
    fit = "cover",
    mask = mask,
    outerGlow = {width = 14, color = Color(80, 170, 255, 70), softness = 0.64},
    backdrop = {blur = 4, tint = Color(8, 14, 24, 90)},
})
```

纹理遮罩的 glow/backdrop 会按 mask coverage 裁剪。需要投影时加 `shadow`；`backdrop` 仍然只是内部背景 blur/tint。

## 参数速查

| 字段 | 推荐写法 | 说明 |
| --- | --- | --- |
| `fit = "fill"` | 普通铺满、允许拉伸 | 默认路径；不保证源图比例。 |
| `fit = "cover"` | 头像、banner、卡片图 | 保持比例并裁切，多余部分由 `position` 决定。 |
| `fit = "contain"` | 图标、logo、需要完整显示的物品图 | 保持比例并留空，空白可用 `fill/background` 补底。 |
| `position` | `{x = 0.5, y = 0.5}` | cover/contain 对齐；范围通常 `0..1`。 |
| `radius` | 小图 `4..8`，头像 `"circle"` 或 `Mask("circle")` | 没有显式 mask 时会变成 rounded mask。 |
| `alpha` | `0..1` 或 `0..255` | `0.8` 和 `204` 都可表达约 80% 不透明度。 |
| `shadow` | `y = 3..8`、`blur = 8..16` | 圆角、切角、纹理遮罩都走 mask-aware 外部软阴影。 |
| `outerGlow` | `width = 6..18`、`softness = 0.55..0.75` | 选中态、稀有物品、技能图标常用。 |
| `backdrop.blur` | `3..8` | 只对图像或 mask 覆盖区内部的背景生效。 |

## 函数参考

## Image

```lua
MGFX.Image(x, y, w, h, source, radius, tint)
```

带可选圆角和 tint 的简单图像 helper。

#### 参数

| 参数 | 说明 |
| --- | --- |
| source | 材质路径字符串、类似 Material 的对象，或类似 texture 的对象。 |
| radius | 可选圆角半径。 |
| tint | 可选 Color tint。 |

#### 用法说明

- 用于直接纹理绘制。
- 需要 fit、crop、UV、遮罩、背景、描边和发光时使用 ImageEx。

#### 图像半径写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `number`<br>像素半径。 | `0` | 图像圆角。 |
| `true`<br>布尔快捷写法。 | `false` | 使用较短边的一半，等同圆形或胶囊。 |
| `"circle"`<br>字符串快捷写法。 | `nil` | 使用较短边的一半。 |
| `"50%"`<br>0% 到 100% 的百分比字符串。 | `nil` | 按较短边缩放。 |
| `"8px"`<br>像素字符串。 | `nil` | 解析为像素半径。 |

#### 示例

```lua
MGFX.Image(x, y, 64, 64, "materials/icon16/user.png", 8, Color(255, 255, 255))
```

## ImageEx

```lua
MGFX.ImageEx(x, y, w, h, source, style)
```

支持布局、遮罩和特效的高级图像绘制路径。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.fit / objectFit | fill/stretch、cover 或 contain。 |
| style.position | cover/contain 对齐的 {x, y}。默认居中。 |
| style.crop / uv | 源区域，归一化或像素裁剪。 |
| style.mask | MGFX.Mask 记录、字符串别名、false 或 "none"。 |
| style.fill / background | 图像背后的可选背景。 |
| style.stroke / strokeWidth | 受支持时的可选遮罩感知描边。 |

#### 用法说明

- 如果省略 mask 但存在 style.radius，MGFX 会把它视为圆角图像遮罩。
- 纹理遮罩和圆形遮罩支持基于 shader 的 outerGlow。

#### 布局与源区域字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `fit / objectFit`<br>"fill"、"stretch"、"cover" 或 "contain"。 | `fill` | fill 拉伸；cover 裁切；contain 留白。IconEx 默认 contain。 |
| `position`<br>{x, y}、{number, number}，或 alignX/alignY。 | `0.5, 0.5` | cover 裁切和 contain 放置时的对齐因子。 |
| `crop`<br>{x, y, w, h}，可选 pixels = true。 | `full image` | 用归一化单位或源像素指定源区域。 |
| `uv`<br>{u0, v0, u1, v1}、{x0, y0, x1, y1}，或数组值。 | `0, 0, 1, 1` | 直接指定 UV 矩形。优先于 crop。 |
| `radius`<br>数字、true、"circle"、百分比字符串或 px 字符串。 | `0` | style.mask 为空时的圆角图像快捷写法。 |
| `mask`<br>MGFX.Mask 记录、字符串别名、false 或 "none"。 | `nil` | 显式 shader 覆盖。false/"none" 禁用遮罩。 |

#### 视觉字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `tint / color`<br>Color。 | `color_white` | 乘到源图像颜色上。 |
| `alpha`<br>0..1 不透明度或 0..255 alpha 乘数。 | `nil` | tint 之后的额外透明度控制。 |
| `fill / background`<br>Color。 | `nil` | 透明或遮罩像素后的背景色。 |
| `stroke / strokeWidth`<br>Color 加宽度。 | `nil / 0` | 路径支持时的遮罩感知描边。 |
| `shadow`<br>投影 spec 表，支持 x/y offset 和 blur/spread。 | `nil` | 圆角/切角/纹理遮罩感知外部软阴影。 |
| `outerGlow`<br>发光 spec 表，支持 x/y offset。 | `nil` | 图像或遮罩感知外发光。 |
| `backdrop`<br>true、数字、Color 或表。 | `nil` | 按图像或遮罩裁剪的 framebuffer 模糊/染色。 |

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
MGFX.ImageEx(x, y, 72, 72, avatarMat, {
    fit = "cover",
    mask = MGFX.Mask("circle"),
    outerGlow = {color = Color(80, 170, 255, 70), width = 14},
})
```

## Icon

```lua
MGFX.Icon(x, y, w, h, source, tint)
```

简单图标 helper。默认 contain 适配。

#### 参数

| 参数 | 说明 |
| --- | --- |
| source | 图标材质来源。 |
| tint | 可选 Color tint。 |

#### 用法说明

- 用于需要保持宽高比的小型 glyph 类图片资源。
- 需要 crop、alpha、遮罩和自定义 fit 时使用 IconEx。

#### 示例

```lua
MGFX.Icon(x, y, 18, 18, "icon16/star.png", Color(255, 220, 120))
```

## IconEx

```lua
MGFX.IconEx(x, y, w, h, source, style)
```

高级图标路径，支持 ImageEx 风格字段，默认 contain 布局。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.fit | 省略时默认 contain。 |
| style.tint / alpha | 图标颜色和透明度控制。 |
| style.crop / uv | 可选源区域。 |
| style.mask | 可选遮罩记录。 |

#### 用法说明

- 当图标需要完整图像控制但默认仍应像图标一样布局时使用。
- IconEx 复用同一个底层图像渲染器。

#### 布局与源区域字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `fit / objectFit`<br>"fill"、"stretch"、"cover" 或 "contain"。 | `fill` | fill 拉伸；cover 裁切；contain 留白。IconEx 默认 contain。 |
| `position`<br>{x, y}、{number, number}，或 alignX/alignY。 | `0.5, 0.5` | cover 裁切和 contain 放置时的对齐因子。 |
| `crop`<br>{x, y, w, h}，可选 pixels = true。 | `full image` | 用归一化单位或源像素指定源区域。 |
| `uv`<br>{u0, v0, u1, v1}、{x0, y0, x1, y1}，或数组值。 | `0, 0, 1, 1` | 直接指定 UV 矩形。优先于 crop。 |
| `radius`<br>数字、true、"circle"、百分比字符串或 px 字符串。 | `0` | style.mask 为空时的圆角图像快捷写法。 |
| `mask`<br>MGFX.Mask 记录、字符串别名、false 或 "none"。 | `nil` | 显式 shader 覆盖。false/"none" 禁用遮罩。 |

#### 视觉字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `tint / color`<br>Color。 | `color_white` | 乘到源图像颜色上。 |
| `alpha`<br>0..1 不透明度或 0..255 alpha 乘数。 | `nil` | tint 之后的额外透明度控制。 |
| `fill / background`<br>Color。 | `nil` | 透明或遮罩像素后的背景色。 |
| `stroke / strokeWidth`<br>Color 加宽度。 | `nil / 0` | 路径支持时的遮罩感知描边。 |
| `shadow`<br>投影 spec 表，支持 x/y offset 和 blur/spread。 | `nil` | 圆角/切角/纹理遮罩感知外部软阴影。 |
| `outerGlow`<br>发光 spec 表，支持 x/y offset。 | `nil` | 图像或遮罩感知外发光。 |
| `backdrop`<br>true、数字、Color 或表。 | `nil` | 按图像或遮罩裁剪的 framebuffer 模糊/染色。 |

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
MGFX.IconEx(x, y, 24, 24, iconMat, {
    tint = Color(120, 210, 255),
    alpha = 0.9,
    fit = "contain",
})
```

## Mask

```lua
MGFX.Mask(kind, spec)
```

为 ImageEx/IconEx 创建显式图像遮罩记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| kind | rounded、chamfer、circle、capsule、texture，或别名。 |
| spec | 可选表，会复制进遮罩记录。 |

#### 用法说明

- rounded 别名：round、roundedbox、roundrect。spec.radius 支持数字、true、"circle"、"50%" 或 "8px"。
- chamfer 别名：bevel。spec.cuts 可为数字或 {tl, tr, br, bl}。
- circle 和 capsule 不需要 spec；capsule 别名为 pill。
- texture 别名为 alpha 和 image。使用 source/material/texture/image，加 channel a/r/g/b/luma，可选 invert 与 uv/crop。
- 可以把表作为第一个参数传入；shape 可作为 kind 的别名。

#### 返回值

复制后的遮罩表。规范化稍后在图像渲染器中发生。

#### kind/spec 对照

| 变体 | 主要字段 | 可选字段 | 结果 |
| --- | --- | --- | --- |
| `"rounded"` | `spec.radius` | radius 支持数字、true、"circle"、"50%" 或 "8px"。别名：round、roundedbox、roundrect。 | 圆角图像覆盖。省略 radius 时使用 style.radius 或 0。 |
| `"chamfer"` | `spec.cuts` | cuts 支持数字或 {tl, tr, br, bl}。别名：bevel。 | 切角图像覆盖。 |
| `"circle"` | `none` | 不需要 spec。 | 使用绘制尺寸较短边的一半作为半径。 |
| `"capsule"` | `none` | 不需要 spec。别名：pill。 | 沿长轴形成胶囊覆盖。 |
| `"texture"` | `source/material/texture/image` | channel、invert/inverse、uv、crop。别名：alpha、image。 | 使用第二张纹理作为 alpha/通道覆盖。 |
| `false / "none"` | `none` | 作为 style.mask 使用，而不是 MGFX.Mask(kind)。 | 即使存在 radius 也禁用遮罩。 |
| `table first arg` | `{kind/shape = ...}` | MGFX.Mask({shape = "rounded", radius = 8}) 会被复制，并在之后规范化。 | 适合构建可复用遮罩记录。 |

#### 纹理遮罩字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `source / material / texture / image`<br>材质路径、类似 IMaterial 的对象，或类似 ITexture 的对象。 | `required` | 遮罩纹理来源。 |
| `channel`<br>"a"/"alpha"、"r"/"red"、"g"/"green"、"b"/"blue"、"luma"/"lum"/"luminance"/"rgb"。 | `"a"` | 用于覆盖率采样的通道。 |
| `invert / inverse`<br>布尔值。 | `false` | 反转遮罩覆盖率。 |
| `uv`<br>{u0, v0, u1, v1}、{x0, y0, x1, y1}，或数组。 | `0, 0, 1, 1` | 遮罩纹理 UV 矩形。 |
| `crop`<br>{x, y, w, h}，可选 pixels = true。 | `nil` | 遮罩纹理源区域的另一种写法。 |

#### 示例

```lua
local rounded = MGFX.Mask("rounded", {radius = 10})
local chamfer = MGFX.Mask("chamfer", {cuts = {tl = 12, tr = 0, br = 12, bl = 0}})
local textureMask = MGFX.Mask("texture", {
    source = maskMaterial,
    channel = "a",
    invert = false,
    uv = {u0 = 0, v0 = 0, u1 = 1, v1 = 1},
})

MGFX.ImageEx(x, y, w, h, source, {mask = textureMask, fit = "cover"})
```

[返回详细 API 入口](./index)
