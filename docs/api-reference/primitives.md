# 基础图元

Rounded、Chamfer、Poly、Line、Circle、Capsule 以及通用 shape style 能力。

## 适用边界

- 简单热路径优先用短签名，复杂视觉用 `NameEx(..., style)`。
- 高级效果放在 `style` 里：`fill`、`stroke`、`innerGlow`、`outerGlow`、`backdrop`、`pattern`、`transform`。
- `Poly` / `PolyEx` 的 public contract 是凸多边形，复杂路径应先拆成凸片段。

## 本页 API

- [RoundedBox](#roundedbox) - 高频路径圆角矩形 helper。
- [RoundedBoxEx](#roundedboxex) - 表格式样式的高级圆角矩形。
- [ChamferBox](#chamferbox) - 高频路径切角矩形 helper。
- [ChamferBoxEx](#chamferboxex) - 使用 style.cuts 的高级切角矩形。
- [Poly](#poly) - 根据调用方传入的点绘制凸多边形。
- [PolyEx](#polyex) - 带命名 style 字段的高级凸多边形。
- [Line](#line) - 用简单 positional 签名绘制线段。
- [LineEx](#lineex) - 带命名 width 与绘制字段的高级线条绘制。
- [Circle](#circle) - 基于圆角盒覆盖的简单圆形 helper。
- [CircleEx](#circleex) - 使用圆角矩形样式模型的高级圆形。
- [Capsule](#capsule) - 简单胶囊矩形 helper。
- [CapsuleEx](#capsuleex) - 使用圆角矩形样式模型的高级胶囊。
- [style.backdrop](#style-backdrop) - 由形状或图像遮罩裁剪的 framebuffer 模糊/染色效果。
- [style.transform](#style-transform) - 用于形状、图像和组件 Ex 调用的绘制阶段视觉变换。
- [Radial vignette fill](#radial-vignette-fill) - 暗角现在用普通透明径向渐变 fill 表达。

## 函数参考

## RoundedBox

```lua
MGFX.RoundedBox(x, y, w, h, radius, fill, stroke, strokeWidth)
```

高频路径圆角矩形 helper。

#### 参数

| 参数 | 说明 |
| --- | --- |
| x, y, w, h | 当前帧本地像素中的矩形。 |
| radius | 像素圆角半径。单角半径请使用 RoundedBoxEx。 |
| fill | Color 或 MGFX 渐变记录。 |
| stroke, strokeWidth | 可选描边颜色与宽度。 |

#### 用法说明

- 适合简单面板、胶囊按钮和单元格。
- 需要阴影、发光、图案或单角圆角时使用 RoundedBoxEx。

#### 示例

```lua
MGFX.RoundedBox(16, 16, 220, 48, 8, Color(28, 34, 46, 230), Color(255, 255, 255, 28), 1)
```

## RoundedBoxEx

```lua
MGFX.RoundedBoxEx(x, y, w, h, style)
```

表格式样式的高级圆角矩形。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.radius | 数字或 {tl, tr, br, bl} 角表。 |
| style.fill | Color 或渐变填充。 |
| style.stroke / strokeWidth | 可选描边。 |
| style.shadow, innerGlow, outerGlow | 受支持路径上的可选特效。 |
| style.pattern | StripePattern 或 SmokePattern 叠加。 |

#### 用法说明

- 精细面板建议默认用它，因为高级字段都有名字。
- radius 会被规范化，避免相对角超过矩形尺寸。

#### 半径与单角写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `number`<br>像素半径。 | `0` | 每个角使用相同半径。 |
| `{tl, tr, br, bl}`<br>命名单角表，也接受数组顺序 {tl, tr, br, bl}。 | `0` | 用于表格式形状 API 的单角半径。 |

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `radius`<br>数字或 {tl, tr, br, bl}。 | `0` | 圆角半径。 |
| `fill`<br>Color 或 MGFX 绘制记录。 | `color_white` | 主体填充。 |
| `stroke / strokeWidth`<br>Color 加数字、true、"hairline"、"thin" 或 "none" 宽度。 | `nil / 0` | 可选描边。 |
| `shadow`<br>true、数字，或 {x/y、offsetX/offsetY、dx/dy、offset、blur/radius/size/width、spread/grow、color/tint、opacity/strength、softness/falloff}。 | `nil` | 外部软阴影；convex poly 仍使用轮廓 fallback。 |
| `innerGlow`<br>true、Color，或 {color/tint, width/size, opacity/strength, softness/falloff}。 | `nil` | 内边缘发光。 |
| `outerGlow`<br>true、Color，或 {x/y、offsetX/offsetY、color/tint、width/size/spread、opacity/strength、softness/falloff}。 | `nil` | 外发光；spread 会影响剔除和绘制范围。 |
| `backdrop`<br>true、数字、Color 或 {blur, tint, opacity}。 | `nil` | 按圆角形状裁剪的 framebuffer 模糊/染色层。 |
| `pattern`<br>MGFX.StripePattern、MGFX.SmokePattern、true，或图案 spec 表。 | `nil` | 在支持的形状路径上叠加图案。 |

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
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = {tl = 10, tr = 10, br = 4, bl = 4},
    fill = MGFX.LinearGradient(0, 0, 0, 1, Color(28, 34, 46), Color(16, 20, 28)),
    stroke = Color(255, 255, 255, 28),
    strokeWidth = 1,
    outerGlow = {color = Color(80, 170, 255, 46), width = 14},
})
```

## ChamferBox

```lua
MGFX.ChamferBox(x, y, w, h, cuts, fill, stroke, strokeWidth)
```

高频路径切角矩形 helper。

#### 参数

| 参数 | 说明 |
| --- | --- |
| cuts | 所有角共用的数字，或 {tl, tr, br, bl}。 |
| fill | Color 或渐变填充。 |
| stroke, strokeWidth | 可选描边颜色与宽度。 |

#### 用法说明

- cuts 会限制到较短边的一半。
- 需要发光、图案和命名字段时使用 ChamferBoxEx。

#### 切角写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `number`<br>应用到每个角的像素切角。 | `0` | 统一切角。 |
| `{tl, tr, br, bl}`<br>命名表，也接受数组顺序 {tl, tr, br, bl}。 | `0` | 单角切角。数值会限制到较短边的一半。 |

#### 示例

```lua
MGFX.ChamferBox(16, 80, 220, 44, {tl = 10, tr = 0, br = 10, bl = 0}, Color(28, 34, 46, 230))
```

## ChamferBoxEx

```lua
MGFX.ChamferBoxEx(x, y, w, h, style)
```

使用 style.cuts 的高级切角矩形。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.cuts | 数字或 {tl, tr, br, bl}。 |
| style.fill | Color 或渐变填充。 |
| style.pattern | 可选 StripePattern 或 SmokePattern。 |
| style.innerGlow / outerGlow | 可选的切角感知发光效果。 |

#### 用法说明

- 适合棱角 HUD 面板、警告标记和科幻风 scoreboard 行。
- 省略 style.cuts 时，形状基本等同矩形。

#### 切角写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `number`<br>应用到每个角的像素切角。 | `0` | 统一切角。 |
| `{tl, tr, br, bl}`<br>命名表，也接受数组顺序 {tl, tr, br, bl}。 | `0` | 单角切角。数值会限制到较短边的一半。 |

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `cuts`<br>数字或 {tl, tr, br, bl}。 | `0` | 切角尺寸。 |
| `fill`<br>Color 或 MGFX 绘制记录。 | `color_white` | 主体填充。 |
| `stroke / strokeWidth`<br>Color 加描边宽度。 | `nil / 0` | 切角感知描边。 |
| `shadow`<br>true、数字，或 {x/y、offsetX/offsetY、dx/dy、offset、blur/radius/size/width、spread/grow、color/tint、opacity/strength、softness/falloff}。 | `nil` | 外部软阴影。 |
| `innerGlow`<br>true、Color，或 {color/tint, width/size, opacity/strength, softness/falloff}。 | `nil` | 内边缘发光。 |
| `outerGlow`<br>true、Color，或 {x/y、offsetX/offsetY、color/tint、width/size/spread、opacity/strength、softness/falloff}。 | `nil` | 外发光；spread 会影响剔除和绘制范围。 |
| `backdrop`<br>true、数字、Color 或 {blur, tint, opacity}。 | `nil` | 按切角形状裁剪的 framebuffer 模糊/染色层。 |
| `pattern`<br>StripePattern 或 SmokePattern。 | `nil` | 裁剪到切角多边形内的图案。 |

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
MGFX.ChamferBoxEx(x, y, w, h, {
    cuts = {tl = 12, tr = 3, br = 12, bl = 3},
    fill = Color(20, 26, 34, 235),
    pattern = MGFX.StripePattern({color = Color(255, 255, 255, 24), spacing = 9, width = 1}),
})
```

## Poly

```lua
MGFX.Poly(points, fill, stroke, strokeWidth)
```

根据调用方传入的点绘制凸多边形。

#### 参数

| 参数 | 说明 |
| --- | --- |
| points | {x, y} 或 {number, number} 点数组。 |
| fill | Color 或渐变填充。 |
| stroke, strokeWidth | 可选描边。 |

#### 用法说明

- 公共契约是凸多边形。凹多边形输入可能渲染错误。
- 调用时会复制 points，之后调用方修改不会影响命令。

#### 点格式

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `points[i]`<br>{x = number, y = number}。 | `required` | 命名点格式。 |
| `points[i]`<br>{number, number}。 | `required` | 数组点格式。 |
| `vertex count`<br>3 到 8 个凸多边形顶点。 | `required` | 凹多边形输入会被拒绝或渲染错误。 |

#### 示例

```lua
MGFX.Poly({
    {x = x + 18, y = y},
    {x = x + w, y = y},
    {x = x + w - 18, y = y + h},
    {x = x, y = y + h},
}, Color(80, 170, 255, 160))
```

## PolyEx

```lua
MGFX.PolyEx(points, style)
```

带命名 style 字段的高级凸多边形。

#### 参数

| 参数 | 说明 |
| --- | --- |
| points | 凸多边形点数组。 |
| style.fill | Color 或渐变填充。 |
| style.stroke / strokeWidth | 可选描边。 |
| style.pattern | 受支持 shader 路径上的可选图案。 |

#### 用法说明

- 适合菱形、斜角标签、方向标记和自定义凸 UI 板。
- 一般复杂路径请先拆成凸形再传给 MGFX。

#### 点格式

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `points[i]`<br>{x = number, y = number}。 | `required` | 命名点格式。 |
| `points[i]`<br>{number, number}。 | `required` | 数组点格式。 |
| `vertex count`<br>3 到 8 个凸多边形顶点。 | `required` | 凹多边形输入会被拒绝或渲染错误。 |

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `fill`<br>Color 或 MGFX 绘制记录。 | `color_white` | 多边形填充。 |
| `stroke / strokeWidth`<br>Color 加宽度。 | `nil / 0` | 边缘描边。四点以内使用 shader 描边；回退路径绘制边线。 |
| `shadow`<br>文本风格 shadow 表。 | `nil` | 扩展一个偏移的投影多边形。 |
| `backdrop`<br>true、数字、Color 或 {blur, tint, opacity}。 | `nil` | 按多边形裁剪的 framebuffer 模糊/染色层。 |
| `pattern`<br>StripePattern 或 SmokePattern。 | `nil` | 裁剪到多边形内的图案。 |

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
MGFX.PolyEx(points, {
    fill = MGFX.LinearGradient(0, 0, 1, 1, Color(80, 170, 255), Color(90, 220, 180)),
    stroke = Color(255, 255, 255, 36),
    strokeWidth = 1,
})
```

## Line

```lua
MGFX.Line(x1, y1, x2, y2, width, fill)
```

用简单 positional 签名绘制线段。

#### 参数

| 参数 | 说明 |
| --- | --- |
| x1, y1, x2, y2 | 当前帧本地像素中的线段端点。 |
| width | 线宽，单位像素。 |
| fill | Color 或线性渐变。 |

#### 用法说明

- 需要端点、radius 或发光时使用 LineEx。
- 水平和垂直线在可行时会使用优化矩形路径。

#### 示例

```lua
MGFX.Line(24, 64, 220, 64, 2, Color(80, 170, 255, 220))
```

## LineEx

```lua
MGFX.LineEx(x1, y1, x2, y2, style)
```

带命名 width 与绘制字段的高级线条绘制。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.width | 线条厚度，单位像素。 |
| style.fill | Color 或渐变。 |
| style.noCaps | 设为 true 可避免斜线 quad 的延伸端点。 |
| style.radius / outerGlow | 轴对齐特效线可选圆角矩形路径。 |

#### 用法说明

- 当线条样式需要在调用点保持可读时使用 LineEx。
- 渐变使用图元本地归一化绘制模型。

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `width`<br>数字。 | `1` | 线宽，单位像素。 |
| `fill / color`<br>Color 或 MGFX 绘制记录。 | `color_white` | 线段绘制。渐变会沿线段采样。 |
| `noCaps`<br>布尔 true。 | `false` | 在四边形路径上移除圆头端帽。 |
| `caps`<br>布尔兼容字段。 | `true` | 显式移除端帽请使用 noCaps。 |
| `radius`<br>数字。 | `nil` | 轴对齐线段矩形可走圆角矩形渲染。 |
| `outerGlow`<br>发光 spec 表。 | `nil` | 轴对齐线段使用矩形路径绘制发光。 |
| `backdrop`<br>true、数字、Color 或表。 | `nil` | 按线段覆盖区域裁剪的 framebuffer 模糊/染色。 |

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
MGFX.LineEx(x, y, x + w, y, {
    width = 3,
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(80, 170, 255), Color(90, 220, 180)),
    outerGlow = {color = Color(80, 170, 255, 60), width = 12},
})
```

## Circle

```lua
MGFX.Circle(cx, cy, radius, fill, stroke, strokeWidth)
```

基于圆角盒覆盖的简单圆形 helper。

#### 参数

| 参数 | 说明 |
| --- | --- |
| cx, cy | 圆心。 |
| radius | 圆半径，单位像素。 |
| fill, stroke, strokeWidth | 填充与可选描边。 |

#### 用法说明

- 适合点、状态灯和圆形徽章。
- 需要特效字段时使用 CircleEx。

#### 示例

```lua
MGFX.Circle(x + 12, y + 12, 6, Color(90, 220, 180), Color(255, 255, 255, 40), 1)
```

## CircleEx

```lua
MGFX.CircleEx(cx, cy, radius, style)
```

使用圆角矩形样式模型的高级圆形。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.fill | Color 或渐变填充。 |
| style.stroke / strokeWidth | 可选描边。 |
| style.shadow, innerGlow, outerGlow, pattern | 可选形状特效。 |

#### 用法说明

- MGFX 会根据圆心和半径计算盒子，再应用圆形半径。
- 圆形图片请使用带 MGFX.Mask("circle") 的 ImageEx。

#### 示例

```lua
MGFX.CircleEx(cx, cy, 18, {
    fill = Color(80, 170, 255, 220),
    outerGlow = {color = Color(80, 170, 255, 75), width = 16},
})
```

## Capsule

```lua
MGFX.Capsule(x, y, w, h, fill, stroke, strokeWidth)
```

简单胶囊矩形 helper。

#### 参数

| 参数 | 说明 |
| --- | --- |
| x, y, w, h | 胶囊边界。 |
| fill, stroke, strokeWidth | 填充与可选描边。 |

#### 用法说明

- 半径自动为较短边的一半。
- 适合标签、紧凑条和胶囊按钮。

#### 示例

```lua
MGFX.Capsule(x, y, 96, 24, Color(80, 170, 255, 180), Color(255, 255, 255, 36), 1)
```

## CapsuleEx

```lua
MGFX.CapsuleEx(x, y, w, h, style)
```

使用圆角矩形样式模型的高级胶囊。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.fill | Color 或渐变填充。 |
| style.stroke / strokeWidth | 可选描边。 |
| style.shadow, innerGlow, outerGlow, pattern | 可选特效。 |

#### 用法说明

- CapsuleEx 会根据当前渲染尺寸设置半径；胶囊形状本身不需要传 style.radius。
- 当胶囊表示一个 clamp 后的数值时使用 ProgressBarEx。

#### 示例

```lua
MGFX.CapsuleEx(x, y, w, 28, {
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(80, 170, 255), Color(90, 220, 180)),
    outerGlow = {color = Color(80, 170, 255, 45), width = 10},
})
```

## style.backdrop

```lua
style.backdrop = true | number | Color | {blur, tint, opacity}
```

由形状或图像遮罩裁剪的 framebuffer 模糊/染色效果。Backdrop 只影响形状内部覆盖范围，不是投影；需要 drop shadow 时使用 `style.shadow`。

#### 参数

| 参数 | 说明 |
| --- | --- |
| true | 使用默认 blur = 4。 |
| number | 数字值会作为 blur 强度。 |
| Color | 只绘制按形状裁剪的 tint。 |
| table | 支持 blur、tint/color、opacity/strength 和 padding/spread。 |

#### 用法说明

- Backdrop 是 style 字段，不再是独立 primitive。
- RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、RingEx、ArcEx、SectorEx、CircleEx、CapsuleEx 和 ImageEx 都会按自身覆盖区域裁剪它。

#### style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `true`<br>快捷写法。 | `{blur = 4}` | 默认按形状裁剪的模糊。 |
| `number`<br>快捷写法。 | `{blur = number}` | 数字作为 blur 强度。 |
| `Color`<br>快捷写法。 | `{tint = Color}` | 只绘制按形状裁剪的 tint。 |
| `blur / size`<br>数字。 | `0` | 帧缓冲模糊强度。 |
| `tint / color`<br>Color。 | `transparent` | 覆盖在模糊区域上的颜色。 |
| `opacity / strength`<br>0..1 数字。 | `1` | tint alpha 的乘数。 |
| `padding / spread`<br>数字。 | `0` | 为形状 backdrop pass 预留的扩展提示。 |

#### 示例

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = Color(0, 0, 0, 0),
    backdrop = {blur = 5, tint = Color(8, 14, 24, 150)},
})
```

## style.transform

```lua
style.transform = MGFX.Transform(...) | MGFX.PointerTilt(...) | MGFX.ProjectedQuad(...)
```

用于形状、图像和组件 Ex 调用的绘制阶段视觉变换。

#### 参数

| 参数 | 说明 |
| --- | --- |
| origin | 类似 CSS 的原点，例如 "50% 50%"、"left top" 或 {x, y}。 |
| rotate / rotateX / rotateY | 角度，单位度。 |
| perspective | 2.5D 投影的透视距离。 |
| scale / translate / skew | 2D 变换字段；translate 可包含 z。 |
| steps / subdivisions | 投影/透视变换的网格细分数。 |

#### 用法说明

- transform 只影响视觉绘制，不改变布局、命中测试、文本排版或矩形裁剪。
- 支持 RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx、ImageEx、IconEx、ProgressBarEx、SegmentBarEx、RingEx、ArcEx 和 SectorEx。
- TextEx/TextBoxEx 暂不属于这个 transform 契约，因为文本使用独立 glyph atlas 合成器。

#### transform 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `origin / transformOrigin`<br>"50% 50%"、"left top"、{x, y} 或数字。 | `"50% 50%"` | 用于缩放、旋转、透视和指针倾斜的锚点。 |
| `rotate / rotateZ`<br>角度，单位度。 | `0` | 围绕 origin 的 2D 旋转。 |
| `rotateX / rotateY`<br>角度，单位度。 | `0` | 2.5D 倾斜。透视/投影路径会被细分，让现有 shader 保持有效 UV。 |
| `perspective`<br>数字。 | `0 / 900 for PointerTilt` | 透视距离。数值越大投影越平。 |
| `scale / scaleX / scaleY`<br>数字或 {x, y}。 | `1` | 围绕 origin 的视觉缩放。 |
| `translate / x/y/z`<br>{x, y, z} 或独立字段。 | `0` | 视觉位移；z 只影响透视。 |
| `skew / skewX / skewY`<br>角度，单位度。 | `0` | 旋转前的 2D 斜切。 |
| `steps / subdivisions`<br>0..24 的整数。 | `auto` | 投影和透视变换的细分数。 |

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
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(28, 34, 46, 230),
    transform = MGFX.PointerTilt(mx, my, {
        origin = "50% 50%",
        perspective = 900,
        maxRotateX = 4,
        maxRotateY = 6,
        strength = hover,
        steps = 12,
    }),
})
```

## Radial vignette fill

```lua
fill = MGFX.RadialGradient(cx, cy, radius, stops)
```

暗角现在用普通透明径向渐变 fill 表达。

#### 参数

| 参数 | 说明 |
| --- | --- |
| stops | 使用显式透明/不透明 stops。 |
| alpha | 缺省 alpha 等于 255；需要消失时写 Color(..., 0)。 |

#### 用法说明

- 这替代旧的 backdrop 内置 vignette 字段。
- 需要边缘暗角时，把它作为单独形状层绘制。

#### 示例

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = MGFX.RadialGradient(0.5, 0.5, 0.85, {
        {0, Color(0, 0, 0, 0)},
        {1, Color(0, 0, 0, 96)},
    }),
})
```

[返回详细 API 入口](./index)
