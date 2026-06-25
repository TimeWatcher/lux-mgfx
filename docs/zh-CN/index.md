---
layout: home

hero:
  name: "MGFX"
  text: "Modern GMod FX"
  tagline: "Garry's Mod 的 shader-backed immediate UI renderer。保留直接绘制的心智模型，把抗锯齿、渐变、mask、glow、backdrop、ring/sector 和可选文字特效放进明确的渲染 API。"
  actions:
    - theme: brand
      text: 阅读 API
      link: /zh-CN/API
    - theme: alt
      text: 查看详细参考
      link: /zh-CN/api-reference/

features:
  - title: 直接绘制优先
    details: Shape 和 widget 走直接 shader/fallback 路径；public API 边界以下使用 prepared scalar 参数。
  - title: 按形状裁剪的效果
    details: Rounded、Chamfer、Circle、Capsule、Ring、Arc、Sector、Image mask 都按自身覆盖范围处理 glow 和 backdrop。
  - title: 完整 stop 渐变
    details: Linear、Radial、Conic、Ring/Sector local radial、Shape angular 都走统一 LUT stop 路径。
  - title: 矩阵参数上传
    details: 热路径参数优先用 $viewprojmat / c11 和 $invviewprojmat / c15 一次上传，SetFloat 只作为兼容或诊断手段。
  - title: 实测 shop 性能
    details: 复杂 shop UI 满列表可稳定 130+ FPS，商品较少分类可稳定 160+ FPS，测试时关闭 profile/draw_counts。
---

## 快速开始

```lua
function PANEL:Paint(w, h)
    MGFX.StartPanel(self, w, h)

    MGFX.RoundedBoxEx(0, 0, w, h, {
        radius = 10,
        fill = Color(8, 14, 20, 170),
        backdrop = {
            blur = 8,
            tint = Color(0, 8, 12, 120),
        },
    })

    MGFX.ProgressBarEx(24, 84, w - 48, 10, 0.72, {
        radius = 5,
        track = Color(10, 18, 24, 190),
        fill = MGFX.LinearGradient(0, 0, 1, 0, {
            {0.00, Color(30, 130, 255, 230)},
            {0.55, Color(60, 200, 255, 230)},
            {1.00, Color(255, 210, 110, 230)},
        }),
    })

    MGFX.EndPanel()
end
```

## 文档入口

<div class="mgfx-capability-grid">
  <a href="./API">
    <span>API</span>
    <strong>总览</strong>
    <small>帧作用域、图元、图像、组件、文本、绘制记录、视觉变换和能力查询。</small>
  </a>
  <a href="./api-reference/">
    <span>参考</span>
    <strong>详细 API</strong>
    <small>按功能分组的逐函数参数表、注意事项、返回值和示例。</small>
  </a>
  <a href="./PERFORMANCE">
    <span>性能</span>
    <strong>性能模型</strong>
    <small>immediate 路径、matrix 参数上传、pattern 数学化和分配规则。</small>
  </a>
  <a href="./SHADERS">
    <span>Shader</span>
    <strong>Shader 与打包</strong>
    <small>shaderpack 构建、参数布局、gradient LUT、GMA 校验和踩坑记录。</small>
  </a>
</div>

## 核心边界

MGFX 是底层 renderer，不是 UI framework。它不拥有 layout、input、focus、component lifecycle 或 transition state。调用方每帧计算当前视觉状态，再把明确的 draw arguments 传给 `MGFX.*`。

文本也不是“全部进 MGFX composer”。普通文本优先走原生 GMod text；只有需要 shader text effects 的内容才进入 whole-run composer。

## 维护规则

- 改 public API 时，同步更新 [API 总览](./API) 和对应的 [详细 API 任务页](./api-reference/)。
- 改 shader 参数布局、gradient LUT、alpha 处理或 shaderpack 构建时，同步更新 [Shader 构建与打包](./SHADERS)。
- 改性能路径时，同步更新 [MGFX 性能模型](./PERFORMANCE)。
- 不要手改 `docs-site/` 产物；修改 `docs/` 源文件后重新构建。

## 示例：轮盘扇区

```lua
local fill = MGFX.SectorAngularGradient({
    {0.00, Color(35, 212, 232, 170)},
    {0.52, Color(80, 220, 160, 150)},
    {1.00, Color(245, 158, 11, 135)},
})

MGFX.SectorEx(cx, cy, innerR, outerR, startDeg, endDeg, {
    fill = fill,
    stroke = Color(255, 255, 255, 34),
    strokeWidth = 1,
    backdrop = {blur = 7, tint = Color(4, 10, 14, 120)},
    innerGlow = {color = Color(255, 96, 78, 90), width = 28},
    transform = MGFX.PointerTilt(mx, my, {
        perspective = 900,
        maxRotateX = 4,
        maxRotateY = 6,
    }),
})
```
