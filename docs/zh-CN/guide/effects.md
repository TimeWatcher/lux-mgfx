# 特效指南

`shadow`、`outerGlow`、`innerGlow`、`backdrop` 和 `pattern` 都是拥有该 coverage 的 shape、image、widget 或 text call 的 style 字段，不是独立 layout object。

## Shadow、Glow 与 Backdrop

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 12,
    fill = Color(8, 14, 20, 180),
    shadow = {x = 0, y = 8, blur = 18, spread = 2, color = Color(0, 0, 0, 120)},
    outerGlow = {width = 12, color = Color(70, 205, 255, 64)},
    backdrop = {blur = 6, tint = Color(0, 8, 12, 110)},
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

mgfx.api.roundedBoxEx(x, y, w, h, {
  radius = 12,
  fill = Color(8, 14, 20, 180),
  shadow = {x = 0, y = 8, blur = 18, spread = 2, color = Color(0, 0, 0, 120)},
  outerGlow = {width = 12, color = Color(70, 205, 255, 64)},
  backdrop = {blur = 6, tint = Color(0, 8, 12, 110)},
});
```

:::

| 字段 | 含义 | 常见用途 |
| --- | --- | --- |
| `shadow` | 外部柔和投影；`x/y` 移动 shadow coverage。 | 让 card 或 panel 浮起。 |
| `outerGlow` | source coverage 外侧发光；`x/y` 调整方向偏置。 | 选中、稀有度、能量边缘。 |
| `innerGlow` | 裁剪在 source coverage 内部的边缘光。 | 轻微 bevel 或 polished rim。 |
| `backdrop` | 在 shape/image mask 内采样、模糊并 tint framebuffer。 | 毛玻璃和半透明 panel。 |
| `pattern` | 裁剪到 source coverage 的 shader paint layer。 | 条纹、烟雾、磨损材质。 |

`backdrop` 不是 shadow；它只处理当前 shape 或 image mask 内部的背景。

## 多层 Shadow

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(18, 24, 32, 220),
    shadow = {
        {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 90)},
        {x = 0, y = 8, blur = 24, color = Color(0, 0, 0, 80)},
    },
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

mgfx.api.roundedBoxEx(x, y, w, h, {
  radius = 10,
  fill = Color(18, 24, 32, 220),
  shadow = {
    {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 90)},
    {x = 0, y = 8, blur = 24, color = Color(0, 0, 0, 80)},
  },
});
```

:::

MGFX 只循环 shadow path，不会为每层重复绘制 fill、stroke、backdrop、pattern 或 inner glow。

## 共享 Backdrop Blur

一个 engine render frame 中，backdrop blur 按 `level` 分层共享。同层同强度只捕获一次并执行两个模糊 pass；`backdrop = {blur = 8, level = 1}` 会在该绘制位置重新捕获，因此能包含 level `0` 已画出的 UI。只改变强度时会复用本层原始捕获并重跑模糊 pass；同一层内也必须强制更新源时才使用 `recapture = true`。

## Pattern

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 8,
    fill = Color(28, 34, 40, 235),
    pattern = MGFX.WornPattern({
        color = Color(0, 0, 0, 44),
        edgeColor = Color(218, 208, 184, 78),
        grain = 0.64,
        scratches = 0.30,
        edge = 0.54,
        seed = "inventory-card",
    }),
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

local draw = mgfx.api
draw.roundedBoxEx(x, y, w, h, {
  radius = 8,
  fill = Color(28, 34, 40, 235),
  pattern = draw.wornPattern({
    color = Color(0, 0, 0, 44),
    edgeColor = Color(218, 208, 184, 78),
    grain = 0.64,
    scratches = 0.30,
    edge = 0.54,
    seed = "inventory-card",
  }),
});
```

:::

Pattern 是 shader paint slot。不要用很多额外 box、line 或 polygon 模拟 stripe、smoke 或 worn surface。

准确字段与范围见 [Paint、Pattern、Transform](../api-reference/paint)。
