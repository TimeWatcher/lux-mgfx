# MGFX API 导航

本页保留 `/zh-CN/API` 路径，兼容旧链接。新用户请从对应运行时开始：

- [普通 GLua 快速开始](./guide/glua)
- [Lux 快速开始](./guide/lux)
- [核心概念](./guide/concepts)
- [API 参考](./api-reference/)

## 同一套 API，两种门面

::: code-group

```lua [GLua]
MGFX.RoundedBoxEx(16, 16, 220, 48, {
    radius = 8,
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(80, 170, 255), Color(90, 220, 180)),
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

client fn drawPanel() {
  local draw = mgfx.api
  draw.roundedBoxEx(16, 16, 220, 48, {
    radius = 8,
    fill = draw.linearGradient(0, 0, 1, 0, Color(80, 170, 255), Color(90, 220, 180)),
  });
}
```

:::

普通 GLua 使用 `MGFX.*` 的 PascalCase 名称；Lux 使用 `mgfx.api.*` 的 lowerCamelCase 名称。渲染行为和 style 字段相同。

| GLua | Lux |
| --- | --- |
| `MGFX.StartPanel` | `mgfx.api.startPanel` |
| `MGFX.RoundedBoxEx` | `mgfx.api.roundedBoxEx` |
| `MGFX.ImageEx` | `mgfx.api.imageEx` |
| `MGFX.ProgressBarEx` | `mgfx.api.progressBarEx` |
| `MGFX.LinearGradient` | `mgfx.api.linearGradient` |
| `MGFX.TextEx` | `mgfx.api.textEx` |

## 应该看哪一页

| 需求 | 页面 |
| --- | --- |
| 在普通 addon 中安装并完成第一次绘制 | [普通 GLua 快速开始](./guide/glua) |
| 在 Lux 项目中安装并完成第一次绘制 | [Lux 快速开始](./guide/lux) |
| frame scope、`Name` / `NameEx`、style table | [核心概念](./guide/concepts) |
| shadow、glow、backdrop、pattern | [特效指南](./guide/effects) |
| 准确函数签名和字段 | [API 参考](./api-reference/) |
| 热路径规则和性能取舍 | [性能模型](./PERFORMANCE) |
| shaderpack 和打包 | [Shader 与打包](./SHADERS) |

## API 分组

| 范围 | 主要 API |
| --- | --- |
| 帧作用域 | `StartPanel`、`EndPanel`、`StartScreen`、`EndScreen`、`PushClip`、`PopClip` |
| 形状与线条 | `RoundedBoxEx`、`ChamferBoxEx`、`RegularPolyEx`、`PolyEx`、`LineEx`、`CircleEx`、`CapsuleEx` |
| 图像与遮罩 | `ImageEx`、`IconEx`、`Mask` |
| HUD 数值组件 | `ProgressBarEx`、`SegmentBarEx`、`RingEx`、`ArcEx`、`SectorEx` |
| 文字 | `Text`、`TextEx`、`TextBoxEx`、`MeasureText`、`PrewarmText` |
| Paint 与变换 | `LinearGradient`、`RadialGradient`、`WornPattern`、`Transform`、`PointerTilt`、`GetCapabilities` |

MGFX 只负责绘制，不负责 layout、input、focus、component lifecycle、animation state 或 hit testing。
