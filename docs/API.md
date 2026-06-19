# MGFX API 总览

MGFX 是 Garry's Mod 的底层 immediate renderer。它只负责把调用方每帧传入的显式绘制参数画出来，不拥有 layout、input、focus、组件生命周期、动画状态或命中测试。

如果你要查某个函数的完整参数表、注意事项、返回值和示例，请看按功能拆分的 [详细 API 参考](./api-reference/)。

## 基本模型

MGFX 的 public API 分两层：

```text
Name(...)    高频短签名，适合简单热路径
NameEx(...)  table style 签名，适合高级效果和可读参数
```

非 `Ex` 函数只保留稳定的短参数，不继续堆长重载。阴影、glow、pattern、backdrop、mask、fit/crop、transform、per-corner radius 等高级能力放在对应的 `Ex` style table 里。

所有绘制参数都显式传入。MGFX 没有全局 fill/stroke 状态。

描边顺序固定为：

```lua
fill, stroke, strokeWidth
```

`stroke == nil`、`strokeWidth == nil` 或 `strokeWidth <= 0` 表示不绘制描边。

## Lux 入口

Lux 用户不需要关心某个函数内部属于 paint、primitive 还是 widget。推荐入口是统一门面：

```lux
import * as mgfx from "@lux/mgfx"

client fn install() {
  local api = mgfx.installGlobal("MGFX")
  api.RoundedBoxEx(16, 16, 220, 48, {
    radius = 8,
    fill = api.LinearGradient(0, 0, 1, 0, Color(80, 170, 255), Color(90, 220, 180)),
  })
}
```

如果你喜欢模块式调用，主包也导出 `mgfx.api`：

```lux
mgfx.api.roundedBoxEx(16, 16, 220, 48, { radius = 8, fill = Color(28, 34, 46) })
```

`@lux/mgfx/paint`、`@lux/mgfx/primitives`、`@lux/mgfx/widgets` 等子包仍可导入，但它们现在更适合内部维护、工具或很窄的依赖面；普通 UI 代码优先使用 `@lux/mgfx` / `mgfx.api`。

## 帧作用域

```lua
MGFX.StartPanel(panel, w, h)
MGFX.EndPanel()

MGFX.StartScreen(w, h)
MGFX.EndScreen()

MGFX.PushClip(x, y, w, h)
MGFX.PopClip()
```

所有坐标都相对于当前 active frame。`StartPanel` 会读取 panel 的屏幕位置并建立 panel-local 坐标系；调用方不要再手动把本地坐标转换成屏幕坐标。

形状、图像和 widget 通常立即绘制。文本和 clip command 会在 frame 内记录，并在 `EndPanel` / `EndScreen` 统一 flush，以便文本路由和 composer 能稳定工作。需要控制 painter order 时，先画底层 shape/image，再发出应当在上层显示的 text 调用。

`PushClip` / `PopClip` 是矩形 scissor，不是任意形状 mask 栈。形状 mask 是每个 primitive 自己的 shader coverage。

## 基础图元

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

`RoundedBoxEx` 使用 `style.radius`，`ChamferBoxEx` 使用 `style.cuts`，`LineEx` 使用 `style.width`。`Poly` / `PolyEx` 的 public contract 是凸多边形；复杂路径应先拆成凸片段。

常用凸多边形不用手写点表：

- `RegularPoly` 是正多边形，`sides` 限制为 3..8；三角形语义请用 `RegularPoly(..., 3, ...)`，不要猜一个含糊的 `Triangle`。
- `Diamond` 是盒子内的上/右/下/左四点菱形。
- `Caret` 是方向明确的三角箭头，`direction` 支持 `"right"`、`"left"`、`"up"`、`"down"`；`CaretEx` 可用 `style.direction` 或 `style.dir`。

## 阴影、Glow 与 Backdrop

`shadow`、`outerGlow` 和 `backdrop` 是三个不同的 style 字段：

- `shadow` 是外部软阴影 pass，默认 `x = 0, y = 4`，适合表达投影。Rounded、Circle、Capsule、Chamfer、Ring、Arc、Sector 和 texture/image mask 使用 shader 外部 pass；Convex Poly 仍使用轮廓 fallback。
- `outerGlow` 是外部光晕 pass，默认无偏移，适合表达发光边缘。
- `backdrop` 是 shape/image 覆盖范围内的背景 blur/tint，不是阴影。

`shadow` 和 `outerGlow` 都支持偏移：

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    shadow = {
        x = 0,
        y = 8,
        blur = 18,
        spread = 2,
        color = Color(0, 0, 0, 120),
        softness = 0.62,
    },
    outerGlow = {
        x = 0,
        y = 0,
        width = 16,
        color = Color(70, 205, 255, 76),
        softness = 0.55,
    },
})
```

可用别名：

```lua
shadow = true
shadow = 14
shadow = Color(...)
shadow = {
    x = 0, y = 8,
    offsetX = 0, offsetY = 8,
    dx = 0, dy = 8,
    offset = {x = 0, y = 8},
    blur = 18,      -- aliases: radius, size, width
    spread = 2,     -- shape grow; aliases: grow, expand, shapeSpread
    extent = 22,    -- draw padding; alias: padding
    opacity = 1,    -- alias: strength
    softness = 0.62 -- or falloff
}
```

`innerGlow` 始终裁剪在 shape 内部，当前不支持偏移。

推荐取值范围：

| 字段 | 推荐值 | 说明 |
| --- | --- | --- |
| `shadow.x / shadow.y` | 小控件 `y = 1..3`，面板 `y = 4..10` | 像素偏移；正 x 向右，正 y 向下。 |
| `shadow.blur` | 小控件 `4..8`，面板 `10..20`，大遮罩 `20+` | 阴影软边宽度，不是偏移。 |
| `shadow.spread` | `0..3` 常用 | 先扩大形状再做软边；不是 blur。 |
| `outerGlow.size / width` | `6..18` 常用 | 发光半径；需要偏移时使用 x/y。 |
| `innerGlow.width / size` | `4..14` 常用 | 裁剪在形状内部，无偏移。 |
| `softness` | `0..1`，常用 `0.55..0.75` | 数值越大越柔和；锐利 HUD 光可用 `0.35..0.55`。 |
| `opacity / strength` | 推荐 `0..1` | 当前实现允许略高于 1，但只有夸张高光才建议这样做。 |
| `backdrop.blur` | `3..10` 常用 | 只模糊形状内部背景，不产生投影。 |

Backdrop 不是独立 primitive，而是 shape/image 的内部背景效果：

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = Color(0, 0, 0, 0),
    backdrop = {
        blur = 6,
        tint = Color(8, 14, 24, 110),
        opacity = 1,
    },
})
```

支持的简写：

```lua
backdrop = true         -- blur = 4
backdrop = 6            -- blur = 6
backdrop = Color(...)   -- only tint
backdrop = {blur = 6, tint = Color(...), opacity = 0.8}
```

`style.backdrop` 会按当前 shape coverage 裁剪。Rounded、Circle、Capsule、Chamfer、Poly、Line、Ring、Arc、Sector 和 Image mask 都使用自己的形状范围来裁剪 blur/tint。不要再使用旧的 `BackdropEx` 思路，也不要用 backdrop 去模拟 drop shadow。

如果需要暗角或额外光效，单独叠一个透明渐变 fill：

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = MGFX.RadialGradient(0.5, 0.5, 0.85, {
        {0, Color(0, 0, 0, 0)},
        {1, Color(0, 0, 0, 96)},
    }),
})
```

透明渐变的最后一个 stop 必须显式写 `alpha = 0`。缺省 alpha 是 `255`，否则透明衰减可能变成不透明黑层。

## 图像与遮罩

```lua
MGFX.Image(x, y, w, h, source, radius, tint)
MGFX.ImageEx(x, y, w, h, source, style)

MGFX.Icon(x, y, w, h, source, tint)
MGFX.IconEx(x, y, w, h, source, style)
```

`Image` 是普通图像路径。需要 `fit`、`crop`、`uv`、`mask`、`outerGlow`、背景 fill 或高级 stroke 时使用 `ImageEx`。

显式 mask 写法：

```lua
mask = MGFX.Mask("rounded", {radius = 8})
mask = MGFX.Mask("chamfer", {cuts = {tl = 10, tr = 0, br = 10, bl = 0}})
mask = MGFX.Mask("circle")
mask = MGFX.Mask("capsule")
mask = MGFX.Mask("texture", {
    source = maskMaterial,
    channel = "a", -- a, r, g, b, luma
})
```

圆形头像是普通图像加 circle mask：

```lua
MGFX.ImageEx(x, y, size, size, avatarMaterial, {
    mask = MGFX.Mask("circle"),
    fit = "cover",
})
```

## 组件图元

```lua
MGFX.ProgressBar(x, y, w, h, value, radius, track, fill, stroke, strokeWidth)
MGFX.ProgressBarEx(x, y, w, h, value, style)

MGFX.SegmentBar(x, y, w, h, value, segments, fill, track)
MGFX.SegmentBarEx(x, y, w, h, value, style)

MGFX.Ring(cx, cy, radius, width, fill)
MGFX.RingEx(cx, cy, radius, width, style)

MGFX.Arc(cx, cy, radius, startDeg, endDeg, width, fill)
MGFX.ArcEx(cx, cy, radius, width, startDeg, endDeg, style)

MGFX.Sector(cx, cy, innerRadius, outerRadius, startDeg, endDeg, fill)
MGFX.SectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, style)
```

Ring 和 Arc 的厚度是显式 `width` 参数，不放进 `style.width`。Sector 的环形几何由 `innerRadius, outerRadius` 显式声明；`innerRadius = 0` 表示实心扇形。

`ArcEx` 是圆头圆弧，适合 gauge、进度弧和圆形刻度。`SectorEx` 是直边径向扇区，适合轮盘菜单和环形 wedge。二者不能混为一个形状，因为端点几何和 SDF 边界不同。

Wheel sector 示例：

```lua
MGFX.SectorEx(cx, cy, innerR, outerR, startDeg, endDeg, {
    fill = MGFX.SectorAngularGradient(
        Color(36, 40, 48, 150),
        Color(150, 150, 160, 130)
    ),
    stroke = Color(255, 255, 255, 36),
    strokeWidth = 1,
})
```

## 文本

```lua
MGFX.RegisterTextFont(name, spec)
MGFX.DefineTextStyle(name, style)
MGFX.GetTextStyle(name)
MGFX.ResolveTextStyle(style)
MGFX.MeasureText(text, font)
MGFX.MeasureTextBox(text, font, w, style)
MGFX.PrewarmText(text, font, style)

MGFX.Text(text, font, x, y, color, ax, ay)
MGFX.TextEx(text, font, x, y, color, ax, ay, style)

MGFX.TextBox(text, font, x, y, w, h, color, alignX, alignY)
MGFX.TextBoxEx(text, font, x, y, w, h, style)
```

普通文本走原生 GMod text。Scoreboard 行、玩家名、聊天、日志、表格和快速变化数字，不需要 shader 特效时应直接走原生文本。

只有需要 gradient fill、shadow、stroke/outline、glow、surface polish 或 shader-side weight adjust 时，才进入 MGFX whole-run composer。`PrewarmText` 只对 composer 路径有效，普通文本会返回 `false`。

## 绘制记录、渐变与图案

```lua
MGFX.Solid(color)
MGFX.LinearGradient(x1, y1, x2, y2, colorA, colorB)
MGFX.LinearGradient(x1, y1, x2, y2, stops)
MGFX.LinearGradientStops(x1, y1, x2, y2, stops)
MGFX.RadialGradient(cx, cy, radius, colorA, colorB)
MGFX.RadialGradient(cx, cy, radius, stops)
MGFX.ConicGradient(cx, cy, rotationDeg, colorA, colorB)
MGFX.ConicGradient(cx, cy, rotationDeg, stops)
MGFX.RingRadialGradient(stops)
MGFX.SectorRadialGradient(stops)
MGFX.ShapeAngularGradient(stops, rotationDeg)
MGFX.RingAngularGradient(stops, rotationDeg)
MGFX.ArcAngularGradient(stops, rotationDeg)
MGFX.SectorAngularGradient(stops, rotationDeg)
MGFX.StripePattern(spec)
MGFX.SmokePattern(spec)
```

所有 gradient helper 都支持 stops，并通过统一 LUT 采样。差异只在 `t` 的几何含义：

| Helper | `t` 空间 |
| --- | --- |
| `LinearGradient` | primitive-local linear axis |
| `RadialGradient` | primitive-local radial distance，并按短边修正避免矩形拉伸 |
| `ConicGradient` | 以 normalized center 为中心的完整 360 度角场 |
| `RingRadialGradient` / `SectorRadialGradient` | ring/sector local innerRadius 到 outerRadius |
| `ShapeAngularGradient` / `RingAngularGradient` / `ArcAngularGradient` / `SectorAngularGradient` | 当前 shape 的 startDeg 到 endDeg |

Stop 表写法：

```lua
local stops = {
    Color(80, 170, 255),                         -- 按索引自动分布
    {0.35, Color(90, 220, 180)},                 -- compact {pos, color}
    {pos = 0.70, color = Color(255, 210, 110)},  -- named form
    {offset = 1, color = Color(255, 96, 78, 0)}, -- pos/t/offset 都可用
}
```

Pattern 是 shader paint slot，不是几何 recipe。不要在 UI 层把斜线或烟雾拆成大量 `LineEx`。需要大面积 stripe/smoke 时，应补对应 shape 的 pattern shader path。

## 视觉变换

`style.transform` 是绘制阶段的视觉 transform，不改变 layout、input hit test、frame 坐标或矩形 clip。

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(28, 34, 46, 230),
    transform = {
        origin = "50% 50%",
        perspective = 900,
        rotateX = -4,
        rotateY = 6,
        scale = 1.02,
        steps = 12,
    },
})
```

指针驱动的 2.5D 效果使用 helper：

```lua
local tilt = MGFX.PointerTilt(mx, my, {
    origin = "50% 50%",
    perspective = 900,
    maxRotateX = 4,
    maxRotateY = 6,
    strength = hoverAmount,
    scaleLift = 0.01,
    steps = 12,
})
```

复合绘制使用 transform stack：

```lua
if MGFX.PushTransform(tilt, x, y, w, h) then
    MGFX.RoundedBoxEx(x, y, w, h, {radius = 12, fill = panelFill})
    MGFX.RingEx(cx, cy, 42, 6, {fill = ringFill})
    MGFX.PopTransform()
end
```

## 常见 style 字段

Shape:

```lua
{
    fill = Color(...) or MGFX.LinearGradient(...),
    stroke = Color(...),
    strokeWidth = 1,
    radius = 8,
    cuts = 8,
    shadow = {x = 0, y = 8, blur = 18, spread = 2, color = Color(...)},
    backdrop = {blur = 6, tint = Color(...)},
    innerGlow = {color = Color(...), width = 10, opacity = 0.6},
    outerGlow = {x = 0, y = 0, color = Color(...), width = 18, opacity = 0.6},
    pattern = MGFX.SmokePattern(...),
    transform = MGFX.PointerTilt(mx, my, {perspective = 900}),
}
```

Image:

```lua
{
    tint = Color(...),
    alpha = 0.9,
    fit = "cover", -- fill, contain, cover
    position = {x = 0.5, y = 0.5},
    crop = {x = 0, y = 0, w = 1, h = 1},
    uv = {u0 = 0, v0 = 0, u1 = 1, v1 = 1},
    mask = MGFX.Mask("chamfer", {cuts = 8}),
    shadow = {...},
    outerGlow = {...},
    backdrop = {...},
}
```

Ring / Arc / Sector:

```lua
{
    fill = Color(...) or MGFX.SectorAngularGradient(...),
    stroke = Color(...),
    strokeWidth = 1,
    shadow = {...},
    backdrop = {blur = 6, tint = Color(...)},
    pattern = MGFX.StripePattern(...),
    innerGlow = {...},
    outerGlow = {...},
}
```

## 能力查询

```lua
MGFX.GetCapabilities(MGFX.TARGET.ROUNDED_BOX)
MGFX.Supports(MGFX.TARGET.RING, "outerGlow")
```

能力表描述的是已经实现的 render slots，不是计划表。当前 shape rendering 以 immediate shader/fallback path 为主；旧的 shape/data-texture batch prototype 已移除，原因见 [已移除的 Shape 批处理设计](./BATCHING)。
