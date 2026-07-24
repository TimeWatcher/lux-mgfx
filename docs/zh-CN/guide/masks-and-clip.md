# Coverage Mask 与抗锯齿 Clip

MGFX 有两个刻意分开的遮罩概念：

- `ImageEx` 接受 `{kind = "circle"}` 这样的图像 mask style，只影响当前图像。
- `MGFX.Mask(painter)` 为 `MGFX.Clip` 定义可复用 coverage，可以共同裁剪回调中的 shape、图像、文字和原生绘制。

这种区分让心智模型保持简单：Mask 只描述几何 coverage，Clip 决定它应用到哪个区域、哪段绘制。

本页说明心智模型与常用配方。所有 public 签名、返回值、preset 选项、限制和自遮罩
callback 规则统一列在 [完整 Mask 与 Clip API 参考](../api-reference/masks-and-clip)。

## 创建 coverage

```lua
local badgeMask = MGFX.Mask(function(m, w, h)
    m:Draw(function()
        MGFX.Circle(w / 2, h / 2, math.min(w, h) * 0.48, color_white)
    end)

    m:Subtract(function()
        MGFX.Circle(w * 0.69, h * 0.31, math.min(w, h) * 0.18, color_white)
    end)
end)
```

painter 收到的是受限的 coverage recorder。operation callback 内只支持 MGFX 绘制 API；这些绘制只解释最终 alpha/coverage，RGB 被忽略，普通颜色混合不会改变几何组合方式，不支持的 bleed effect 会明确报错。不要在 painter 中直接改变 render target、camera/model matrix、scissor 或 blend override。

初始 coverage 恒为 0。设旧 coverage 为 `A`，本次回调结果为 `B`：

| 方法 | coverage 公式 |
| --- | --- |
| `m:Draw(callback)` / `m:Union(callback)` | `max(A, B)` |
| `m:Subtract(callback)` | `A * (1 - B)` |
| `m:Intersect(callback)` | `A * B` |
| `m:Xor(callback)` | `A + B - 2AB` |
| `m:Invert()` | 当前 Clip bounds 内的 `1 - A` |

`Draw` 只是 `Union` 的便捷名。由于初始值为 0，第一次 Draw 自然等价于初始化 Mask，不需要特殊的 replace 规则。

## 使用 Mask

```lua
MGFX.Clip(badgeMask, x, y, 120, 72, function()
    MGFX.Image(x - 16, y, 152, 72, material)
    MGFX.Text("READY", "DermaLarge", x + 60, y + 36,
        color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

-- 等价的对象形式：
badgeMask:Clip(x, y, 120, 72, drawContents)
```

painter 使用 `[0, w] x [0, h]` 的局部坐标；内容回调仍使用当前 frame 的正常坐标。Mask 没有公开的像素尺寸。MGFX 会按实际 device extent 栅格化自定义 coverage，并保留透明 padding 与右/下 guard texel 供抗锯齿采样，因此全屏自定义 Mask 也是合法的。

raster cache key 包含 Mask content revision、目标尺寸、framebuffer/device 尺寸和屏幕像素的小数 phase。整数像素平移复用同一 raster，亚像素平移可能不会。当前 backend 只支持轴对齐 frame mapping，因此 MGFX transform 会被明确拒绝；调用方自己 Push 的 `cam` model matrix 无法被观察，同样不属于 Clip contract。

如果 painter 捕获的外部数据改变，在下次使用前调用 `mask:Invalidate()`。Clip 在开始时采用快照语义：嵌套绘制期间发生的修改只影响之后的 Clip，不改变当前事务。`MGFX.Clip` 与 `mask:Clip` 会精确转发 callback 的返回值数量和全部值。

## 预设

```lua
MGFX.Masks.Circle
MGFX.Masks.Capsule
MGFX.Masks.Rounded({radius = 12, units = "local"})
MGFX.Masks.Rounded({radius = 0.12, units = "bounds"})
MGFX.Masks.Chamfer({cuts = {tl = 12, tr = 2, br = 12, bl = 2}, units = "local"})
```

`Circle` 表示目标 bounds 中的内接圆，不会被非等比拉伸成椭圆；`Capsule` 会服从目标宽高比。`local` 单位是 Clip 局部 UI 单位，`bounds` 单位会乘以目标短边。

## 以 shape 自身为 Clip

常见容器不需要再重复写一个 Mask。四种 shape API 接受可选的最后一个 child callback，并直接复用自身解析边界：

```lua
MGFX.RoundedBoxEx(x, y, w, h, style, children)
MGFX.CircleEx(cx, cy, radius, style, children)
MGFX.CapsuleEx(x, y, w, h, style, children)
MGFX.ChamferBoxEx(x, y, w, h, style, children)
```

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 18,
    fill = Color(8, 18, 24, 230),
    stroke = Color(100, 220, 170, 180),
    strokeWidth = 2,
}, function(childX, childY, childW, childH)
    MGFX.ImageEx(childX, childY, childW, childH, material, {fit = "cover"})
end)
```

Rounded、Capsule 与 Chamfer callback 收到 `x, y, w, h`。Circle callback 收到它的外接方框：`cx - radius, cy - radius, radius * 2, radius * 2`。callback 仍使用正常 frame 坐标，不会像 custom Mask painter 那样切换为 `(0, 0)`。

容器层级固定为“背景/效果 → 裁剪后的 children → 前景描边”，children 不会覆盖居中描边的内侧一半。MGFX 会在任何绘制前完成完整参数校验。自遮罩会拒绝 active 或 style-level transform、非正数尺寸、超过 framebuffer 的尺寸，以及 `RoundedBoxEx` 的 per-corner radius table；普通非容器绘制仍支持该 radius table。

所有签名、callback 坐标规则、preset 选项、recorder 方法与缓存限制见 [Coverage Mask、Clip 与 Shape 自遮罩](../api-reference/masks-and-clip)。

## 渲染方式与成本

Clip 只提供回调形式，这样即使内容抛错，MGFX 也能可靠结束 render-target 事务。实现完全不用 stencil：每层 Clip 捕获回调前后的 framebuffer，再通过连续 shader coverage 合成。矩形 scissor 只限制工作区域，不决定可见边缘。

每层 Clip 需要两次 framebuffer copy 和一次有界 composite draw。自定义 Mask 只在缓存未命中时栅格化；解析 preset 不需要 coverage RT。cache miss 会直接在按尺寸分桶的局部 accumulator/scratch RT 中完成组合，并将 accumulator 本身作为缓存，因此不再清理全屏 coverage target，也不再把 accumulator 复制到单独的 mask RT。Clip 最多嵌套四层；Mask painter 内禁止 `BeginCommands` 和嵌套 Clip scope。

每个实际使用到的深度常驻两个全屏 `BGRA8888` snapshot RT：1920x1080 下约 15.82 MiB，3840x2160 下约 63.28 MiB。自定义 Mask 会在该深度为每个实际遇到的尺寸桶额外分配两个局部 `BGRA8888` coverage RT。尺寸桶从 32 像素开始按 2 的幂增长，并在略大于 framebuffer extent 处封顶，因此它们的显存、clear 与 combine 带宽随 Mask bounds 而不是全屏大小增长。

MGFX 自己修改的 render target、2D camera、matrix、scissor、blend、alpha-write、color modulation、blend factor 与 surface alpha 都走受保护的对称清理路径。但 GMod 没有提供读取既有 `OverrideBlend` / `OverrideAlphaWriteEnable` descriptor 的 getter，因此不要在调用方自己持有的 override scope 内进入 `Clip`；引擎不暴露的状态无法被 MGFX 重建。

Clip installer 对未改变的 runtime 是幂等的。如果 partial hot reload 已经替换被包装的 draw/frame function，安装会在分配新 RT 前明确拒绝；此时应执行完整 client Lua refresh，不能叠加另一代 wrapper 与 RT namespace。

如果只是裁剪一张图，应优先使用 `ImageEx(..., {mask = {kind = "circle"}})`；只有多次绘制需要共享同一个抗锯齿边界时，才使用 `MGFX.Mask` 与 `MGFX.Clip`。
