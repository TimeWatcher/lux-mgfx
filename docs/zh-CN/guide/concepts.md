# 核心概念

MGFX 是 immediate renderer。UI 代码负责 layout、input、focus、animation state 和 hit testing；MGFX 只绘制每帧传入的明确参数。

## 选择运行时

| 项目 | 入口 | API 风格 |
| --- | --- | --- |
| 普通 Garry's Mod addon | `lua-mgfx/` addon | `MGFX.RoundedBoxEx(...)` |
| Lux 项目 | `@lux/mgfx` package | `mgfx.api.roundedBoxEx(...)` |

两套函数行为等价。GLua 在 `MGFX` 上使用 PascalCase；Lux 在 `mgfx.api` 下使用 lowerCamelCase。

## Frame Scope

::: code-group

```lua [GLua]
function PANEL:Paint(w, h)
    MGFX.StartPanel(self, w, h)
    MGFX.RoundedBox(0, 0, w, h, 8, Color(20, 24, 32, 230))
    MGFX.EndPanel()
end
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

fn PANEL:Paint(w, h) {
  local draw = mgfx.api
  draw.startPanel(self, w, h)
  draw.roundedBox(0, 0, w, h, 8, Color(20, 24, 32, 230))
  draw.endPanel();
}
```

:::

`StartPanel` 建立 panel-local 坐标系；`StartScreen` 建立 HUDPaint/overlay 使用的 screen-space 坐标系。每个 start 必须在同一次绘制中配对对应的 end。

文字和 clip command 可能延迟到 `EndPanel` / `EndScreen` flush，因此需要覆盖在形状上方的文字应在形状之后提交。

## `Name` 与 `NameEx`

```text
Name(...)    参数简短，适合简单、稳定的热路径调用
NameEx(...)  使用 style table，适合高级效果和可读参数
```

需要 `shadow`、`outerGlow`、`backdrop`、`pattern`、`mask`、`fit`、`crop`、`transform` 或 per-corner radius/cuts 时使用 `Ex`。

## 选择 API

| 需求 | 推荐 API |
| --- | --- |
| Panel、button、row | `RoundedBox` / `RoundedBoxEx` |
| 切角 HUD card | `ChamferBoxEx` |
| Badge、arrow、凸形状 | `RegularPolyEx`、`DiamondEx`、`CaretEx`、`PolyEx` |
| Avatar、icon、item art | `ImageEx`、`IconEx`、`Mask` |
| Health、ammo、loading bar | `ProgressBarEx`、`SegmentBarEx` |
| 圆形 meter、radial menu | `RingEx`、`ArcEx`、`SectorEx` |
| 普通文字 | `Text` 或原生 GMod text |
| shader 特效文字 | `TextEx`、`TextBoxEx` |
| Gradient 与 pattern | `LinearGradient`、`RadialGradient`、`WornPattern` |

## Style Table

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 10,
    fill = Color(18, 24, 32, 220),
    stroke = Color(255, 255, 255, 32),
    strokeWidth = 1,
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

mgfx.api.roundedBoxEx(x, y, w, h, {
  radius = 10,
  fill = Color(18, 24, 32, 220),
  stroke = Color(255, 255, 255, 32),
  strokeWidth = 1,
});
```

:::

所有绘制状态都是显式参数；MGFX 没有全局 fill/stroke 状态。短签名的 stroke 顺序固定为 `fill, stroke, strokeWidth`。`stroke == nil`、`strokeWidth == nil` 或 `strokeWidth <= 0` 表示没有 stroke。

## 文字路径

普通 label、table row、player name、chat text 和快速变化的 counter 应使用原生 text 或 `Text`。只有需要 gradient fill、stroke、glow、shadow、weight bias 或 text box composition 时才使用 `TextEx`。

## Guide 与 Reference 的边界

概念和配方放在本指南；准确签名、参数、默认值、返回值和 caveat 放在 [API 参考](../api-reference/)。
