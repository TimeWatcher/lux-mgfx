---
layout: home

hero:
  name: "MGFX"
  text: "Modern GMod FX"
  tagline: "面向 Garry's Mod UI 的 shader-backed immediate renderer。先选择 GLua 或 Lux，再用同一套概念绘制形状、图像、数值组件、文字特效、渐变、遮罩、glow 和 backdrop。"
  actions:
    - theme: brand
      text: 从 GLua 开始
      link: /zh-CN/guide/glua
    - theme: alt
      text: 从 Lux 开始
      link: /zh-CN/guide/lux
    - theme: alt
      text: 查看 API 参考
      link: /zh-CN/api-reference/
    - theme: alt
      text: English
      link: /

features:
  - title: 先选运行时
    details: 普通 GMod addon 使用 lua-mgfx 和 MGFX.*；Lux 项目导入 @lux/mgfx，使用 mgfx.api.*。
  - title: Renderer，不是 UI framework
    details: MGFX 每帧绘制调用方传入的明确状态；layout、input、focus、animation 和 hit testing 仍由调用方管理。
  - title: 按形状裁剪的效果
    details: Rounded、Chamfer、Polygon、Ring、Sector、Image 和 Mask 都按自身覆盖范围处理 shadow、glow、backdrop 和 pattern。
  - title: GLua / Lux 对照示例
    details: 面向用户的指南同时给出两种实现，不再要求读者自行猜测 API 名称和入口。
---

## 快速开始

::: code-group

```lua [GLua]
function PANEL:Paint(w, h)
    MGFX.StartPanel(self, w, h)

    MGFX.RoundedBoxEx(0, 0, w, h, {
        radius = 10,
        fill = Color(8, 14, 20, 170),
        backdrop = {blur = 8, tint = Color(0, 8, 12, 120)},
        outerGlow = {color = Color(70, 205, 255, 64), width = 12},
    })

    MGFX.ProgressBarEx(24, 84, w - 48, 10, 0.72, {
        radius = 5,
        track = Color(10, 18, 24, 190),
        fill = MGFX.LinearGradient(0, 0, 1, 0, Color(30, 130, 255), Color(255, 210, 110)),
    })

    MGFX.EndPanel()
end
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

fn PANEL:Paint(w, h) {
  local draw = mgfx.api
  draw.startPanel(self, w, h)

  draw.roundedBoxEx(0, 0, w, h, {
    radius = 10,
    fill = Color(8, 14, 20, 170),
    backdrop = {blur = 8, tint = Color(0, 8, 12, 120)},
    outerGlow = {color = Color(70, 205, 255, 64), width = 12},
  })

  draw.progressBarEx(24, 84, w - 48, 10, 0.72, {
    radius = 5,
    track = Color(10, 18, 24, 190),
    fill = draw.linearGradient(0, 0, 1, 0, Color(30, 130, 255), Color(255, 210, 110)),
  })

  draw.endPanel();
}
```

:::

## 从这里开始

<div class="mgfx-capability-grid">
  <a href="./guide/glua">
    <span>GLua</span>
    <strong>普通 GLua 快速开始</strong>
    <small>把 lua-mgfx 作为普通 GMod addon 安装，并在客户端绘制代码中调用 MGFX.*。</small>
  </a>
  <a href="./guide/lux">
    <span>Lux</span>
    <strong>Lux 快速开始</strong>
    <small>安装 @lux/mgfx，导入 mgfx.api，并使用 lowerCamelCase 门面。</small>
  </a>
  <a href="./guide/concepts">
    <span>Guide</span>
    <strong>核心概念</strong>
    <small>理解 frame scope、Name/NameEx、style table、文字路径和命名映射。</small>
  </a>
  <a href="./api-reference/">
    <span>Reference</span>
    <strong>API 参考</strong>
    <small>查询准确签名、参数表、style 字段、返回值和边界条件。</small>
  </a>
</div>

## 推荐阅读顺序

1. 先选择 [普通 GLua](./guide/glua) 或 [Lux](./guide/lux)。
2. 复制复杂效果前阅读 [核心概念](./guide/concepts)。
3. shadow、glow、backdrop 和 pattern 查 [特效指南](./guide/effects)。
4. 需要准确字段时再进入 [API 参考](./api-reference/)。

## 边界

MGFX 是 renderer，不是 UI framework。它不拥有 layout、input、focus、component lifecycle、transition state 或 hit testing。调用方每帧计算视觉状态，再把明确参数传给 `MGFX.*` 或 `mgfx.api.*`。

普通标签优先使用原生 GMod text 或 `Text`。只有需要渐变字面、描边、glow 或高质量 shadow 时才使用 `TextEx`。

## 维护规则

- public API 变化必须同步更新 [核心概念](./guide/concepts) 和对应的 [API 参考页](./api-reference/)。
- 面向用户的通用示例应同时给出 GLua 与 Lux；明确只讨论某一运行时的页面除外。
- shader 参数、gradient LUT、alpha 或 shaderpack 变化同步更新 [Shader 与打包](./SHADERS)。
- 性能路径变化同步更新 [性能模型](./PERFORMANCE)。
- 不要手改 `docs-site/`；修改 `docs/` 后重新构建。
