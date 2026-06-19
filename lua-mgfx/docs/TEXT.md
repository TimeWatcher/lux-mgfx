# MGFX 文本渲染

MGFX text 不是“所有文字都进 composer”。当前文本渲染有两条明确路径：

1. 普通文本走 GMod 原生绘制。单行、无特效的 `TextEx` 会落到 `draw.SimpleText`；多行、tracking 和显式 line-height 使用一个轻量原生布局 helper。
2. 需要 shader-side effects 的文本走 whole-run native-raster composer。整段文字先烘焙到持久 atlas page，再通过文本 shader 合成绘制。

不要把 MGFX text 当成原生文字的通用替代品。Scoreboard、日志、聊天、密集表格和普通 label 默认应该用原生 GMod text，除非它们确实需要 MGFX-only 特效。

## 路由规则

`MGFX.Text`、`MGFX.TextEx`、`MGFX.TextBox` 和 `MGFX.TextBoxEx` 会创建文本记录。flush 时按记录内容选择路由：

```text
no shader work       -> native
style.native         -> native/native fallback
style.noComposed     -> native/native fallback
shader work present  -> whole-run composer
```

这里的 shader work 指至少包含以下之一：

- MGFX gradient fill
- shadow
- stroke/outline
- glow
- `surface` 字面 polish
- `bold`、`thin` 或 `weightAdjust`

如果 composer 被关闭、不可用、超过单帧 bake budget，或 bake 失败，该记录会在当前帧走 native fallback。Native fallback 可以近似 color、shadow 和 stroke，但不能复刻 shader glow、surface polish 或 shape-correct gradient fill。

旧的 glyph-composer route 已经移除。文本路由不再是 public style control。

## 字体别名

`RegisterTextFont(name, spec)` 注册 native 路径和 composer 路径共享的字体别名。如果提供 `spec.face`，MGFX 会内部创建 native font。如果没有提供 face，MGFX 会使用 `spec.sourceFont`、`spec.nativeFont`，或 GMod 里已经存在的同名字体。

```lua
MGFX.RegisterTextFont("HUDTitleFX", {
    face = "Bahnschrift",
    size = 28,
    weight = 700,
    lineHeight = 34,
})
```

对于没有注册 `face` 的现有 GMod font，MGFX 无法安全创建真正的 bold/thin/italic 变体，因为它不知道原始字体族。需要变体时，注册别名时应明确写出 `face`、`size` 和 `weight`。

默认 CJK face 是 `Noto Sans SC`，来自 `resource/fonts/notosanssc-vf.ttf`。

## 支持的特效

Composer 支持：

- solid color 和 MGFX gradient fill
- line height 和 tracking
- soft shadow
- outer glow
- 带 `softness` 的 outline/stroke
- `surface` 字面 polish
- shader-side bold/thin weight adjustment
- text box wrapping 和 ellipsis

示例：

```lua
MGFX.TextEx("TEXT FX", "HUDTitleFX", x, y, Color(235, 246, 255),
    TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, {
        fill = MGFX.LinearGradient(0, 0, 1, 0,
            Color(130, 220, 255),
            Color(255, 170, 110)
        ),
        stroke = {width = 0.55, softness = 0.60, color = Color(0, 0, 0, 130)},
        glow = {size = 5, softness = 0.65, color = Color(80, 190, 255, 70)},
    })
```

UI outline 质量主要靠 `stroke.softness`。硬黑描边适合 debug 对比，但在 scoreboard 和 HUD label 上会显得粗糙。常用范围：

```lua
stroke = {
    width = 0.55,
    softness = 0.60,
    color = Color(0, 0, 0, 120),
}
```

`surface` 只用于轻微字面 polish。常用范围是 `0.06` 到 `0.18`；中文和小字号 label 应靠低值。

```lua
surface = {strength = 0.10}
```

## 预热

`PrewarmText(text, font, style)` 只对会进入 composer 的记录有效。普通文本返回 `false`，因为它不属于 atlas。

稳定 FX text 可以预热，避免首帧 bake 抖动：

```lua
MGFX.PrewarmText("ROUND START", "HUDTitleFX", {
    glow = {size = 6, color = Color(80, 190, 255, 90)},
})
```

不要预热普通 label、玩家名、聊天行或 scoreboard row，除非它们真的使用 shader effects。

## 性能模型

Native text 是便宜路径，默认适合：

- scoreboard row text
- 没有 shader effects 的玩家名
- 表格和虚拟列表
- chat/log
- 高频变化 counter
- 普通 label 和 header

Composer text 是昂贵路径。Cache hit 可以避免 rebake，但仍然要付 style routing、material setup、atlas bookkeeping 和 textured blit 的成本。Cache miss 会在当前 paint pass 里把 native glyph run 烘焙进 RT。

高 churn FX text 会为每个不同字符串占用一个 whole-run atlas entry。Counter 不需要 shader effects 时直接原生绘制；确实需要特效时，尽量让取值集合稳定、预热已知值，或者接受 bake 成本。

有用 cvar：

```text
mgfx_text_composed 0/1
mgfx_text_composed_budget 6
```

`mgfx_text_composed_budget` 限制每帧 cache miss bake 数。预算耗尽时，该文字本帧走 native fallback，之后再尝试 composer。

`mgfx_text_status` 是第一健康检查。稳定 FX text 帧里这些值应该低或接近 0：

```text
fallbackBatches
fallbackRecords
prewarmFails
prewarmRestarts
evicts
```

常用 profiler label：

```text
text.nativePlain      普通原生路径
text.nativeFallback   composer 记录的原生 fallback
text.prepareRoutes    路由选择
text.prewarm          queued composer record 的预烘焙
text.entryFor         cache lookup / bake
text.composeBatch     atlas blit batching
text.dispatch         最终路由分发
```

## Bake Render State

Atlas bake 发生在宿主 VGUI `Paint` / `HUDPaint` 过程中：

```text
MGFX.EndPanel / EndScreen -> flushFrame -> renderer.Flush -> bake
```

此时 surface library 的 ambient render state 仍然有效。危险状态是 surface alpha multiplier：如果宿主 panel 正在用 `panel:SetAlpha(0)` 和 `panel:AlphaTo(255, t)` 淡入，首次 bake 发生时 `surface.GetAlphaMultiplier()` 可能小于 1。这样烘焙进 atlas 的 glyph 会偏淡甚至空白，而且坏 slot 会被缓存。

每次 RT glyph bake 都必须在绘制期间中和 ambient state，再恢复它。`bake` 会用 `beginAtlasDraw()` / `endAtlasDraw()` 包住 `drawLayout`，强制：

```text
surface alpha multiplier = 1
render color modulation  = 1,1,1
render blend             = 1
```

Atlas 存储全不透明 glyph。屏幕上的 panel fade 应该在后续 blit 时应用，这时继承 panel alpha 才是正确的。

## RT 与 UV 规则

Composer atlas copy 不要使用 `surface.DrawTexturedRectUV`。运行时材质可能遇到 GMod 的 half-pixel UV correction 行为。Composer 使用显式四点 `surface.DrawPoly` quad 和手写 `u/v`。

Text atlas RT 不要带 `TEXTUREFLAGS_POINTSAMPLE`。文本 atlas 必须保持线性过滤，否则 native glyph antialiasing 在 compose blit 时会变成硬阶梯。

Composer atlas page 不要高于可靠的 native 2D text bake 区域。当前使用 2048x1024 page，通过更多 page 扩容。

推入 render target 时必须显式 viewport：

```lua
render.PushRenderTarget(rt, 0, 0, atlasW, atlasH)
```

离开 RT 后要恢复 MGFX clip scissor。

## Atlas 管理

Text atlas 最多使用 16 个 2048x1024 page。分配进入保留尾页时，MGFX 会标记下一次 flush boundary 做 reset。不能在 flush 中途 reset，因为那会让已排队绘制的 entry 失效。

Reset 时必须完整清空 atlas page。每次 bake 前仍会清理单个 slot，但 full RT clear 可以保证 generation reset 后不会采样到旧 glyph 像素。

## 已移除路径

这些路径已经明确移除：

- legacy font-atlas Lua module
- text SDF/MTSDF shader
- static score text atlas resource
- glyph composer
- SDF glyph atlas
- SDF data-texture batching

后续文本工作应该在“原生路径”或“whole-run composer”上扩展，并拿 profiling 结果证明收益。不要重新引入 runtime SDF from alpha glyphs。
