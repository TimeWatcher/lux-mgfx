# 已移除的 Shape 批处理设计

状态：运行时代码已在 2026-06-09 移除。

这页是 MGFX shape/data-texture batching prototype 的 postmortem。它保留为设计记录，方便未来评估类似方向，但不代表当前 runtime 行为。

## 决策

Shape batch path 被直接移除，而不是继续藏在另一个 cvar 后面。代表性 GMod UI 没有提供稳定正收益；但 runtime 成本和维护复杂度是永久存在的。

文本合成不属于这次移除范围。文本现在有单独清晰的路由规则：普通文本走 native，只有 shader-effect text 进入 whole-run composer。未来 shape batching 实验不能改变这个文本模型。

## 实测证据

Scoreboard 测试代表正常 GMod UI：混合 rounded box、line、image、text、mask、glow 和小 widget primitive。它不是人为构造的极端场景。

当时观察结果：

```text
shape/data batch enabled:
  FPS 约 50-90，随实验版本波动
  commandLoop 最坏约 10.15 ms
  roundFlush 约 3.36 ms
  lineFlush 约 0.73 ms
  实际 batchDraws 接近 0，或小到无法偿还 scheduler 成本

shape queue disabled, immediate path:
  FPS 回到约 130-140
  commandLoop 约 0.0075 ms
  paintTotal 约 3.56 ms
  frame 约 0.91 ms
```

结论：在这个环境里，draw call 数量不是唯一主瓶颈。Lua 侧 scheduling、rules、barriers、data texture prep 和 material state work 足够大，能抹平甚至反转预期收益。

## 已移除内容

运行时 Lua：

```text
cl_mgfx_batch.lua
cl_mgfx_batch_rules.lua
rounded boxes / chamfers / polys / lines / images /
progress bars / segment bars / rings / arcs 的 shape command queue
batch backend/rules status counters
batch cvar 与 threshold cvar
batch devtool commands
```

Shader：

```text
mgfx_batch_* data shaders
mgfx_batch_vsxx.hlsl
mgfx_line_batch_psxx.hlsl
mgfx_line_vertex_psxx.hlsl
对应编译后的 VCS 输出
```

当前 frame command queue 只服务 deferred text 和 clip replay。Shape 保持 immediate rendering。

## 失败原因

### Data Texture 上传不便宜

Prototype 假设足够多 primitive 被归组后，参数上传成本会被摊薄。实际中，准备 data RT、写 texel、接触材质、重绑参数页、追踪上传阈值都带来明显 CPU 成本。如果一个路径上传了参数但只产出少量 batch draw，它就比 immediate 更差。

未来规则：除非在真实 UI 中有足够大且稳定的 primitive run，并且单独测过 upload cost，否则不要引入 data texture path。

### Candidate Detection 变成热点

用于保护正确性的规则每帧运行：normalize style、检查 shader availability、追踪 barrier、检查 fill/stroke feature、统计连续 run、构造临时 record。Scoreboard 类 UI 混合很多 primitive family，所以 scheduler 经常做了很多工作最后只是拒绝或 flush。

未来规则：batch 实验必须证明在目标 pattern 不存在时，不会产生昂贵的 per-command detection cost。

### GMod UI 顺序很难形成长 run

典型 UI 顺序是 card background、image、text、separator、icon、next card。Images、clips、framebuffer reads、glows、masks 和 text boundaries 经常打断同族 run。旧 scheduler 试图用 bbox conflict checks 重新排序，但这又增加复杂度，而且仍然得不到足够大的 batch。

未来规则：默认假设 UI stream 是异构的。只针对真实面板里已知会出现的窄 pattern 批处理，不要为了理论 primitive family 设计大而全 scheduler。

### Shader 数量扩大维护面

Data path 需要为 roundrect、chamfer、ring、progress、segment、poly、pattern/smoke variant 和 line batching 准备独立 shader。每个新 shader 都需要参数打包、fallback 行为、status checks、rebuild coverage 和与 immediate path 的视觉一致性测试。

未来规则：只有明确的 runtime call site 和实测收益已经存在时，才增加 shader variant。

### 视觉一致性成本很高

移除前已经修过很多问题，这些经验仍然重要：

```text
extra Lua TexCoord channel 不适合广泛 batching
RGB scalar storage 有 color-space/roundtrip 风险
8-bit radius/stroke storage 会改变小尺寸几何
AA 公式必须与 immediate path 完全一致
raw mesh draw 不继承 VGUI panel clipping
stroke-only pass 需要专用 stroke shader，不能复用透明 fill
procedural smoke 需要显式 size/seed 规则，否则会 drift
multi-stop gradient 不能折叠成 endpoint ramp 而不改变输出
```

未来规则：视觉一致性是硬要求。Batch path 只要近似输出，即使更快也是 bug。

## 未来重做门槛

新的 batch design 必须先在主 renderer 外验证，并通过这些检查后才能接入 runtime hook：

```text
1. 只针对一个窄 primitive pattern，不覆盖所有 shape family。
2. 使用代表性 GMod UI，不只测 synthetic grid。
3. 分别测 detection cost、upload cost、draw cost 和 total frame cost。
4. 在文本行为不变的前提下，明显快过 immediate path。
5. 目标 pattern 不存在时，避免 per-frame scheduler work。
6. 除非参数上传能被证明有效摊销，否则避免 data texture。
7. AA、stroke、gradient、pattern、glow、clip 和 alpha 必须匹配 immediate 输出。
8. 带 kill switch 和 rollback plan。
```

在达到这个门槛前，MGFX 的性能方向保持：

```text
immediate shader fast paths
更少 material parameter upload
更少 style/geometry preparation
针对实测热点做专用优化
稳定的 text routing 和 FX composer 行为
```
