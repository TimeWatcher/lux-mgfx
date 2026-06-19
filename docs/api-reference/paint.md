# 绘制记录、图案、变换与能力

Color/gradient paint record、程序化 pattern、2.5D transform helper 和 capability query。

## 适用边界

- Linear、Radial、Conic、Ring/Sector radial、Shape/Ring/Arc/Sector angular 都支持 stop 表，并统一走 LUT。
- Pattern 应作为 paint slot 交给 shader 数学化处理，不要在调用层展开成大量线段。
- 2.5D 视觉倾斜使用 `style.transform`、`PushTransform` 或 `PointerTilt`，不新增 `ProjectedXXX` 图元族。

## 本页 API

- [Solid](#solid) - 创建纯色绘制记录。
- [LinearGradient](#lineargradient) - 创建两段或多段线性渐变记录。
- [LinearGradientStops](#lineargradientstops) - 创建多段线性渐变记录。
- [RadialGradient](#radialgradient) - 创建径向渐变绘制记录。
- [RingRadialGradient](#ringradialgradient) - 创建从内边到外边的圆环局部径向渐变。
- [SectorRadialGradient](#sectorradialgradient) - 创建从内边到外边的扇区局部径向渐变。
- [ConicGradient](#conicgradient) - 使用公开角度制 rotation 创建锥形渐变记录。
- [ShapeAngularGradient](#shapeangulargradient) - 创建覆盖当前圆环/圆弧/扇区角度范围的局部周向渐变。
- [RingAngularGradient](#ringangulargradient) - 圆环局部周向绘制别名。
- [ArcAngularGradient](#arcangulargradient) - 创建从 startDeg 到 endDeg 的圆弧局部周向渐变。
- [SectorAngularGradient](#sectorangulargradient) - 创建从 startDeg 到 endDeg 的扇区局部周向渐变。
- [StripePattern](#stripepattern) - 创建程序化条纹图案记录。
- [SmokePattern](#smokepattern) - 创建程序化烟雾/噪声图案记录。
- [Transform](#transform) - 复制一个类似 CSS 的绘制变换记录，用作 style.transform。
- [PointerTilt](#pointertilt) - 创建一个由指针位置驱动的 2.5D 倾斜变换。
- [ProjectedQuad](#projectedquad) - 创建专家用投影四边形变换，而不是新增 ProjectedXXX 图元 API。
- [PushTransform](#pushtransform) - 为多次即时 MGFX 绘制压入一个绘制阶段变换。
- [PopTransform](#poptransform) - 弹出当前绘制变换。
- [TransformPoint](#transformpoint) - 把点通过一个 transform 记录做正向映射。
- [UntransformPoint](#untransformpoint) - 近似求解一个 transform 记录的反向映射。
- [GetCapabilities](#getcapabilities) - 返回某个 target 已实现的渲染槽位和元数据。
- [Supports](#supports) - 检查某个 target 是否支持一个公共渲染槽位。

## 先选哪种 paint

| 视觉需求 | 推荐记录 | 典型用途 |
| --- | --- | --- |
| 纯色 | `Color(...)` 或 `MGFX.Solid(color)` | 大多数 `fill` 直接传 Color 就够了。 |
| 左到右、上到下、斜向渐变 | `LinearGradient` / `LinearGradientStops` | 按钮、血条、列表选中态。 |
| 中心光、暗角、局部高光 | `RadialGradient` | 卡片暗角、spotlight、hover 光。 |
| 完整圆盘角向色相 | `ConicGradient` | 色相盘、全圆仪表背景。 |
| 圆环/扇区从内到外变色 | `RingRadialGradient` / `SectorRadialGradient` | Ring、Arc、Sector 的厚度方向渐变。 |
| 圆环/扇区沿角度变色 | `ShapeAngularGradient` / `RingAngularGradient` / `ArcAngularGradient` / `SectorAngularGradient` | 冷却环、仪表弧、轮盘 wedge。 |
| 斜线、扫描线 | `StripePattern` | HUD 装饰、分段条纹。 |
| 程序化噪声/烟雾 | `SmokePattern` | 能量面板、稀有物品背景。 |

坐标是图元本地归一化空间，不是屏幕像素：`LinearGradient(0, 0, 1, 0, ...)` 表示从图元左到右；`RadialGradient(0.5, 0.5, 0.85, ...)` 表示以图元中心为圆心。

## Stops 实用写法

```lua
local coldToHot = {
    {0.00, Color(80, 170, 255)},
    {0.45, Color(90, 220, 180)},
    {0.78, Color(255, 210, 110)},
    {1.00, Color(255, 96, 78)},
}

local fill = MGFX.LinearGradient(0, 0, 1, 0, coldToHot)
```

stop 支持三种常用写法，可以混用：

```lua
local stops = {
    Color(80, 170, 255),                         -- 只写 Color 时按索引自动分布
    {0.35, Color(90, 220, 180)},                 -- compact {pos, color}
    {pos = 0.70, color = Color(255, 210, 110)},  -- named form
    {offset = 1, color = Color(255, 96, 78)},    -- pos / t / offset 都可用
}
```

透明衰减必须显式写 alpha：

```lua
local vignette = MGFX.RadialGradient(0.5, 0.5, 0.9, {
    {0.00, Color(0, 0, 0, 0)},
    {0.72, Color(0, 0, 0, 0)},
    {1.00, Color(0, 0, 0, 110)},
})
```

缺省 alpha 是 255。只写 `Color(0, 0, 0)` 会得到不透明黑色，不会得到透明 stop。

## 常用 paint 配方

#### 按钮面板渐变

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 8,
    fill = MGFX.LinearGradient(0, 0, 0, 1,
        Color(36, 46, 58, 235),
        Color(18, 24, 32, 235)
    ),
})
```

#### 轮盘扇区角向渐变

```lua
MGFX.SectorEx(cx, cy, innerR, outerR, startDeg, endDeg, {
    fill = MGFX.SectorAngularGradient({
        {0, Color(36, 44, 54, 210)},
        {1, Color(80, 170, 255, 170)},
    }, startDeg),
})
```

`SectorAngularGradient` 的 `t` 覆盖当前 sector 的角度范围，适合 wedge 内沿角度变化。不要用全局 `ConicGradient` 去模拟局部扇区色带。

#### 圆环厚度方向高光

```lua
MGFX.RingEx(cx, cy, 36, 10, {
    fill = MGFX.RingRadialGradient({
        {0, Color(255, 255, 255, 70)},
        {0.45, Color(80, 170, 255, 220)},
        {1, Color(20, 70, 120, 220)},
    }),
})
```

`RingRadialGradient` 的 `t = 0` 在 inner edge，`t = 1` 在 outer edge。

#### 条纹和烟雾图案

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(20, 26, 34, 230),
    pattern = MGFX.StripePattern({
        color = Color(255, 255, 255, 18),
        spacing = 10,
        width = 2,
        angle = 135,
    }),
})

MGFX.ChamferBoxEx(x, y, w, h, {
    cuts = 10,
    fill = Color(18, 24, 30, 230),
    pattern = MGFX.SmokePattern({
        color = Color(80, 170, 255, 24),
        scale = 120,
        density = 0.45,
        softness = 0.32,
        seed = "loadout-card",
    }),
})
```

`StripePattern.spacing = 8..16`、`width = 1..3` 常用。`SmokePattern.scale = 90..180`、`density = 0.35..0.6`、`softness = 0.2..0.45` 比较稳。

## 参数速查

| 字段 | 推荐范围 | 说明 |
| --- | --- | --- |
| gradient 坐标 | `0..1` 最常用 | 可以超出 0..1 做偏移光，但默认先按图元局部空间理解。 |
| stop `pos/t/offset` | `0..1` | 缺失的 0/1 端点会用首尾颜色补齐。 |
| stop 数量 | `2..6` 常用 | 过多 stop 会更难维护；需要复杂色带再增加。 |
| `ConicGradient.rotation` | 度数 | 用于整体角度偏移；局部 ring/sector 优先用 `*AngularGradient`。 |
| `StripePattern.spacing` | `8..16` | 越小越密；HUD 小控件不要低于 6。 |
| `StripePattern.width` | `1..3` | 通常低于 spacing 的三分之一。 |
| `SmokePattern.scale` | `90..180` | 越小纹理越细碎。 |
| `SmokePattern.density` | `0.35..0.6` | 越大越明显。 |
| `SmokePattern.softness` | `0.2..0.45` | 越大边缘越散。 |

## 函数参考

## Solid

```lua
MGFX.Solid(color)
```

创建纯色绘制记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| color | GMod Color 表。 |

#### 用法说明

- 多数 API 也直接接受 Color；当你想显式使用 paint record 时 Solid 很有用。
- 内部会把同一颜色存为两个渐变端点。

#### 返回值

kind = solid 的绘制表。

#### 示例

```lua
local fill = MGFX.Solid(Color(28, 34, 46, 230))
MGFX.RoundedBoxEx(x, y, w, h, {radius = 8, fill = fill})
```

## LinearGradient

```lua
MGFX.LinearGradient(x1, y1, x2, y2, colorA, colorB)
```

创建两段或多段线性渐变记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| x1, y1, x2, y2 | 图元内部归一化渐变轴。 |
| colorA, colorB | 端点颜色，或把 stops 表作为第五个参数传入。 |

#### 用法说明

- 坐标相对于图元归一化，不是全局屏幕像素。
- 在这里传 stops 表等价于 LinearGradientStops。

#### 返回值

线性渐变绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.LinearGradient(0, 0, 1, 0, Color(80, 170, 255), Color(90, 220, 180))
```

## LinearGradientStops

```lua
MGFX.LinearGradientStops(x1, y1, x2, y2, stops)
```

创建多段线性渐变记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| stops | {pos, color} 或 {pos = n, color = Color(...)} 记录数组。 |

#### 用法说明

- stops 会排序，并在需要时扩展到 0 和 1 端点。
- 用于条、线、多边形、面板和文本 face 的线性色带。

#### 返回值

线性渐变绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.LinearGradientStops(0, 0, 1, 0, {
    {0.00, Color(80, 170, 255)},
    {0.55, Color(90, 220, 180)},
    {1.00, Color(255, 210, 110)},
})
```

## RadialGradient

```lua
MGFX.RadialGradient(cx, cy, radius, colorA, colorB) / MGFX.RadialGradient(cx, cy, radius, stops)
```

创建径向渐变绘制记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| cx, cy | 归一化渐变中心。 |
| radius | 归一化径向尺寸。 |
| colorA, colorB | 中心和外侧颜色，或把 stops 表作为第四个参数传入。 |

#### 用法说明

- 最适合支持径向绘制的形状路径。
- shader 路径会通过缓存的 256-sample LUT 采样全部 stops。

#### 返回值

径向渐变绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.RadialGradient(0.5, 0.35, 0.8, Color(90, 220, 180, 220), Color(20, 24, 32, 200))
```

## RingRadialGradient

```lua
MGFX.RingRadialGradient(colorA, colorB) / MGFX.RingRadialGradient(stops)
```

创建从内边到外边的圆环局部径向渐变。

#### 参数

| 参数 | 说明 |
| --- | --- |
| colorA, colorB | 内边和外边颜色，或传入 stops 表。 |

#### 用法说明

- 只有圆环/圆弧/扇区 shader 路径会解释这个局部径向空间。
- t 按 (r - innerRadius) / (outerRadius - innerRadius) 映射。

#### 返回值

带圆环局部径向空间标记的 radial 绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.RingRadialGradient(Color(20, 24, 30, 180), Color(120, 130, 150, 145))
```

## SectorRadialGradient

```lua
MGFX.SectorRadialGradient(colorA, colorB) / MGFX.SectorRadialGradient(stops)
```

创建从内边到外边的扇区局部径向渐变。

#### 参数

| 参数 | 说明 |
| --- | --- |
| colorA, colorB | 内边和外边颜色，或传入 stops 表。 |

#### 用法说明

- 用于 SectorEx，让轮盘扇区沿带宽变亮或变暗。
- 这不同于扇区外接矩形中的普通 RadialGradient。

#### 返回值

带圆环局部径向空间标记的 radial 绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.SectorRadialGradient(Color(20, 24, 30, 180), Color(120, 130, 150, 145))
```

## ConicGradient

```lua
MGFX.ConicGradient(cx, cy, rotationDeg, colorA, colorB) / MGFX.ConicGradient(cx, cy, rotationDeg, stops)
```

使用公开角度制 rotation 创建锥形渐变记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| cx, cy | 归一化锥形中心。 |
| rotationDeg | 旋转角度，单位度。 |
| colorA, colorB | 端点颜色，或把 stops 表作为第四个参数传入。 |

#### 用法说明

- 适合圆环和圆形仪表。
- shader 路径会通过缓存的 256-sample LUT 采样全部 stops。

#### 返回值

锥形渐变绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.ConicGradient(0.5, 0.5, -90, Color(80, 170, 255), Color(255, 210, 110))
```

## ShapeAngularGradient

```lua
MGFX.ShapeAngularGradient(colorA, colorB, rotationDeg) / MGFX.ShapeAngularGradient(stops, rotationDeg)
```

创建覆盖当前圆环/圆弧/扇区角度范围的局部周向渐变。

#### 参数

| 参数 | 说明 |
| --- | --- |
| colorA, colorB | 起始边和结束边颜色，或传入 stops 表。 |
| rotationDeg | 可选偏移，会加到局部 0..1 范围内。 |

#### 用法说明

- 它把 t 映射到 startDeg 到 endDeg，而不是完整 360 度圆。
- shader 圆环路径会通过缓存的 256-sample LUT 采样全部 stops。

#### 返回值

带形状局部周向空间标记的 conic 绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.ShapeAngularGradient(Color(80, 170, 255), Color(255, 210, 110))
```

## RingAngularGradient

```lua
MGFX.RingAngularGradient(colorA, colorB, rotationDeg) / MGFX.RingAngularGradient(stops, rotationDeg)
```

圆环局部周向绘制别名。

#### 参数

| 参数 | 说明 |
| --- | --- |
| colorA, colorB | 周向端点颜色，或传入 stops 表。 |

#### 用法说明

- 对完整 360 度圆环，它按该圆环范围归一化。

#### 返回值

带形状局部周向空间标记的 conic 绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.RingAngularGradient(Color(80, 170, 255), Color(255, 210, 110))
```

## ArcAngularGradient

```lua
MGFX.ArcAngularGradient(colorA, colorB, rotationDeg) / MGFX.ArcAngularGradient(stops, rotationDeg)
```

创建从 startDeg 到 endDeg 的圆弧局部周向渐变。

#### 参数

| 参数 | 说明 |
| --- | --- |
| colorA, colorB | 起止颜色，或传入 stops 表。 |

#### 用法说明

- 用于仪表圆弧需要沿自身扫掠范围渐变时。

#### 返回值

带形状局部周向空间标记的 conic 绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.ArcAngularGradient(Color(80, 170, 255), Color(255, 210, 110))
```

## SectorAngularGradient

```lua
MGFX.SectorAngularGradient(colorA, colorB, rotationDeg) / MGFX.SectorAngularGradient(stops, rotationDeg)
```

创建从 startDeg 到 endDeg 的扇区局部周向渐变。

#### 参数

| 参数 | 说明 |
| --- | --- |
| colorA, colorB | 起止颜色，或传入 stops 表。 |

#### 用法说明

- 用于轮盘选中态和径向菜单高亮。
- 它有意区别于 ConicGradient。

#### 返回值

带形状局部周向空间标记的 conic 绘制记录。

#### stop 表写法

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Color-only stop`<br>Color(r, g, b, a)。 | `auto distributed` | 位置按数组索引自动分布。 |
| `{pos, color}`<br>数组 stop，[1] 是位置，[2] 是 Color。 | `required color` | 紧凑 stop 写法。 |
| `{pos/t/offset, color}`<br>命名 stop 表。 | `required color` | 显式指定 0 到 1 的 stop 位置。 |
| `endpoints`<br>缺失的 0 或 1 端点会自动插入。 | `first/last color` | 渐变始终覆盖整个图元范围。 |

#### stop 渲染支持

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `LinearGradient / LinearGradientStops`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 线性轴仍然定义 t；对角和轴向填充使用同一 stop 表。 |
| `RadialGradient / ConicGradient`<br>通过渐变 LUT 支持完整 stops。 | `supported` | 径向/锥形 shader 先计算 t，再采样缓存的 256-sample LUT。 |
| `RingRadialGradient / SectorRadialGradient`<br>在圆环局部径向空间支持完整 stops。 | `supported` | t 从 innerRadius 映射到 outerRadius 后再采样 LUT。 |
| `*AngularGradient`<br>在形状局部周向空间支持完整 stops。 | `supported` | 包括 ShapeAngularGradient、RingAngularGradient、ArcAngularGradient 和 SectorAngularGradient。 |
| `Fallback paths`<br>shader 提供完整 stop 路径。 | `may degrade` | 如果 shader 不可用，复杂 stops 可能退化到更简单的 surface 绘制。 |

#### 示例

```lua
local fill = MGFX.SectorAngularGradient(Color(80, 170, 255), Color(255, 210, 110))
```

## StripePattern

```lua
MGFX.StripePattern(spec)
```

创建程序化条纹图案记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| spec.color / tint | 条纹颜色。 |
| spec.spacing | 条纹间距。 |
| spec.width | 条纹宽度。 |
| spec.angle | 条纹角度，单位度。 |
| spec.offset | 采样偏移。 |

#### 用法说明

- 也接受 positional 参数：color、spacing、width、angle、offset。
- 根据 API 放到 style.pattern、fillPattern 或 trackPattern 中。

#### 返回值

kind = "stripe" 的图案表。

#### spec 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `color / tint`<br>Color。 | `Color(255,255,255,24)` | 条纹颜色。 |
| `spacing`<br>数字。 | `12` | 条纹中心间距。 |
| `width`<br>数字。 | `2` | 条纹宽度。 |
| `angle`<br>角度，单位度。 | `135` | 条纹方向。 |
| `offset`<br>数字。 | `0` | 采样偏移；调用方可自行做动画。 |
| `positional form`<br>MGFX.StripePattern(color, spacing, width, angle, offset)。 | `same defaults` | 等同传入 spec 表。 |

#### 示例

```lua
local stripes = MGFX.StripePattern({
    color = Color(255, 255, 255, 34),
    spacing = 10,
    width = 1.5,
    angle = 135,
})
```

## SmokePattern

```lua
MGFX.SmokePattern(spec)
```

创建程序化烟雾/噪声图案记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| spec.color / tint | 图案颜色。 |
| spec.scale | 噪声尺度。 |
| spec.density | 烟雾密度。 |
| spec.softness | 边缘柔和度。 |
| spec.angle / offset / speed | 方向与时间偏移控制。 |
| spec.warp / seed | 噪声变化控制。 |

#### 用法说明

- UI 纹理请使用低 alpha，不要做成不透明雾。
- seed 可以是数字或字符串；字符串会哈希为稳定值。

#### 返回值

kind = "smoke" 的图案表。

#### spec 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `color / tint`<br>Color。 | `Color(255,255,255,24)` | 烟雾叠加颜色。 |
| `scale`<br>数字。 | `140` | 噪声尺度；数值越大云团越宽。 |
| `density`<br>0..1 数字。 | `0.48` | 可见噪声密度。 |
| `softness`<br>大于 0 的数字。 | `0.3` | 烟雾单元边缘柔和度。 |
| `angle / offset / speed`<br>角度与数字偏移。 | `135 / 0 / 0` | 方向和动画采样控制。 |
| `warp`<br>数字。 | `0.85` | 噪声扭曲强度。 |
| `seed`<br>数字或字符串。 | `0` | 稳定变化种子；字符串会用 CRC 哈希。 |

#### 示例

```lua
local smoke = MGFX.SmokePattern({
    color = Color(255, 255, 255, 22),
    scale = 140,
    density = 0.48,
    softness = 0.3,
    seed = "panel-a",
})
```

## Transform

```lua
MGFX.Transform(spec)
```

复制一个类似 CSS 的绘制变换记录，用作 style.transform。

#### 参数

| 参数 | 说明 |
| --- | --- |
| spec | 包含 origin、rotate、rotateX/Y、perspective、scale、translate、skew 和 steps 字段的变换表。 |

#### 用法说明

- 这个 helper 主要用于可读性和可复用变换记录。
- 角度单位是度；transform 只影响视觉，不改变布局/输入。

#### 返回值

复制后的 transform 表。

#### transform 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `origin / transformOrigin`<br>"50% 50%"、"left top"、{x, y} 或数字。 | `"50% 50%"` | 用于缩放、旋转、透视和指针倾斜的锚点。 |
| `rotate / rotateZ`<br>角度，单位度。 | `0` | 围绕 origin 的 2D 旋转。 |
| `rotateX / rotateY`<br>角度，单位度。 | `0` | 2.5D 倾斜。透视/投影路径会被细分，让现有 shader 保持有效 UV。 |
| `perspective`<br>数字。 | `0 / 900 for PointerTilt` | 透视距离。数值越大投影越平。 |
| `scale / scaleX / scaleY`<br>数字或 {x, y}。 | `1` | 围绕 origin 的视觉缩放。 |
| `translate / x/y/z`<br>{x, y, z} 或独立字段。 | `0` | 视觉位移；z 只影响透视。 |
| `skew / skewX / skewY`<br>角度，单位度。 | `0` | 旋转前的 2D 斜切。 |
| `steps / subdivisions`<br>0..24 的整数。 | `auto` | 投影和透视变换的细分数。 |

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
local lift = MGFX.Transform({origin = "50% 50%", perspective = 900, rotateX = -3, scale = 1.01})
```

## PointerTilt

```lua
MGFX.PointerTilt(x, y, spec)
```

创建一个由指针位置驱动的 2.5D 倾斜变换。

#### 参数

| 参数 | 说明 |
| --- | --- |
| x, y | 当前帧本地像素中的指针位置。 |
| spec.maxRotateX / maxRotateY | 最大倾斜角，单位度。 |
| spec.strength | 0..1 动画强度。 |
| spec.perspective | 透视距离；默认 900。 |

#### 用法说明

- 用于卡片、轮盘或 HUD 面板的 hover 倾斜，不需要在调用处写向量数学。
- 该变换会在 push 或 style.transform 消费时根据目标边界解析。

#### 返回值

标记为 pointerTilt 的 transform 表。

#### transform 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `origin / transformOrigin`<br>"50% 50%"、"left top"、{x, y} 或数字。 | `"50% 50%"` | 用于缩放、旋转、透视和指针倾斜的锚点。 |
| `rotate / rotateZ`<br>角度，单位度。 | `0` | 围绕 origin 的 2D 旋转。 |
| `rotateX / rotateY`<br>角度，单位度。 | `0` | 2.5D 倾斜。透视/投影路径会被细分，让现有 shader 保持有效 UV。 |
| `perspective`<br>数字。 | `0 / 900 for PointerTilt` | 透视距离。数值越大投影越平。 |
| `scale / scaleX / scaleY`<br>数字或 {x, y}。 | `1` | 围绕 origin 的视觉缩放。 |
| `translate / x/y/z`<br>{x, y, z} 或独立字段。 | `0` | 视觉位移；z 只影响透视。 |
| `skew / skewX / skewY`<br>角度，单位度。 | `0` | 旋转前的 2D 斜切。 |
| `steps / subdivisions`<br>0..24 的整数。 | `auto` | 投影和透视变换的细分数。 |

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
local tilt = MGFX.PointerTilt(mx, my, {origin = "50% 50%", perspective = 900, maxRotateX = 4, maxRotateY = 6, strength = hover})
```

## ProjectedQuad

```lua
MGFX.ProjectedQuad({tl, tr, br, bl, steps})
```

创建专家用投影四边形变换，而不是新增 ProjectedXXX 图元 API。

#### 参数

| 参数 | 说明 |
| --- | --- |
| tl, tr, br, bl | 目标四角点，格式为 {x, y} 或 {number, number}。 |
| steps | 用于更平滑类透视扭曲的细分数。 |

#### 用法说明

- 四角点使用当前帧本地像素。
- 现有 shader 仍然接收原始图元边界生成的 UV。

#### 返回值

标记为 projectedQuad 的 transform 表。

#### transform 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `origin / transformOrigin`<br>"50% 50%"、"left top"、{x, y} 或数字。 | `"50% 50%"` | 用于缩放、旋转、透视和指针倾斜的锚点。 |
| `rotate / rotateZ`<br>角度，单位度。 | `0` | 围绕 origin 的 2D 旋转。 |
| `rotateX / rotateY`<br>角度，单位度。 | `0` | 2.5D 倾斜。透视/投影路径会被细分，让现有 shader 保持有效 UV。 |
| `perspective`<br>数字。 | `0 / 900 for PointerTilt` | 透视距离。数值越大投影越平。 |
| `scale / scaleX / scaleY`<br>数字或 {x, y}。 | `1` | 围绕 origin 的视觉缩放。 |
| `translate / x/y/z`<br>{x, y, z} 或独立字段。 | `0` | 视觉位移；z 只影响透视。 |
| `skew / skewX / skewY`<br>角度，单位度。 | `0` | 旋转前的 2D 斜切。 |
| `steps / subdivisions`<br>0..24 的整数。 | `auto` | 投影和透视变换的细分数。 |

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
local q = MGFX.ProjectedQuad({
    tl = {x = x + 8, y = y},
    tr = {x = x + w - 3, y = y + 5},
    br = {x = x + w, y = y + h},
    bl = {x = x, y = y + h - 7},
    steps = 12,
})
```

## PushTransform

```lua
MGFX.PushTransform(transform, x, y, w, h)
```

为多次即时 MGFX 绘制压入一个绘制阶段变换。

#### 参数

| 参数 | 说明 |
| --- | --- |
| transform | Transform、PointerTilt 或 ProjectedQuad 记录。 |
| x, y, w, h | 用于解析 origin 和 pointer tilt 的边界。 |

#### 用法说明

- 每次成功 PushTransform 都要在同一绘制 pass 中配对 PopTransform。
- 嵌套 transform 会从内到外进行视觉组合。

#### 返回值

成功压入时返回 true，否则返回 false。

#### transform 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `origin / transformOrigin`<br>"50% 50%"、"left top"、{x, y} 或数字。 | `"50% 50%"` | 用于缩放、旋转、透视和指针倾斜的锚点。 |
| `rotate / rotateZ`<br>角度，单位度。 | `0` | 围绕 origin 的 2D 旋转。 |
| `rotateX / rotateY`<br>角度，单位度。 | `0` | 2.5D 倾斜。透视/投影路径会被细分，让现有 shader 保持有效 UV。 |
| `perspective`<br>数字。 | `0 / 900 for PointerTilt` | 透视距离。数值越大投影越平。 |
| `scale / scaleX / scaleY`<br>数字或 {x, y}。 | `1` | 围绕 origin 的视觉缩放。 |
| `translate / x/y/z`<br>{x, y, z} 或独立字段。 | `0` | 视觉位移；z 只影响透视。 |
| `skew / skewX / skewY`<br>角度，单位度。 | `0` | 旋转前的 2D 斜切。 |
| `steps / subdivisions`<br>0..24 的整数。 | `auto` | 投影和透视变换的细分数。 |

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
if MGFX.PushTransform(tilt, x, y, w, h) then
    MGFX.RoundedBoxEx(x, y, w, h, {radius = 12, fill = fill})
    MGFX.RingEx(cx, cy, 42, 6, {fill = ringFill})
    MGFX.PopTransform()
end
```

## PopTransform

```lua
MGFX.PopTransform()
```

弹出当前绘制变换。

#### 用法说明

- 只在 PushTransform 返回 true 之后调用。
- 它只影响之后的 MGFX 绘制调用；已经绘制的图元不会改变。

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
MGFX.PopTransform()
```

## TransformPoint

```lua
MGFX.TransformPoint(px, py, transform, x, y, w, h)
```

把点通过一个 transform 记录做正向映射。

#### 参数

| 参数 | 说明 |
| --- | --- |
| px, py | 变换前的点。 |
| transform, x, y, w, h | 用于解析的 transform 和边界。 |

#### 用法说明

- 如果省略 transform，则使用当前 transform stack。
- 用于视觉辅助和诊断，不要把它当成隐式布局系统。

#### 返回值

映射后的 x, y。

#### transform 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `origin / transformOrigin`<br>"50% 50%"、"left top"、{x, y} 或数字。 | `"50% 50%"` | 用于缩放、旋转、透视和指针倾斜的锚点。 |
| `rotate / rotateZ`<br>角度，单位度。 | `0` | 围绕 origin 的 2D 旋转。 |
| `rotateX / rotateY`<br>角度，单位度。 | `0` | 2.5D 倾斜。透视/投影路径会被细分，让现有 shader 保持有效 UV。 |
| `perspective`<br>数字。 | `0 / 900 for PointerTilt` | 透视距离。数值越大投影越平。 |
| `scale / scaleX / scaleY`<br>数字或 {x, y}。 | `1` | 围绕 origin 的视觉缩放。 |
| `translate / x/y/z`<br>{x, y, z} 或独立字段。 | `0` | 视觉位移；z 只影响透视。 |
| `skew / skewX / skewY`<br>角度，单位度。 | `0` | 旋转前的 2D 斜切。 |
| `steps / subdivisions`<br>0..24 的整数。 | `auto` | 投影和透视变换的细分数。 |

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
local sx, sy = MGFX.TransformPoint(px, py, transform, x, y, w, h)
```

## UntransformPoint

```lua
MGFX.UntransformPoint(px, py, transform, x, y, w, h)
```

近似求解一个 transform 记录的反向映射。

#### 参数

| 参数 | 说明 |
| --- | --- |
| px, py | 变换后的屏幕/本地点。 |
| transform, x, y, w, h | 用于解析的 transform 和边界。 |

#### 用法说明

- 如果省略 transform，则使用当前 transform stack。
- 它使用小型数值反解，主要用于鼠标跟随类视觉效果。
- 命中测试仍然是调用方或 UI 层的职责。

#### 返回值

近似的变换前 x, y。

#### transform 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `origin / transformOrigin`<br>"50% 50%"、"left top"、{x, y} 或数字。 | `"50% 50%"` | 用于缩放、旋转、透视和指针倾斜的锚点。 |
| `rotate / rotateZ`<br>角度，单位度。 | `0` | 围绕 origin 的 2D 旋转。 |
| `rotateX / rotateY`<br>角度，单位度。 | `0` | 2.5D 倾斜。透视/投影路径会被细分，让现有 shader 保持有效 UV。 |
| `perspective`<br>数字。 | `0 / 900 for PointerTilt` | 透视距离。数值越大投影越平。 |
| `scale / scaleX / scaleY`<br>数字或 {x, y}。 | `1` | 围绕 origin 的视觉缩放。 |
| `translate / x/y/z`<br>{x, y, z} 或独立字段。 | `0` | 视觉位移；z 只影响透视。 |
| `skew / skewX / skewY`<br>角度，单位度。 | `0` | 旋转前的 2D 斜切。 |
| `steps / subdivisions`<br>0..24 的整数。 | `auto` | 投影和透视变换的细分数。 |

#### 支持目标与边界

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `Shape Ex calls`<br>RoundedBoxEx、ChamferBoxEx、PolyEx、LineEx、CircleEx、CapsuleEx。 | `supported` | 调用内部的所有绘制/特效层共享同一个 transform。 |
| `Image Ex calls`<br>ImageEx 和 IconEx。 | `supported` | shader 图像、遮罩、backdrop、发光、背景和描边路径共享 transform。 |
| `Widget Ex calls`<br>ProgressBarEx、SegmentBarEx、RingEx、ArcEx、SectorEx。 | `supported` | 复合回退层会继承同一个 pushed transform。 |
| `Text`<br>TextEx 和 TextBoxEx。 | `not promised` | 文本使用独立的延迟 glyph/atlas 合成器。 |
| `Layout/input`<br>帧坐标和命中测试。 | `unchanged` | transform 只影响视觉。TransformPoint/UntransformPoint 只用于显式视觉辅助。 |

#### 示例

```lua
local localMx, localMy = MGFX.UntransformPoint(mx, my, transform, x, y, w, h)
```

## GetCapabilities

```lua
MGFX.GetCapabilities(target)
```

返回某个 target 已实现的渲染槽位和元数据。

#### 参数

| 参数 | 说明 |
| --- | --- |
| target | MGFX.TARGET 值，例如 MGFX.TARGET.RING。 |

#### 用法说明

- 用于 demo 或可选 UI 修饰的功能门控。
- Capabilities 描述当前 immediate/fallback 实现槽位，不是已退役批处理控制。

#### 返回值

该 target 的 capability 表；未知时为 nil/空。

#### target 对照

| Target | 类别 | 覆盖路径 | 支持字段 |
| --- | --- | --- | --- |
| `MGFX.TARGET.ROUNDED_BOX` | 形状 | roundedBox | fill、stroke、strokeWidth、shadow、outerGlow、innerGlow、backdrop、pattern、transform |
| `MGFX.TARGET.CIRCLE` | 形状 | circle | 与 rounded box 形状字段相同。 |
| `MGFX.TARGET.CAPSULE` | 形状 | capsule | 与 rounded box 形状字段相同。 |
| `MGFX.TARGET.CHAMFER_BOX` | 形状 | chamferBox | fill、stroke、strokeWidth、shadow、outerGlow、innerGlow、backdrop、pattern、cuts、transform |
| `MGFX.TARGET.POLY` | 形状 | convexPoly | fill、stroke、strokeWidth、shadow、backdrop、pattern、transform |
| `MGFX.TARGET.LINE` | 形状 | line | fill、color、width、radius、caps、noCaps、backdrop、transform |
| `MGFX.TARGET.RING` | 形状 | ring | fill、color、stroke、strokeWidth、shadow、outerGlow、innerGlow、backdrop、pattern、transform |
| `MGFX.TARGET.ARC` | 形状 | arc | 与 ring 字段相同。 |
| `MGFX.TARGET.SECTOR` | 形状 | sector | fill、color、stroke、strokeWidth、shadow、outerGlow、innerGlow、backdrop、pattern、transform |
| `MGFX.TARGET.IMAGE` | 内容 | imageMask | source、fill/background、stroke、shadow、outerGlow、backdrop、mask、radius、tint/color、alpha、fit/objectFit、position、crop、uv、transform |
| `MGFX.TARGET.PROGRESS_BAR` | 复合组件 | progress | track、fill、stroke、radius、padding、shadow、outerGlow、innerGlow、backdrop、fillPattern、trackPattern、pattern、fx、transform |
| `MGFX.TARGET.SEGMENT_BAR` | 复合组件 | segmentBar | segments、gap、track、fill、stroke、radius、background、backgroundRadius、shadow、outerGlow、innerGlow、backdrop、fillPattern、trackPattern、pattern、transform |
| `MGFX.TARGET.TEXT` | 文本 | glyph | fill/color、alignX、alignY、valign、shadow、stroke、glow、weight、italic、letterSpacing、lineHeight |

#### 示例

```lua
local caps = MGFX.GetCapabilities(MGFX.TARGET.RING)
PrintTable(caps)
```

## Supports

```lua
MGFX.Supports(target, key)
```

检查某个 target 是否支持一个公共渲染槽位。

#### 参数

| 参数 | 说明 |
| --- | --- |
| target | MGFX.TARGET 值。 |
| key | Capability 键，例如 "outerGlow" 或 "pattern"。 |

#### 用法说明

- 可选示例中优先使用它，而不是硬编码假设。
- 返回 false 表示该 target 没有实现这个文档槽位。

#### 返回值

布尔值。

#### target 对照

| Target | 类别 | 覆盖路径 | 支持字段 |
| --- | --- | --- | --- |
| `MGFX.TARGET.ROUNDED_BOX` | 形状 | roundedBox | fill、stroke、strokeWidth、shadow、outerGlow、innerGlow、backdrop、pattern、transform |
| `MGFX.TARGET.CIRCLE` | 形状 | circle | 与 rounded box 形状字段相同。 |
| `MGFX.TARGET.CAPSULE` | 形状 | capsule | 与 rounded box 形状字段相同。 |
| `MGFX.TARGET.CHAMFER_BOX` | 形状 | chamferBox | fill、stroke、strokeWidth、shadow、outerGlow、innerGlow、backdrop、pattern、cuts、transform |
| `MGFX.TARGET.POLY` | 形状 | convexPoly | fill、stroke、strokeWidth、shadow、backdrop、pattern、transform |
| `MGFX.TARGET.LINE` | 形状 | line | fill、color、width、radius、caps、noCaps、backdrop、transform |
| `MGFX.TARGET.RING` | 形状 | ring | fill、color、stroke、strokeWidth、shadow、outerGlow、innerGlow、backdrop、pattern、transform |
| `MGFX.TARGET.ARC` | 形状 | arc | 与 ring 字段相同。 |
| `MGFX.TARGET.SECTOR` | 形状 | sector | fill、color、stroke、strokeWidth、shadow、outerGlow、innerGlow、backdrop、pattern、transform |
| `MGFX.TARGET.IMAGE` | 内容 | imageMask | source、fill/background、stroke、shadow、outerGlow、backdrop、mask、radius、tint/color、alpha、fit/objectFit、position、crop、uv、transform |
| `MGFX.TARGET.PROGRESS_BAR` | 复合组件 | progress | track、fill、stroke、radius、padding、shadow、outerGlow、innerGlow、backdrop、fillPattern、trackPattern、pattern、fx、transform |
| `MGFX.TARGET.SEGMENT_BAR` | 复合组件 | segmentBar | segments、gap、track、fill、stroke、radius、background、backgroundRadius、shadow、outerGlow、innerGlow、backdrop、fillPattern、trackPattern、pattern、transform |
| `MGFX.TARGET.TEXT` | 文本 | glyph | fill/color、alignX、alignY、valign、shadow、stroke、glow、weight、italic、letterSpacing、lineHeight |

#### 示例

```lua
if MGFX.Supports(MGFX.TARGET.RING, "outerGlow") then
    MGFX.RingEx(cx, cy, 36, 6, {fill = Color(80, 170, 255), outerGlow = {width = 14}})
end
```

[返回详细 API 入口](./index)
