# 组件图元

ProgressBar、SegmentBar、Ring、Arc、Sector 这些 renderer-level widget。

## 适用边界

- `RingEx(cx, cy, radius, width, style)` 和 `ArcEx(cx, cy, radius, width, startDeg, endDeg, style)` 把宽度放在几何参数里。
- `SectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, style)` 是真正扇区，不是圆弧加宽。
- 周向渐变使用 shape-local angular gradient，不要把它和全局 conic gradient 混为一谈。

## 本页 API

- [ProgressBar](#progressbar) - 简单水平进度条。value 会 clamp 到 0 到 1。
- [ProgressBarEx](#progressbarex) - 支持特效和独立绘制槽位的高级进度条。
- [SegmentBar](#segmentbar) - 简单分段数值条。
- [SegmentBarEx](#segmentbarex) - 高级分段数值条。
- [Ring](#ring) - 简单完整圆环。
- [RingEx](#ringex) - 带特效的高级完整圆环。
- [Arc](#arc) - 简单圆弧段。
- [ArcEx](#arcex) - 支持圆环式绘制和特效的高级圆弧。
- [Sector](#sector) - 简单直边径向扇区。
- [SectorEx](#sectorex) - 支持圆环式绘制和特效的高级直边扇区。

## 常用组件配方

#### HUD 血条 / 装填条

```lua
MGFX.ProgressBarEx(x, y, w, 14, health / maxHealth, {
    radius = 7,
    padding = 2,
    track = Color(255, 255, 255, 24),
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(255, 92, 72), Color(255, 190, 66)),
    stroke = Color(255, 255, 255, 28),
    strokeWidth = 1,
    fx = {sheen = true, marker = true},
})
```

常用高度 `8..18`。`radius = h * 0.5` 是胶囊条；`padding = 1..3` 能让填充和轨道分开，但高度低于 8 时应少用 padding。

#### 弹药 / 离散充能

```lua
MGFX.SegmentBarEx(x, y, 180, 12, ammo / maxAmmo, {
    segments = 12,
    gap = 3,
    radius = 2,
    track = Color(255, 255, 255, 20),
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(255, 210, 110), Color(255, 120, 72)),
    background = Color(0, 0, 0, 70),
    backgroundRadius = 5,
})
```

`segments = 6..24` 适合 HUD。上限是 128，但如果 `(w - gap * (segments - 1)) / segments <= 2`，视觉上会糊成一条线，应减少段数或 gap。

#### 圆形冷却 / 仪表

```lua
MGFX.RingEx(cx, cy, 34, 8, {
    fill = MGFX.RingAngularGradient({
        {0, Color(80, 170, 255)},
        {1, Color(90, 220, 180)},
    }, -90),
    stroke = Color(255, 255, 255, 42),
    strokeWidth = 1,
    outerGlow = {width = 10, color = Color(80, 190, 255, 52), softness = 0.62},
})
```

小 HUD 圆环推荐 `radius = 18..42`、`width = 4..12`。大仪表可以用 `width = 12..24`。`width` 是几何参数，不写在 `style.width`。

#### 弧形进度

```lua
local startDeg = -135
local endDeg = startDeg + 270 * math.Clamp(value, 0, 1)

MGFX.ArcEx(cx, cy, 42, 9, startDeg, endDeg, {
    fill = MGFX.ArcAngularGradient(Color(80, 170, 255), Color(90, 220, 180), startDeg),
    stroke = Color(255, 255, 255, 38),
    strokeWidth = 1,
})
```

`ArcEx` 适合 gauge、读条和圆形刻度，端点是圆头。角度使用度数，0 度在右侧，正方向按 GMod/surface 坐标系旋转。

#### 轮盘扇区

```lua
local gapDeg = 2
MGFX.SectorEx(cx, cy, 34, 92, startDeg + gapDeg, endDeg - gapDeg, {
    fill = MGFX.SectorAngularGradient({
        {0, Color(36, 44, 54, 210)},
        {1, Color(80, 170, 255, 170)},
    }, startDeg),
    stroke = Color(255, 255, 255, 36),
    strokeWidth = 1,
    shadow = {x = 0, y = 4, blur = 10, color = Color(0, 0, 0, 110), softness = 0.70},
})
```

`SectorEx` 是直边径向扇区，不是加粗圆弧。轮盘菜单常用 `gapDeg = 1..4` 给 wedge 留缝；`innerRadius = 0` 是实心扇形，`innerRadius > 0` 是环形 wedge。

## 参数速查

| 组件 | 推荐值 | 说明 |
| --- | --- | --- |
| `ProgressBarEx.value` | `0..1` | 会 clamp；调用方仍建议先用真实比例表达。 |
| `ProgressBarEx.h` | `8..18` | 小 HUD 可 8..12，主状态条可 14..18。 |
| `ProgressBarEx.padding` | `1..3` | 高度低于 8 时用 0 或 1。 |
| `ProgressBarEx.fx.ticks` | `0..31` | 实现会限制到 31；常用 4、6、8、10。 |
| `SegmentBarEx.segments` | `6..24` 常用，硬上限 128 | 分段越多越需要更宽的条和更小的 gap。 |
| `SegmentBarEx.gap` | `2..4` | 小条用 2，大条用 3..4。 |
| `RingEx.width` / `ArcEx.width` | 小 HUD `4..12`，大仪表 `12..24` | 几何厚度参数，不是 style 字段。 |
| `SectorEx.innerRadius` | `0` 或 `outerRadius * 0.35..0.65` | 0 做饼图/实心 wedge；非 0 做轮盘。 |
| `startDeg/endDeg` | 任意度数 | 先用角度表达设计，再给相邻 sector 留 `1..4` 度 gap。 |

## 函数参考

## ProgressBar

```lua
MGFX.ProgressBar(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
```

简单水平进度条。value 会 clamp 到 0 到 1。

#### 参数

| 参数 | 说明 |
| --- | --- |
| value | 0 到 1 的数字。 |
| radius | 轨道和填充圆角半径。 |
| track | 背景轨道颜色。 |
| fill | 填充颜色或渐变。 |
| stroke, strokeWidth | 可选轨道描边。 |

#### 用法说明

- 需要 padding、sheen、marker、ticks、图案和发光时使用 ProgressBarEx。
- 简单 helper 会在调用之间重置高级 style 字段。

#### 示例

```lua
MGFX.ProgressBar(x, y, w, 10, health / maxHealth, 5, Color(255, 255, 255, 24), Color(90, 220, 180))
```

## ProgressBarEx

```lua
MGFX.ProgressBarEx(x, y, w, h, value, style)
```

支持特效和独立绘制槽位的高级进度条。

#### 参数

| 参数 | 说明 |
| --- | --- |
| value | 会 clamp 到 0 到 1 的数字。 |
| style.radius | 条形圆角。默认 min(4, h * 0.5)。 |
| style.padding | 轨道和填充之间的内边距。 |
| style.track / fill | 轨道颜色和填充绘制。 |
| style.fx | glow、sheen、marker 和 ticks 选项。 |
| style.trackPattern / fillPattern | 可选图案槽位。 |

#### 用法说明

- 当 style 字段符合受支持组合时会使用快速 shader 路径。
- 显式使用 trackPattern 和 fillPattern；没有全局图案状态。

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `radius`<br>数字。 | `min(4, h * 0.5)` | 轨道和填充半径。 |
| `padding`<br>数字。 | `0` | 填充区域内缩。 |
| `track`<br>Color。 | `Color(10,18,24,190)` | 未填充轨道。 |
| `fill`<br>Color 或 MGFX 绘制记录。 | `color_white` | 已填充部分。 |
| `stroke / strokeWidth`<br>Color 加宽度。 | `white 18 / 1` | 轨道描边。 |
| `trackPattern / fillPattern`<br>StripePattern 或 SmokePattern。 | `nil` | 轨道或填充回退路径上的图案。 |
| `outerGlow / innerGlow`<br>发光 spec 表。 | `nil` | 回退路径上的额外特效。 |
| `fx`<br>{glow, sheen, marker, ticks}。 | `nil` | 可能时使用快速路径进度特效。 |

#### style.fx 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `glow`<br>true 或表。 | `false` | 启用发光标志。当前 shader 路径把表视为启用。 |
| `sheen`<br>true 或表。 | `false` | 添加顶部高光。 |
| `marker`<br>true 或表。 | `false` | 在填充边缘添加亮标记。 |
| `ticks`<br>数字或 {count = number}。 | `0` | 刻度数量，限制在 0..31。 |

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
MGFX.ProgressBarEx(x, y, w, 12, value, {
    radius = 6,
    padding = 2,
    track = Color(255, 255, 255, 24),
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(80, 170, 255), Color(90, 220, 180)),
    fx = {sheen = true, marker = true, ticks = 6},
})
```

## SegmentBar

```lua
MGFX.SegmentBar(x, y, w, h, value, segments, fill, track)
```

简单分段数值条。

#### 参数

| 参数 | 说明 |
| --- | --- |
| value | 0 到 1 的数字。 |
| segments | 分段数量。 |
| fill, track | 激活填充和未激活轨道绘制。 |

#### 用法说明

- 适合弹药、充能、perk 点或紧凑离散计量。
- 需要 gap、radius、描边、图案和发光时使用 SegmentBarEx。

#### 示例

```lua
MGFX.SegmentBar(x, y, 160, 10, ammo / maxAmmo, 8, Color(255, 210, 110), Color(255, 255, 255, 24))
```

## SegmentBarEx

```lua
MGFX.SegmentBarEx(x, y, w, h, value, style)
```

高级分段数值条。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.segments | 分段数量。 |
| style.gap | 分段之间的像素间距。 |
| style.radius | 分段圆角半径。 |
| style.fill / track | 激活与未激活绘制。 |
| style.fillPattern / trackPattern | 可选图案槽位。 |

#### 用法说明

- 渲染器在受支持时使用 shader 路径，否则回退为分段绘制。
- 密集 HUD 中请保持合理的分段数量。

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `segments`<br>1..128 的整数。 | `10` | 分段数量。 |
| `gap`<br>数字。 | `2` | 分段之间的像素间距。 |
| `radius`<br>数字。 | `min(2, h * 0.35)` | 每段圆角。 |
| `background / backgroundRadius`<br>Color 与半径。 | `nil / radius` | 所有分段后的可选容器。 |
| `track`<br>Color。 | `Color(255,255,255,22)` | 未激活分段颜色。 |
| `fill / color`<br>Color 或 MGFX 绘制记录。 | `orange` | 已激活分段绘制。 |
| `fillPattern / trackPattern`<br>StripePattern 或 SmokePattern。 | `nil` | 激活/未激活分段图案。 |
| `stroke / strokeWidth`<br>Color 加宽度。 | `nil / 0` | 回退路径上每个分段的描边。 |

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
MGFX.SegmentBarEx(x, y, w, 12, value, {
    segments = 10,
    gap = 3,
    radius = 3,
    track = Color(255, 255, 255, 20),
    fill = Color(90, 220, 180),
})
```

## Ring

```lua
MGFX.Ring(cx, cy, radius, width, fill)
```

简单完整圆环。

#### 参数

| 参数 | 说明 |
| --- | --- |
| cx, cy | 圆环中心。 |
| radius | 外半径。 |
| width | 圆环带宽。 |
| fill | Color 或渐变填充。 |

#### 用法说明

- 适合冷却、圆形计数器和状态指示。
- 需要描边、图案和发光时使用 RingEx。

#### 示例

```lua
MGFX.Ring(cx, cy, 32, 5, Color(80, 170, 255, 220))
```

## RingEx

```lua
MGFX.RingEx(cx, cy, radius, width, style)
```

带特效的高级完整圆环。

#### 参数

| 参数 | 说明 |
| --- | --- |
| width | 圆环带宽；传 nil 时默认约为半径的 18%。 |
| style.fill | 受支持时可为 Color、线性/径向/锥形绘制。 |
| style.stroke / strokeWidth | 可选圆环描边。 |
| style.shadow, pattern, innerGlow, outerGlow | 可选圆环特效。 |

#### 用法说明

- 外发光会作用于外边缘和透明内孔边界。
- 锥形渐变使用公开的角度制 rotation。

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `fill / color`<br>Color 或 MGFX 绘制记录。 | `white 180` | 圆环/弧线主体绘制。 |
| `stroke / strokeWidth`<br>Color 加宽度。 | `nil / 0` | 内外边缘描边。 |
| `shadow`<br>投影 spec 表。 | `nil` | 按圆环/弧线形状绘制外部软阴影。 |
| `pattern`<br>StripePattern 或 SmokePattern。 | `nil` | 裁剪到环形或弧线内的图案。 |
| `innerGlow / outerGlow`<br>发光 spec 表。 | `nil` | 圆环/弧线边缘发光。 |
| `backdrop`<br>true、数字、Color 或表。 | `nil` | 按圆环/弧线裁剪的 framebuffer 模糊/染色。 |

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
MGFX.RingEx(cx, cy, 38, 7, {
    fill = MGFX.ConicGradient(0.5, 0.5, 20, Color(80, 170, 255), Color(255, 210, 110)),
    outerGlow = {color = Color(80, 170, 255, 55), width = 12},
})
```

## Arc

```lua
MGFX.Arc(cx, cy, radius, startDeg, endDeg, width, fill)
```

简单圆弧段。

#### 参数

| 参数 | 说明 |
| --- | --- |
| startDeg, endDeg | 起止角度，单位度。 |
| width | 圆弧带宽。 |
| fill | Color 或渐变填充。 |

#### 用法说明

- 适合部分冷却、仪表和径向计量。
- 需要特效和命名字段时使用 ArcEx。

#### 示例

```lua
MGFX.Arc(cx, cy, 34, -135, 135, 6, Color(90, 220, 180, 230))
```

## ArcEx

```lua
MGFX.ArcEx(cx, cy, radius, width, startDeg, endDeg, style)
```

支持圆环式绘制和特效的高级圆弧。

#### 参数

| 参数 | 说明 |
| --- | --- |
| width | 圆弧带宽；传 nil 时默认约为半径的 18%。 |
| style.fill | 圆弧填充绘制。 |
| style.stroke / strokeWidth | 可选描边。 |
| style.shadow, pattern, innerGlow, outerGlow | 可选特效。 |

#### 用法说明

- 角度单位为度，不是弧度。
- 圆弧使用与圆环相同的发光语义。

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `fill / color`<br>Color 或 MGFX 绘制记录。 | `white 180` | 圆环/弧线主体绘制。 |
| `stroke / strokeWidth`<br>Color 加宽度。 | `nil / 0` | 内外边缘描边。 |
| `shadow`<br>投影 spec 表。 | `nil` | 按圆环/弧线形状绘制外部软阴影。 |
| `pattern`<br>StripePattern 或 SmokePattern。 | `nil` | 裁剪到环形或弧线内的图案。 |
| `innerGlow / outerGlow`<br>发光 spec 表。 | `nil` | 圆环/弧线边缘发光。 |
| `backdrop`<br>true、数字、Color 或表。 | `nil` | 按圆环/弧线裁剪的 framebuffer 模糊/染色。 |

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
MGFX.ArcEx(cx, cy, 42, 8, -120, 210, {
    fill = MGFX.LinearGradient(0, 0, 1, 1, Color(80, 170, 255), Color(255, 210, 110)),
    innerGlow = {color = Color(255, 255, 255, 45), width = 5},
})
```

## Sector

```lua
MGFX.Sector(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
```

简单直边径向扇区。

#### 参数

| 参数 | 说明 |
| --- | --- |
| innerRadius | 内半径；传 0 时是实心扇形。 |
| outerRadius | 外半径。 |
| startDeg, endDeg | 起止角度，单位为度。 |
| fill | Color 或 MGFX 绘制记录。 |

#### 用法说明

- 用于径向菜单楔形项和轮盘项。
- 不同于 Arc，Sector 的两端是径向直边，不是圆帽。

#### 示例

```lua
MGFX.Sector(cx, cy, 28, 72, -45, 45, Color(90, 120, 160, 150))
```

## SectorEx

```lua
MGFX.SectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, style)
```

支持圆环式绘制和特效的高级直边扇区。

#### 参数

| 参数 | 说明 |
| --- | --- |
| innerRadius | 环形扇区内半径；传 0 时是实心扇形。 |
| outerRadius | 外半径。 |
| style.fill | 扇区填充，可使用 SectorRadialGradient 和 SectorAngularGradient。 |
| style.stroke / strokeWidth | 可选描边，覆盖外弧、内弧和两条径向边。 |
| style.shadow, pattern, innerGlow, outerGlow | 可选圆环 shader 特效。 |

#### 用法说明

- SectorEx 复用圆环 shader 系列，但端点是径向直边。
- 使用 SectorAngularGradient 做 startDeg 到 endDeg 的局部周向渐变。

#### 扇区 style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `fill / color`<br>Color 或 MGFX 绘制记录。 | `white 180` | 扇区主体绘制，可使用 SectorRadialGradient 和 SectorAngularGradient。 |
| `stroke / strokeWidth`<br>Color 加宽度。 | `nil / 0` | 外弧、内弧和径向边描边。 |
| `shadow`<br>投影 spec 表。 | `nil` | 按扇区形状绘制外部软阴影。 |
| `pattern`<br>StripePattern 或 SmokePattern。 | `nil` | 裁剪到扇区形状内的图案。 |
| `innerGlow / outerGlow`<br>发光 spec 表。 | `nil` | 扇区边缘发光。 |
| `backdrop`<br>true、数字、Color 或表。 | `nil` | 按扇区裁剪的 framebuffer 模糊/染色。 |

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
MGFX.SectorEx(cx, cy, 36, 92, -45, 45, {
    fill = MGFX.SectorAngularGradient(Color(80, 170, 255, 170), Color(255, 210, 110, 145)),
    stroke = Color(255, 255, 255, 36),
    strokeWidth = 1,
})
```

[返回详细 API 入口](./index)
