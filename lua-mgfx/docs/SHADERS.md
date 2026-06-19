# Shader 构建与打包

MGFX 会把编译后的 shader VCS 文件嵌入到 `lua/mgfx/cl_mgfx_shaderpack.lua`。运行时 shaderpack 会被挂载成临时 GMA，然后由 `cl_mgfx_materials.lua` 创建 `screenspace_general` 材质使用。

这页记录的是 shader 构建、参数布局和 Garry's Mod/Source 里的实际限制。改 shader、gradient LUT、alpha 或 shaderpack 时，先看这里。

## 源文件结构

```text
shadersrc/mgfx/
  build.py
  build_shaders.bat
  compile_shader_list.txt
  src/
    *.hlsl
    shaders/fxc/*.vcs

tools/sdk_screenspace_shaders/
  shadersrc/bin/ShaderCompile.exe
```

`tools/sdk_screenspace_shaders` 只在构建时使用，GMA 打包时必须忽略。

## 重新构建

在 addon 根目录执行：

```powershell
python .\shadersrc\mgfx\build.py
```

构建脚本会：

1. 调用 `build_shaders.bat`。
2. 编译 `compile_shader_list.txt` 中所有 `mgfx_*` shader。
3. 把生成的 `src/shaders/fxc/*.vcs` 打包进内存 GMA。
4. 把 base64 shaderpack 写入 `lua/mgfx/cl_mgfx_shaderpack.lua`。

shaderpack 版本是 Unix timestamp：

```lua
MGFXShaderPack.Version = "..."
```

进游戏后用 `mgfx_status` 确认当前挂载版本。

## 诊断开关

开发时可以打开：

```text
mgfx_profile 1
mgfx_draw_counts 1
```

正式测 FPS 时要关闭：

```text
mgfx_profile 0
mgfx_draw_counts 0
```

每族 draw counter 默认关闭。复杂 immediate UI 中，几百次绘制的计数本身也可能变成可测开销。

## GMod Shader 规则

这些不是风格建议，是实际踩坑后的硬规则：

- 对生成材质不要直接依赖 `DrawTexturedRectUV`，除非你已经处理了 UV 修正。优先使用带显式 UV 的四点 textured quad。
- 抗锯齿需要最终屏幕空间尺寸或 UV derivative。不要把逻辑尺寸当成 shader AA 所需的物理像素尺寸。
- 进入 SDF 计算前先 clamp radius 和 chamfer cuts。
- 不要随手加 data texture 参数路径。被移除的 batch prototype 已经证明，上传和调度成本可能压过 draw call 收益。
- `screenspace_general` 的常量寄存器必须遵守 MGFX 文档化布局。MGFX 当前把 `$c0..$c3` 当作自定义 draw 参数，把 `$c4..$c7` 当作 texture-size 寄存器。不要用 `$c8` 之类临时寄存器，它们可能能编译但运行时读到 0 或未定义值。

## 参数页布局

热路径 shape shader 的 16 个常规 float 参数走 `$viewprojmat`，在 pixel shader 中读作：

```hlsl
const float4x4 MGFXExtraParams : register(c11);
```

Lua 端用 `Matrix():SetUnpacked(...)` 后调用：

```lua
mat:SetMatrix("$viewprojmat", matrix)
```

GMod/Source 的矩阵索引会按列抵达 HLSL：`matrix[0]` 读到的是 `1,5,9,13`，`matrix[1]` 读到的是 `2,6,10,14`，依此类推。Lua 端必须使用 MGFX 的统一打包 helper，不要在调用点猜行列顺序。

`MGFXExtraParams` 是主参数页。`$c0..$c3` 是辅助参数页，只给参数超过 16 个 float 的 fused shader 使用，例如 chamfer cuts + inner glow，或者 ring stroke + inner glow。能放进主参数页的参数不要占用辅助页。

本地 GMod benchmark 中，16 个独立 `SetFloat` 大约是 `SetUnpacked + SetMatrix` 的 7 倍成本，所以 hot shape path 不应回到逐 float 上传。

## 融合 Shape 快速路径

MGFX 允许小型专用 fused shader，但它们必须精确复刻原始分层结果。

当前保留的路径：

- `mgfx_roundrect_fx_ps30`：roundrect fill/stroke + inner glow。只有 inner glow 会导致额外 pass 时才启用。
- `mgfx_chamfer_ps30`：chamfer fill/stroke + optional inner glow。fill/stroke 使用 `MGFXExtraParams`，cuts 和 inner-glow 数据使用 `$c0..$c3`。
- `mgfx_ring_fx_ps30`：ring/arc/sector fill + optional inner glow + stroke。fill-only ring 仍走更轻的 `mgfx_ring_ps30`。

这些不是通用 “everything shader”。`pattern`、`shadow`、`outerGlow` 和 `backdrop` 仍可能保持独立，因为它们的 draw bounds、source texture 或 blend order 是可见行为。未来要融合这些层，必须证明 source-over 结果像素级一致，包括透明渐变和抗锯齿边缘。

## Shape 空间渐变

MGFX 有两类渐变空间：

- 矩形图元空间：`LinearGradient`、`RadialGradient` 和 `ConicGradient` 在图元 bounds 内采样归一化 UV。矩形径向渐变必须按短边补偿 aspect ratio，避免被 shape 拉伸。
- 圆环/扇区空间：`RingRadialGradient`、`SectorRadialGradient` 和 `*AngularGradient` 由 ring shader 按当前 ring/arc/sector 几何解释。

`ArcEx` 和 `SectorEx` 不能合并成同一个概念。`ArcEx` 是圆弧段，端点按 round cap 距离计算，适合 gauge mark；`SectorEx` 是直边径向扇区，按 start/end radial boundary 计算，适合轮盘 wedge。它们可以共享材质族，但 signed-distance 边界数学不同。

圆环/扇区局部径向填充：

```text
t = (r - innerRadius) / (outerRadius - innerRadius)
```

局部周向填充：

```text
t = (angle - startDeg) / (endDeg - startDeg)
```

这不等价于全局 `ConicGradient`。`ConicGradient` 始终描述围绕中心的 360 度角场。

## Gradient LUT

多 stop 渐变统一走一维 LUT：

- Lua 规范化、排序并补齐 0/1 端点，然后烘焙 256x4 render target。
- shader 先算出 `t`，再从 `$texture1` 采样 LUT。
- Linear、Radial、Conic、Ring/Sector radial、Shape/Ring/Arc/Sector angular 都走同一套 LUT 采样。
- LUT 按 stop table 缓存在有界 LRU 中。快速动画 stop 颜色或位置会 churn cache，优先动画几何、opacity 或显式 offset。
- `MGFX.LinearGradient`、`MGFX.RadialGradient`、`MGFX.ConicGradient` 返回的 fill record 被视为 immutable。要改 stop 或颜色，应创建新的 fill record，不要原地改表。

## Alpha 踩坑

不要把 gradient stop alpha 写进 render target alpha channel 后再用 `tex2D(...).a` 读取。GMod 的生成材质/render-target 路径里，alpha 写入和后续采样会出现“看似 opaque stop 正常，但透明 stop 变成不透明黑色”的问题。

可见症状是：本来应该淡出的径向或线性高光，消失后没有回到 `alpha = 0`，而是变成一块纯黑矩形或扇区，盖住下面所有图层。

当前 `lut-alpha-rgb-v3` 方案刻意把 alpha 当普通颜色数据保存：

```text
rows 0..1  存 visible RGB，alpha 强制 255
rows 2..3  用 grayscale RGB 存 stop alpha
```

shader 的 `mgfx_gradient_lut()` 会采样两组数据并重建 `float4(rgb, alpha)`。这不是审美选择，而是绕开 Source RT/blend/alpha-write 行为的兼容保护。

如果改这条路径，至少验证：

- `Color(r, g, b, 0)` stop 输出最终 alpha 0，而不是黑色。
- 叠加在彩色背景上的径向渐变能露出下面图层。
- 文本、线条、圆角矩形、ring radial 和 shape-local angular 渐变都读到同一套重建 alpha。

## 运行时资源

当前 addon 自带资源：

```text
resource/fonts/notosanssc-vf.ttf
```

服务端 loader 会通过 `resource.AddFile` 下发字体。scoreboard 专用图标属于独立的 `mgfx_zs_scoreboard` addon，不放在 MGFX 主库里。

Workshop/GMA 要求文件名小写且扩展名在白名单内。之前的 `NotoSansCJKsc-Regular.otf` 不适合 GMA，因此现在使用小写 TTF `notosanssc-vf.ttf`，字体 face name 是 `Noto Sans SC`。

## 包验证

运行：

```powershell
gmad.exe create -folder "garrysmod/addons/mgfx" -out "%TEMP%/mgfx.gma"
```

期望运行时包内容：

```text
lua/autorun/client/mgfx_loader.lua
lua/autorun/server/mgfx_loader.lua
lua/mgfx/*.lua
resource/fonts/notosanssc-vf.ttf
```

期望忽略内容：

```text
docs/*.md
docs-site/*
node_modules/*
shadersrc/*
tools/*
```

批处理原型的失败原因见 [已移除的批处理设计](./BATCHING)。
