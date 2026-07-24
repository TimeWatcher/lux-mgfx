# 详细 API 参考

这里是 MGFX public API 的逐函数参考，只负责准确签名、字段、返回值和边界条件。第一次使用请先看 [普通 GLua 快速开始](../guide/glua)、[Lux 快速开始](../guide/lux) 或 [核心概念](../guide/concepts)。

API 名称、Lua 参数名和 shader 术语保留英文；解释性文本统一使用中文。

这些页面只是按绘制任务组织的文档分组，不是模块入口。普通 GLua 代码直接调用 `MGFX.*`，Lux 代码使用 `@lux/mgfx` 的 `mgfx.api.*`。

## 运行时名称对照

| 普通 GLua | Lux |
| --- | --- |
| `MGFX.StartPanel(...)` | `mgfx.api.startPanel(...)` |
| `MGFX.RoundedBoxEx(...)` | `mgfx.api.roundedBoxEx(...)` |
| `MGFX.ImageEx(...)` | `mgfx.api.imageEx(...)` |
| `MGFX.Mask(...)` | `mgfx.api.mask(...)` |
| `MGFX.Clip(...)` | `mgfx.api.clip(...)` |
| `MGFX.ProgressBarEx(...)` | `mgfx.api.progressBarEx(...)` |
| `MGFX.LinearGradient(...)` | `mgfx.api.linearGradient(...)` |
| `MGFX.TextEx(...)` | `mgfx.api.textEx(...)` |

## 按需求选择

| 你要做什么 | 先看哪里 | 直接可用的入口 |
| --- | --- | --- |
| 面板、按钮、徽章、箭头、凸多边形 | [形状与线条](./primitives) | `RoundedBoxEx`、`ChamferBoxEx`、`RegularPolyEx`、`DiamondEx`、`CaretEx`、`PolyEx` |
| 头像、图标、fit/crop、圆形/切角/纹理单图遮罩 | [图像与单图遮罩](./images) | `ImageEx`、`IconEx`、image `style.mask` |
| 血条、弹药格、圆环、仪表、轮盘扇区 | [HUD 数值组件与扇区](./widgets) | `ProgressBarEx`、`SegmentBarEx`、`RingEx`、`ArcEx`、`SectorEx` |
| 普通文字、描边文字、glow 标题、多行文本框 | [文本 API](./text-api) | `Text`、`TextEx`、`TextBoxEx`、`MeasureTextBox` |
| 线性/圆形与椭圆径向/角向渐变、stops、pattern、2.5D transform | [绘制记录、图案、变换与能力](./paint) | `LinearGradient`、`RadialGradient`、`EllipticalRadialGradient`、`SectorAngularGradient`、`StripePattern`、`WornPattern`、`PointerTilt` |
| VGUI Paint / HUDPaint 中的 MGFX 生命周期 | [帧作用域与调试](./frame) | `StartPanel`、`StartScreen`、`PushClip`、`Mask`、`Clip`、`DebugOverlay` |
| 多次绘制共享抗锯齿边界、布尔 coverage、shape 自遮罩 | [Coverage Mask、Clip 与 Shape 自遮罩](./masks-and-clip) | `Mask`、`Clip`、`Masks`、`Invalidate`、shape `children` callback |

如果只是要一个普通控件，优先用短签名或对应的 `Ex` style 表。

## 分组入口

<div class="mgfx-capability-grid">
  <a href="./frame">
    <span>Frame</span>
    <strong>帧作用域与调试</strong>
    <small>管理 MGFX 绘制帧、矩形裁剪和调试叠层。所有坐标都相对于当前 active frame。</small>
  </a>
  <a href="./masks-and-clip">
    <span>Mask</span>
    <strong>Coverage Mask、Clip 与自遮罩</strong>
    <small>自定义布尔 coverage、解析式 preset、缓存失效、回调事务与 shape 自身边界裁剪。</small>
  </a>
  <a href="./primitives">
    <span>Shape</span>
    <strong>形状与线条</strong>
    <small>Rounded、Chamfer、RegularPoly、Diamond、Caret、Poly、Line、Circle、Capsule 以及通用 shape style 能力。</small>
  </a>
  <a href="./images">
    <span>Image</span>
    <strong>图像与单图遮罩</strong>
    <small>图像、图标、fit/crop/uv、shape mask、texture mask 和 image-specific glow/backdrop。</small>
  </a>
  <a href="./widgets">
    <span>Meter</span>
    <strong>HUD 数值组件与扇区</strong>
    <small>ProgressBar、SegmentBar、Ring、Arc、Sector 这些 renderer-level widget。</small>
  </a>
  <a href="./text-api">
    <span>Text</span>
    <strong>文本 API</strong>
    <small>字体别名、文本样式、测量、预热、原生文本路径和 shader text effects。</small>
  </a>
  <a href="./paint">
    <span>Paint</span>
    <strong>绘制记录、图案、变换与能力</strong>
    <small>Color/gradient paint record、程序化 pattern、2.5D transform helper 和 capability query。</small>
  </a>
</div>

## 阅读顺序

1. 选择 [普通 GLua](../guide/glua) 或 [Lux](../guide/lux)。
2. 阅读 [核心概念](../guide/concepts)。
3. 根据绘制任务进入对应参考页。
4. 改热路径时再看 [性能模型](../PERFORMANCE)，改 shader 参数或 shaderpack 时看 [Shader 与打包](../SHADERS)。

## 任务页说明

- **帧作用域与调试**：管理 MGFX 绘制帧、矩形裁剪和调试叠层。所有坐标都相对于当前 active frame。
- **Coverage Mask、Clip 与自遮罩**：完整记录 Mask recorder、preset、失效/缓存、Clip 事务与四种 shape children callback。
- **形状与线条**：Rounded、Chamfer、RegularPoly、Diamond、Caret、Poly、Line、Circle、Capsule 以及通用 shape style 能力。
- **图像与单图遮罩**：图像、图标、fit/crop/uv、shape mask、texture mask 和 image-specific glow/backdrop。
- **HUD 数值组件与扇区**：ProgressBar、SegmentBar、Ring、Arc、Sector 这些 renderer-level immediate helper。
- **文本 API**：字体别名、文本样式、测量、预热、原生文本路径和 shader text effects。
- **绘制记录、图案、变换与能力**：Color/gradient paint record、程序化 pattern、2.5D transform helper 和 capability query。
