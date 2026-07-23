# Plain GLua Quick Start

Use this path when your project is a normal Garry's Mod addon or gamemode and does not use Lux.

## Install

Copy `lua-mgfx/` as your addon root:

```text
garrysmod/addons/mgfx/
  lua/
  materials/
  resource/
  addon.json
```

Garry's Mod loads the autorun files automatically. After the client loader runs, call the public `MGFX.*` API from client-side drawing code. Do not include implementation files from `lua/mgfx` directly.

## First Panel

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

```lux [Lux Equivalent]
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

`StartPanel` makes all following coordinates panel-local. Do not add `LocalToScreen` offsets yourself.

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

Use `StartScreen` only for screen-space HUD and overlay drawing. VGUI panels should use `StartPanel`.

## Names

Plain GLua uses PascalCase names on the global facade:

| Task | GLua |
| --- | --- |
| Frame start | `MGFX.StartPanel(...)` |
| Shape | `MGFX.RoundedBoxEx(...)` |
| Gradient | `MGFX.LinearGradient(...)` |
| Image mask | `style.mask = {kind = "circle"}` |
| Shared antialiased clip | `MGFX.Mask(...)` + `MGFX.Clip(...)` |
| Text | `MGFX.TextEx(...)` |

The Lux equivalents use lowerCamelCase under `mgfx.api`.

## Next

- Read [Core Concepts](./concepts) for frame scope, `Name` / `NameEx`, and style tables.
- Use [API Reference](../api-reference/) when you need exact parameters and fields.
- Use [Effects](./effects) for `shadow`, `outerGlow`, `backdrop`, and patterns.
- Use [Masks and Antialiased Clip](./masks-and-clip) when several draws share one non-rectangular boundary.
