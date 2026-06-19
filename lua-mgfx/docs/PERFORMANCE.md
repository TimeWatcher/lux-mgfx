# MGFX 性能模型

MGFX 的性能目标不是“消灭 immediate”，而是在 immediate 心智模型下尽量减少 Lua 侧无意义工作、材质参数上传、临时表和临时 `Color`。GMod UI 常见问题不是 draw call 数量单独过高，而是每帧为了调度、归类、转换和上传参数付出过多 Lua/Source API 成本。

## 当前方向

- Shape 和 widget 保持 immediate shader/fallback path。
- 只保留经过实测的专用 fused shader，不恢复通用 data-texture batch scheduler。
- 常规 shape 参数优先通过 `$viewprojmat` / pixel shader `c11` 上传。
- `$c0..$c3` 只作为 fused shader 的辅助参数页。
- Pattern 在 shader 中数学化生成，不拆成大量 `LineEx` 或几何段。
- Scoreboard、表格、聊天和普通 label 文本优先走原生 GMod text。

## 参数上传

本地 GMod benchmark 结论：

```text
SetFloat x16             ~3.6-3.9 us/iter
SetUnpacked + SetMatrix  ~0.5-0.6 us/iter
```

因此 hot shape path 的 16 个常规 float 参数统一打包到 `Matrix():SetUnpacked(...)`，再用：

```lua
mat:SetMatrix("$viewprojmat", matrix)
```

HLSL 侧读取：

```hlsl
const float4x4 MGFXExtraParams : register(c11);
```

注意 Source/GMod 的矩阵索引按列抵达 HLSL。Lua 端打包必须使用 MGFX 的统一 helper，不要在调用点自己猜行列顺序。

`SetFloat("$cN_x", ...)` 仍然存在，但它是备用手段。只有一个 shader 已经用满 16 个主参数，并且为了视觉一致性确实需要同 pass 的额外数据时，才应该用 `$c0..$c3` 辅助页。

## Pattern 数学化

Pattern 不应该在调用层展开成许多 line、box 或 polygon。`StripePattern` 和 `SmokePattern` 是 paint slot，应该由对应 shape shader 根据当前 shape local space 直接采样。

正确方向：

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 8,
    fill = Color(8, 18, 24, 220),
    pattern = MGFX.StripePattern({
        color = Color(255, 255, 255, 22),
        spacing = 12,
        width = 2,
        angle = 135,
    }),
})
```

错误方向：

```lua
for i = 1, 40 do
    MGFX.LineEx(...)
end
```

如果某个界面需要大面积斜线、烟雾、扫描线或噪声底纹，优先补 shader pattern 能力，而不是在 UI 层堆 primitive。

## 融合 Shader 策略

专用 shader 是可行的，但必须复刻原始分层结果。允许的前提：

- 输入参数布局清晰，主参数走 `MGFXExtraParams`。
- 需要额外参数时只用 `$c0..$c3` 辅助页。
- 抗锯齿、stroke、透明渐变、pattern、glow、backdrop 和 blend order 与原路径一致。
- 不能为了少一个 pass 改变 source-over 视觉结果。

当前保留的 fused 路径：

```text
roundrect_fx   fill/stroke + innerGlow
chamfer        fill/stroke + optional innerGlow
ring_fx        fill/stroke + optional innerGlow
```

`outerGlow`、`backdrop`、`shadow` 和部分 `pattern` 仍可能是独立 pass，因为它们的 draw bounds、framebuffer read、blur source 或 blend order 是可见行为。

## 分配规则

Hot paint path 中避免这些写法：

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    fill = Color(20, 24, 32, 220),
})

local c = colorAlpha(baseColor, alpha)
```

第一种每帧创建 style table 和 `Color`。第二种如果返回新 `Color`，也会制造分配压力。MGFX 会尽量在内部复用 scratch record，但调用方仍然应该缓存稳定 style、pattern、gradient 和颜色对象。

更好的方向：

```lua
local panelFill = Color(20, 24, 32, 220)
local panelStyle = {
    radius = 8,
    fill = panelFill,
}

function PANEL:Paint(w, h)
    MGFX.RoundedBoxEx(0, 0, w, h, panelStyle)
end
```

如果颜色每帧变化，优先复用已有 `Color` 对象并改字段，或者让上层 UI 状态缓存少量离散状态。不要在行级 scoreboard、列表或 HUD 表格中为每个 cell 每帧创建临时对象。

## 文本成本模型

Plain text 走原生 GMod text。MGFX text composer 只适合需要 shader 效果的文字：gradient face、soft outline、glow、surface polish、weight bias 等。

不需要特效的高频文本应该直接使用原生绘制，尤其是：

- scoreboard rows
- player names
- dense tables
- chat/log
- rapidly changing counters

如果要用 FX text，尽量让字符串集合稳定，并使用 `MGFX.PrewarmText` 预热。

## 性能分析

开发时：

```text
mgfx_profile 1
mgfx_draw_counts 1
mgfx_status
```

真实 FPS 检查时关闭诊断：

```text
mgfx_profile 0
mgfx_draw_counts 0
```

诊断本身会产生额外计数和文本输出成本。最终判断要看关闭诊断后的体感和帧率。
