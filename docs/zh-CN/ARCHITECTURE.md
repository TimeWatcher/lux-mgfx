# MGFX 内部架构

这页记录 MGFX 当前的维护边界。Public API 细节看 [API 总览](./API) 和 [详细 API 参考](./api-reference/)；已移除的批处理原型看 [已移除的批处理设计](./BATCHING)。

## 分层方向

MGFX 是底层 immediate-style renderer。除了文本记录会延迟到 frame 末尾统一 flush 以外，public draw call 应该按调用顺序直接绘制。调用方应按 immediate draw 的方式思考：先画底层 shape/image，再发出应该覆盖在上面的 text。

MGFX core 负责：

- frame scope：`StartPanel`、`StartScreen`、`EndPanel`、`EndScreen`
- primitive 和 widget 绘制
- canonical visual style record：fill、stroke、radius、pattern、glow、image、progress、text effect 等
- public render slot 的 target capability metadata
- shader/material、text command replay、clip 和 fallback 实现细节

未来如果有更上层 UI layer，它可以负责 node、layout、interaction state、focus、scrolling、hit-testing、transition 和 component style。那一层可以内部使用 MGFX，但 MGFX 不应该反向依赖它。

## Transform 边界

MGFX 拥有 draw-phase visual transform stack。public surface 是支持的 `Ex` 调用上的 `style.transform`，以及用于复合 immediate 绘制的 `PushTransform` / `PopTransform`。

这是 renderer 能力，不是 layout 能力。不要增加 `ProjectedRoundedBoxEx`、`ProjectedRing`、`ProjectedSector` 这类 primitive-specific API。能通过 MGFX textured quad 或 transform-aware polygon 绘制的 primitive，应消费同一个 transform stack。

实现上，MGFX 会变换提交的 geometry，并在 projected/perspective-like transform 下细分 textured quad。现有 pixel shader 因此继续收到相同的 local UV space，用于 gradient、mask、ring 和 backdrop pass。强透视效果应提高 `steps`，避免 quad faceting 可见。

支持的 public forms：

- CSS-like record：`origin`、`perspective`、`rotateX`、`rotateY`、`rotate`、`scale`、`translate`、`skewX`、`skewY`、`steps`
- intent helper：`PointerTilt(x, y, spec)`，用于 pointer-driven 2.5D UI motion
- expert escape hatch：`ProjectedQuad({tl, tr, br, bl, steps})`
- point helper：`TransformPoint` 和 `UntransformPoint`

Transform 只影响视觉，不改变 layout、input hit testing、text flow 或矩形 scissor clip 坐标。需要 transformed hit testing 的 UI code 必须自己拥有这条策略。`UntransformPoint` 只用于视觉对齐场景，例如让鼠标追踪径向光点在 transform 后仍对齐。

Text 暂不属于这个 transform contract。文本 renderer 使用 deferred glyph/atlas composer，文本 transform 应作为 text composer feature 或未来 UI node feature 设计，不能半截接入 shape geometry。

## Mask 边界

Mask 是每个 primitive 自己的 shader coverage，不是全局 renderer state。

- rounded、capsule、circle、chamfer mask 使用 screen-pixel SDF coverage
- texture mask 采样调用方提供的 mask texture channel
- 传给 mask shader 的 `SHAPE_SIZE` 始终是最终 quad 的屏幕像素尺寸，因此 UI 缩放后边缘抗锯齿仍是 1px
- mask kind 在 Lua 侧白名单化后才能进入 shader

MGFX 不用 stencil 模拟 shape mask。`PushClip` / `PopClip` 只属于矩形 scissor stack，用于 panel clipping 和 ordering barrier。

## 参数上传边界

热路径 shape shader 使用 `$viewprojmat` / pixel shader register `c11` 中的 `MGFXExtraParams` 作为主 16-float 参数页。Lua call site 应使用共享 matrix upload helper，不要发很多单独 `SetFloat`。

`$c0..$c3` 是辅助页，只给 fused shader 的额外参数使用。能放进 matrix 页的参数不要占用辅助页；不要用 `$c8` 之类临时寄存器，它们可能能编译但在 GMod runtime material 中读到 0 或未定义值。

Pattern 是 shader-space paint field。UI code 不应该把大面积 stripe、smoke 或 scanline 背景拆成大量 `LineEx` 调用。如果效果能表示成 primitive shader 数学，就应该在底层 pattern path 实现。

## 模块边界

`cl_mgfx.lua` 是 client entry 和 composition root。它负责连接模块、共享 frame/command state，并把明确 helper table 传给 feature module。它应该保持编排层角色，不继续膨胀成渲染实现文件。

`cl_mgfx_materials.lua` 负责 shaderpack mount、render target、material creation 和 shader status。

`cl_mgfx_style.lua` 负责 public style normalization：

- fill 和 gradient record
- pattern constructor
- radius 和 stroke normalization
- color helper
- glow softness 到 shader falloff 的转换

`cl_mgfx_capabilities.lua` 负责 target capability matrix 和 paint-slot normalization。它是 public style record 与 primitive family 之间的边界。Capability entry 必须描述已经实现的渲染行为，而不是愿望清单。

`cl_mgfx_geometry.lua` 负责纯底层绘制和图像几何 helper：

- textured quad draw
- created material 的 `DrawTexturedRectUV` half-pixel correction
- image tint/crop/fit/radius helper
- textured circle poly fallback

`cl_mgfx_frame_geometry.lua` 负责 frame-space geometry helper，用于 frame flushing 和 scissor restoration。Multi-stop gradient 不再拆成 geometry segment，shader path 直接采样共享 gradient LUT。

`cl_mgfx_commands.lua` 是 queued text/clip command 的 canonical reader boundary。Raw array command layout 不应泄漏到 frame、primitive 或 widget module。只要 command record 还不是完全 named table，这个模块就是唯一允许读取数字 slot 的地方。

`cl_mgfx_frame.lua` 负责 text/clip command capture、clip stack operation 和 frame flushing。Shape command 不在这里排队，仍保持 immediate path。

`cl_mgfx_roundrect.lua` 负责 rounded-box、circle、capsule public API，以及它们的 immediate fill、stroke、pattern、inner glow、outer glow 和 fallback pass。

`cl_mgfx_primitives.lua` 负责 chamfer box、line 和 convex poly。Backdrop blur 是 `style.backdrop` 的 shape/image effect，不是独立 public primitive。

Widget family 按职责拆分：

- `cl_mgfx_widgets_bars.lua`：progress 和 segment bar
- `cl_mgfx_widgets_rings.lua`：ring、arc、sector
- `cl_mgfx_widgets_images.lua`：image、icon 和 image mask
- `cl_mgfx_widgets_text.lua`：text draw-call bridge
- `cl_mgfx_widgets.lua`：只做 thin aggregator

Public family 遵循 `Name(...)` / `NameEx(...)` 分层：短 positional hot-path call，以及高级 table-based call。

`cl_mgfx_text.lua` 负责文本路由：普通文本走 native drawing，shader text effects 走 whole-run native-raster composer。

Demo 文件不是 library internals。Demo 应展示 public API 和 telemetry，不要直接调用 private helper。

## 维护规则

Public arguments 应尽早规范化一次。Immediate renderer 和 fallback renderer 应消费同一份 canonical style data。

模块依赖必须明确。Composition root 可以在 legacy module 迁移期间传大 context table；新模块应暴露一个 constructor，并返回小 helper table。

不要通过 inline split file 来掩盖加载问题。新增 client module 时，应先加入 `lua/autorun/server/mgfx_loader.lua` 确保服务端发送给客户端，再从 `cl_mgfx.lua` 通过 addon base path include：

```lua
include(MGFX._BasePath .. name)
```

默认 addon base path 是 `mgfx/`。Gamemode code 不应直接 include MGFX 文件，只应在 addon 加载后调用 public `MGFX.*` API。

Immediate shader path 是主 renderer path，不是 batch scheduler 的 fallback。已移除的 batch prototype 留在文档中作为经验记录，不保留 runtime hook。

除非明确要求，不新增兼容 shim。当前稳定化阶段允许 public API 为更清晰的替代方案破坏兼容，但必须同步文档。

## 维护清单

| 状态 | 项目 |
| --- | --- |
| 完成 | 将 round-rect/effect immediate rendering 从 `cl_mgfx.lua` 拆到 `cl_mgfx_roundrect.lua`。 |
| 完成 | 将 scissor 和 bbox helper 拆到 `cl_mgfx_frame_geometry.lua`，移除旧 gradient-segment clipping path。 |
| 完成 | 将 widget family 拆成 bars、rings/arcs/sectors、images/masks 和 text bridge。 |
| 完成 | 增加 `cl_mgfx_commands.lua` 作为 text/clip replay 的 command reader boundary。 |
| 待办 | 将 queued command 从 positional array 转成 named record。现在已经隔离在 `cl_mgfx_commands.lua` 后面，可以渐进完成。 |
| 待办 | 继续缩小 `cl_mgfx.lua` 传给模块的共享 context table；新模块优先窄 constructor argument 和返回 helper table。 |
| 完成 | 增加 cross-cutting draw-phase transform stack 和 `style.transform`，避免创建 `ProjectedXXX` API 家族。 |
| 完成 | 从 runtime 移除 shape/data-texture batch prototype。代表性 GMod UI profiling 显示它是净负收益。 |
| 完成 | 保持每个 runtime Lua 文件低于 2000 行。当前最大文件仍是 `cl_mgfx_text.lua`、demo 和 primitive/widget module。 |
