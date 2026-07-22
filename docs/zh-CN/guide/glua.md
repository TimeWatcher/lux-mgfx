# 普通 GLua 快速开始

普通 Garry's Mod addon 或 gamemode 不使用 Lux 时，从这里开始。

## 安装

把 `lua-mgfx/` 作为 addon 根目录复制：

```text
garrysmod/addons/mgfx/
  lua/
  materials/
  resource/
  addon.json
```

Garry's Mod 会自动执行 autorun loader。客户端 loader 完成后，在客户端绘制代码中调用 `MGFX.*`。不要直接 include `lua/mgfx` 下的实现文件。

## 第一个 Panel

::: code-group

```lua [GLua]
function PANEL:Paint(w, h)
    MGFX.StartPanel(self, w, h)

    MGFX.RoundedBoxEx(0, 0, w, h, {
        radius = 10,
        fill = Color(18, 24, 32, 230),
        shadow = {x = 0, y = 6, blur = 14, color = Color(0, 0, 0, 110)},
    })

    MGFX.Text("READY", "DermaDefaultBold", 16, 18, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    MGFX.EndPanel()
end
```

```lux [Lux 对照]
import * as mgfx from "@lux/mgfx"

fn PANEL:Paint(w, h) {
  local draw = mgfx.api
  draw.startPanel(self, w, h)

  draw.roundedBoxEx(0, 0, w, h, {
    radius = 10,
    fill = Color(18, 24, 32, 230),
    shadow = {x = 0, y = 6, blur = 14, color = Color(0, 0, 0, 110)},
  })

  draw.text("READY", "DermaDefaultBold", 16, 18, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
  draw.endPanel();
}
```

:::

`StartPanel` 会建立 panel-local 坐标系，不要再手动叠加 `LocalToScreen` 偏移。

## HUDPaint

```lua
hook.Add("HUDPaint", "MyMGFXHud", function()
    MGFX.StartScreen()

    local x, y = 32, ScrH() - 72
    MGFX.ProgressBarEx(x, y, 220, 14, LocalPlayer():Health() / 100, {
        radius = 7,
        padding = 2,
        track = Color(255, 255, 255, 22),
        fill = MGFX.LinearGradient(0, 0, 1, 0, Color(255, 96, 78), Color(255, 190, 66)),
    })

    MGFX.EndScreen()
end)
```

screen-space HUD 和 overlay 使用 `StartScreen`；VGUI panel 使用 `StartPanel`。

## 命名

| 任务 | GLua |
| --- | --- |
| 开始 frame | `MGFX.StartPanel(...)` |
| 绘制形状 | `MGFX.RoundedBoxEx(...)` |
| 创建渐变 | `MGFX.LinearGradient(...)` |
| 创建图像遮罩 | `MGFX.Mask(...)` |
| 特效文字 | `MGFX.TextEx(...)` |

Lux 等价 API 位于 `mgfx.api`，名称使用 lowerCamelCase。

## 下一步

- 阅读 [核心概念](./concepts)，理解 frame scope、`Name` / `NameEx` 和 style table。
- 精确参数和字段查 [API 参考](../api-reference/)。
- shadow、outer glow、backdrop 和 pattern 查 [特效指南](./effects)。
