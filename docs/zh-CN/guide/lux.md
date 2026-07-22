# Lux 快速开始

项目使用 Lux 并通过 `@lux/mgfx` 消费 MGFX 时，从这里开始。

## 安装

从 GitHub 安装：

```powershell
luxc install @lux/mgfx --from github:TimeWatcher/lux-mgfx --tag v0.1.0
```

从本地 checkout 安装：

```powershell
luxc install @lux/mgfx --from C:\Development\gmod\lux-mgfx
```

普通 Lux 代码导入 public facade，调用 `mgfx.api.*`。只有需要给非 Lux 代码暴露 `MGFX.*` 全局表时，才调用 `installGlobal("MGFX")`。

把 panel 绘制代码放在 client realm 的 Lux 源文件中。

## 第一个 Panel

::: code-group

```lux [Lux]
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

```lua [GLua 对照]
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

:::

## API 命名

| GLua | Lux |
| --- | --- |
| `MGFX.StartPanel` | `mgfx.api.startPanel` |
| `MGFX.RoundedBoxEx` | `mgfx.api.roundedBoxEx` |
| `MGFX.ProgressBarEx` | `mgfx.api.progressBarEx` |
| `MGFX.LinearGradient` | `mgfx.api.linearGradient` |
| `MGFX.WornPattern` | `mgfx.api.wornPattern` |
| `MGFX.TextEx` | `mgfx.api.textEx` |

旧的 `@lux/mgfx/paint` 不是应用入口。gradient 和 pattern 通过 `mgfx.api` helper 创建，再作为 `fill`、`track`、`pattern` 等字段传入。

## 全局桥接

只有 GLua panel 或旧集成明确依赖 `MGFX.*` 时才安装全局表：

```lux
import * as mgfx from "@lux/mgfx"

client {
  mgfx.installGlobal("MGFX");
}
```

新 Lux UI 代码继续使用 `mgfx.api.*`。

## 下一步

- 阅读 [核心概念](./concepts)，理解 frame scope、`Name` / `NameEx` 和 style table。
- 精确参数和字段查 [API 参考](../api-reference/)。
- shadow、outer glow、backdrop 和 pattern 查 [特效指南](./effects)。
