# 已移除的批处理覆盖面

状态：仅保留为历史记录。运行时 batch 代码和 shader 已经移除。

这页记录被移除的 prototype 曾试图覆盖哪些内容。它在评估未来 rewrite 时仍有价值，因为它展示了上一版 surface area 是如何变得过大的。

## 已移除覆盖范围

```text
RoundedBox / RoundedBoxEx:
  solid fill
  two-stop linear/radial/conic fill
  multi-stop fill up to 5 stops
  stripe/smoke pattern data
  scalar radius
  optional inner stroke

ChamferBox / ChamferBoxEx:
  solid fill
  two-stop linear/radial/conic fill
  multi-stop fill up to 5 stops
  stripe/smoke pattern data
  scalar/table cuts
  optional inner stroke

Line / LineEx:
  solid line
  two-stop gradient line
  multi-stop gradient by data/LUT path

Poly / PolyEx:
  convex fill-only solid
  convex two-stop linear gradient
  radial/conic/multi-stop through data texture
  stripe/smoke pattern data
  fill+stroke data path
  stroke-only via line batch

ProgressBar / ProgressBarEx:
  data texture batch
  solid/two-stop/multi-stop horizontal fill
  per-record track/fill/stroke/radius/value/padding/fx flags
  pattern data path

SegmentBar / SegmentBarEx:
  data texture batch
  solid/two-stop horizontal fill
  per-record fill/track/value/radius/segments/gap
  pattern data path
  active-cell decomposition through rounded rect batch

Ring / RingEx / Arc / ArcEx:
  solid and gradient fill
  pattern data path
  stroke, inner glow, and expanded outer-glow pass
```

`Sector` / `SectorEx` 在这个已移除 prototype 期间还不存在。当前 sector primitive 是 immediate ring-shader mode，应看当前 API 文档，而不是这份历史覆盖矩阵。

## 为什么移除

覆盖范围对真实 GMod UI 成本模型来说太宽。每个 family 都需要：

```text
style-to-batch rule code
record allocation and normalization
ordering and overlap checks
flush barriers
data texture parameter packing
extra material status and fallback plumbing
shader variants
telemetry and devtools
```

Scoreboard profiling 中，这些成本每帧出现，而有用 batch draw 很少。Immediate path 更快也更简单。

## 当前覆盖策略

当前 MGFX shape rendering coverage 属于 immediate path。新的 API feature 应先实现为 immediate shader/fallback behavior。

未来 batch 实验不应试图恢复这张矩阵。先从一个经过实测的窄目标 pattern 开始，证明代表性 frame 中有真实收益后再增加覆盖面。
