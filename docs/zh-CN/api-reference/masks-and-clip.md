# Coverage Mask、Clip 与 Shape 自遮罩

本页是可复用抗锯齿 coverage Mask、回调式 `Clip` 与 shape 自遮罩的完整 API
参考。第一次了解设计时可先阅读 [Coverage Mask 与抗锯齿 Clip](../guide/masks-and-clip)。

不要把 coverage Mask 与 `ImageEx(..., {mask = ...})` 混为一谈。后者只影响一次
图像绘制；coverage Mask 可以裁剪回调里的 shape、图像、文字与原生绘制。

普通 GLua 使用 `MGFX.*`；Lux 通过 `mgfx.api` 上对应的 lowerCamelCase 方法调用。

## API 总览

```lua
local mask = MGFX.Mask(painter)

mask:Invalidate()
MGFX.Clip(mask, x, y, w, h, callback)
mask:Clip(x, y, w, h, callback)

MGFX.Masks.Circle
MGFX.Masks.Capsule
MGFX.Masks.Rounded(options)
MGFX.Masks.Chamfer(options)

MGFX.RoundedBoxEx(x, y, w, h, style, children)
MGFX.CircleEx(cx, cy, radius, style, children)
MGFX.CapsuleEx(x, y, w, h, style, children)
MGFX.ChamferBoxEx(x, y, w, h, style, children)
```

## `MGFX.Mask`

```lua
local mask = MGFX.Mask(function(m, w, h)
    -- 使用 m:Draw/Union/Subtract/Intersect/Xor/Invert 定义 coverage。
end)
```

创建一个不可直接修改的 Mask 对象。MGFX 只保存 painter，不会在构造时立刻绘制；
第一次 `Clip` 需要对应目标 coverage 时才执行 painter，之后兼容的调用会复用 raster
cache。

| painter 参数 | 说明 |
| --- | --- |
| `m` | 受限 coverage recorder，只在当前 painter 执行期间有效。 |
| `w`, `h` | 当前 Clip 目标尺寸，单位为局部 UI 单位；painter 坐标范围是 `[0, w] x [0, h]`。 |

painter 每次都应从空 coverage 完整描述 Mask。可以捕获外部状态，但状态改变后必须调用
`mask:Invalidate()`。

### Coverage recorder 方法

accumulator 初始为 `A = 0`。每个 operation callback 会先绘制出临时 coverage `B`。

| 方法 | 公式 | 返回值 |
| --- | --- | --- |
| `m:Draw(callback)` | `max(A, B)` | `m` |
| `m:Union(callback)` | `max(A, B)` | `m` |
| `m:Subtract(callback)` | `A * (1 - B)` | `m` |
| `m:Intersect(callback)` | `A * B` | `m` |
| `m:Xor(callback)` | `A + B - 2AB` | `m` |
| `m:Invert()` | 当前 `[0, w] x [0, h]` 内的 `1 - A` | `m` |

`Draw` 就是 `Union` 的便捷名称。因为 accumulator 初始为空，第一次 `Draw` 自然完成
初始化。operation 不能嵌套；也不能保存 recorder，并在 painter 返回后继续调用。

```lua
local ringMask = MGFX.Mask(function(m, w, h)
    local radius = math.min(w, h) * 0.5

    m:Draw(function()
        MGFX.Circle(w * 0.5, h * 0.5, radius, color_white)
    end)

    m:Subtract(function()
        MGFX.Circle(w * 0.5, h * 0.5, radius - 8, color_white)
    end)
end)
```

### Painter 内允许绘制什么

operation callback 内的 MGFX 绘制会被解释为 coverage。RGB 被忽略；最终 alpha 与
抗锯齿 coverage 仍然有效。几何组合只由 `Draw`、`Subtract` 等 recorder 方法决定，
普通颜色 blend 不负责选择组合方式。

支持 rounded/chamfer box、circle、capsule、line、凸多边形、ring/arc/sector、
image/icon、text/text box、progress bar 与 segment bar 的普通及 `Ex` 形式。透明 fill
会产生透明 coverage；居中 stroke 会贡献自己的 coverage，也可能超出 fill 边界。

录制期间会明确拒绝：

- `shadow`、`outerGlow`、`innerGlow`、`backdrop` style effect；
- `RoundedBoxBackdrop` 与 `TextBatchEx`；
- 嵌套 recorder operation、嵌套 `Clip`/`PushClip` scope 和 command batching；
- 直接修改 render target、2D camera、model matrix、scissor、blend 或 alpha-write 状态。

## `MGFX.Clip`

```lua
local a, b = MGFX.Clip(mask, x, y, w, h, function()
    MGFX.Image(x, y, w, h, material)
    return "value", 42
end)
```

让 `callback` 中发出的全部绘制服从 Mask。对象写法完全等价：

```lua
mask:Clip(x, y, w, h, callback)
```

| 参数 | 说明 |
| --- | --- |
| `mask` | `MGFX.Mask` 返回的对象，或 `MGFX.Masks` 中的 preset。 |
| `x`, `y` | 当前 MGFX frame 中的 Clip 原点。 |
| `w`, `h` | 正数尺寸，同时用于参数化 Mask painter 或 preset。 |
| `callback` | 内容事务；其返回值数量与全部值会被精确转发。 |

Mask painter 使用相对于 `(0, 0)` 的局部坐标；内容 callback 不会切换坐标系，仍使用
当前 frame 的普通坐标，通常从 `x, y` 开始画。内容 callback 可以使用原生 `surface`
绘制，因为最终 framebuffer 结果会在 composite 时统一裁剪。

`Clip` 要求已有 `StartPanel` 或 `StartScreen` frame、shader/render-target 路径、有限且
为正的尺寸、`w/h` 不超过 framebuffer，并要求轴对齐 MGFX frame。最多嵌套四层。
active MGFX transform 会被拒绝；内容中的 `PushClip`/`PopClip` 必须平衡。

`Clip` 不使用 stencil，也没有二值 fallback。连续 coverage 路径不可用时会直接报错，
不会静默改变边缘质量。

## Mask 失效与缓存

```lua
local notch = 0.25
local mask = MGFX.Mask(function(m, w, h)
    m:Draw(function()
        MGFX.RoundedBox(0, 0, w, h, 12, color_white)
    end)
    m:Subtract(function()
        MGFX.Circle(w * notch, 0, 10, color_white)
    end)
end)

notch = 0.4
mask:Invalidate()
```

`mask:Invalidate()` 增加 custom Mask 的 content revision，并返回同一个 Mask 对象。
preset Mask 不可变，调用 `Invalidate` 会报错。

只有 content revision、目标尺寸、有效 target bucket 与屏幕像素小数 phase 都兼容时，
custom raster 才能复用。整数像素平移通常复用 coverage；亚像素平移可能为了保持边缘
采样而重新栅格化。Clip 开始时采用 Mask 快照；嵌套绘制期间的 invalidation 只影响
后续 Clip，不改变当前事务。

## Preset Mask

preset 实现相同的 Mask protocol，但保持解析式：不执行 painter，也不分配 custom
coverage RT。

### Circle 与 Capsule

```lua
MGFX.Clip(MGFX.Masks.Circle, x, y, w, h, callback)
MGFX.Clip(MGFX.Masks.Capsule, x, y, w, h, callback)
```

`Circle` 是目标 bounds 中居中的内接圆。`300 x 100` 目标得到直径 100 的圆，而不是
椭圆。`Capsule` 填满目标 bounds，端部半径等于短边的一半。

### Rounded

```lua
MGFX.Masks.Rounded({radius = 12, units = "local"})
MGFX.Masks.Rounded({radius = 0.12, units = "bounds"})
MGFX.Masks.Rounded(12) -- local radius = 12 的快捷写法
```

| 选项 | 默认值 | 说明 |
| --- | --- | --- |
| `radius` | `0` | 标量圆角半径。 |
| `units` | `"local"` | `"local"` 使用 UI 单位；`"bounds"` 乘以 `min(w, h)`。 |

解析后的 radius 会限制在短边一半以内。

### Chamfer

```lua
MGFX.Masks.Chamfer({
    cuts = {tl = 16, tr = 4, br = 16, bl = 4},
    units = "local",
})
```

`cuts` 接受单个数字、`{tl, tr, br, bl}` 或同顺序数组。`units = "bounds"` 会让
每个 cut 乘以短边；解析结果不小于 0，并限制在短边范围内。

## Shape 自遮罩

四种容器 shape 接受可选的最后一个 `children` callback：

```lua
MGFX.RoundedBoxEx(x, y, w, h, style, function(cx, cy, cw, ch)
    MGFX.ImageEx(cx, cy, cw, ch, material, {fit = "cover"})
end)
```

自遮罩直接复用 shape 自身的解析边界，不需要创建或重复写一个 Mask。绘制顺序固定为：

1. shape fill、pattern、backdrop、shadow 与 glow；
2. 通过 shape 边界裁剪的 `children`；
3. 作为前景层重新绘制的 shape stroke。

因此 children 不会盖住居中描边的内侧一半。shape 调用仍返回原本的绘制结果，
children 返回值不参与返回。

### 签名与 child bounds

| Shape | 签名 | 传给 `children` 的值 |
| --- | --- | --- |
| Rounded box | `RoundedBoxEx(x, y, w, h, style, children)` | `x, y, w, h` |
| Circle | `CircleEx(cx, cy, radius, style, children)` | 外接方框 `cx - radius, cy - radius, radius * 2, radius * 2` |
| Capsule | `CapsuleEx(x, y, w, h, style, children)` | `x, y, w, h` |
| Chamfer box | `ChamferBoxEx(x, y, w, h, style, children)` | `x, y, w, h` |

```lua
MGFX.CircleEx(cx, cy, radius, {
    fill = Color(8, 18, 24),
    stroke = Color(120, 220, 170),
    strokeWidth = 2,
}, function(x, y, sizeW, sizeH)
    MGFX.ImageEx(x, y, sizeW, sizeH, avatar, {fit = "cover"})
end)
```

自遮罩要求 callback 为函数、bounds 为有限正数且不超过 framebuffer，同时不能存在
active 或 style-level MGFX transform。`RoundedBoxEx` 自遮罩目前要求标量
`style.radius`；per-corner radius table 在普通绘制中仍有效，但容器形式会拒绝。
`ChamferBoxEx` 支持原有的标量、数组或命名 `style.cuts`。

## 渲染成本与状态契约

每层 `Clip` 执行两次 framebuffer copy 与一次有界 composite draw。解析式 preset
不需要 custom coverage 栅格化。custom Mask cache miss 时，布尔 coverage 会直接在
按尺寸分桶的局部 accumulator/scratch RT 中组合，并将 accumulator 本身作为缓存。

每个实际到达的嵌套深度保留两个全屏 snapshot RT；custom Mask 还会为该深度实际遇到
的每个尺寸桶保留两个局部 coverage RT。应把相关内容放进一个 Clip，而不是创建大量
微小 Clip。

MGFX 会保护自己修改的 render target、camera、matrix、scissor、blend、alpha-write、
modulation 与 surface alpha 状态。GMod 不提供现有 `OverrideBlend` 或
`OverrideAlphaWriteEnable` descriptor 的 getter，因此调用方持有这两类 override
scope 时不要进入 `Clip`。

[返回详细 API 入口](./index)
