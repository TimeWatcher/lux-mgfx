# 详细 API 参考

这里是 MGFX public API 的逐函数参考。概念说明、推荐使用方式和整体设计边界请先看 [API 总览](../API.md)。

API 名称、Lua 参数名和 shader 术语保留英文；解释性文本统一使用中文。

## 分组入口

<div class="mgfx-capability-grid">
  <a href="./frame">
    <span>Frame</span>
    <strong>帧作用域与调试</strong>
    <small>管理 MGFX 绘制帧、矩形裁剪和调试叠层。所有坐标都相对于当前 active frame。</small>
  </a>
  <a href="./primitives">
    <span>Shape</span>
    <strong>基础图元</strong>
    <small>Rounded、Chamfer、Poly、Line、Circle、Capsule 以及通用 shape style 能力。</small>
  </a>
  <a href="./images">
    <span>Image</span>
    <strong>图像与遮罩</strong>
    <small>图像、图标、fit/crop/uv、shape mask、texture mask 和 image-specific glow/backdrop。</small>
  </a>
  <a href="./widgets">
    <span>Widget</span>
    <strong>组件图元</strong>
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

- 新代码先看 [API 总览](../API.md)，确认 MGFX 的边界和通用 style 写法。
- 查具体签名、字段、默认值和示例时，再进入对应分组页。
- 改 public API 时，同步更新概念页和详细分组页；不要只改 demo 或注释。

## 分组说明

- **帧作用域与调试**：管理 MGFX 绘制帧、矩形裁剪和调试叠层。所有坐标都相对于当前 active frame。
- **基础图元**：Rounded、Chamfer、Poly、Line、Circle、Capsule 以及通用 shape style 能力。
- **图像与遮罩**：图像、图标、fit/crop/uv、shape mask、texture mask 和 image-specific glow/backdrop。
- **组件图元**：ProgressBar、SegmentBar、Ring、Arc、Sector 这些 renderer-level widget。
- **文本 API**：字体别名、文本样式、测量、预热、原生文本路径和 shader text effects。
- **绘制记录、图案、变换与能力**：Color/gradient paint record、程序化 pattern、2.5D transform helper 和 capability query。
