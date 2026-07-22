# Core Concepts

MGFX is an immediate renderer. Your UI code owns layout, input, focus, animation state, and hit testing. MGFX draws the explicit arguments you pass every frame.

## Runtime Choice

Start with the runtime you actually use:

| Project | Entry | API Style |
| --- | --- | --- |
| Plain Garry's Mod addon | `lua-mgfx/` addon | `MGFX.RoundedBoxEx(...)` |
| Lux project | `@lux/mgfx` package | `mgfx.api.roundedBoxEx(...)` |

The functions are equivalent. GLua uses PascalCase on the `MGFX` table; Lux uses lowerCamelCase under `mgfx.api`.

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

`StartPanel` creates a panel-local coordinate system. `StartScreen` creates a screen-space coordinate system for HUDPaint or overlays. Pair every start call with its matching end call in the same draw.

Text and clip commands may be queued and flushed at `EndPanel` / `EndScreen`, so issue text after the shapes it should appear above.

## `Name` And `NameEx`

Public drawing functions use two layers:

```text
Name(...)    short hot-path signature for simple drawing
NameEx(...)  table style signature for advanced effects and readable arguments
```

Use the short function when the call is simple and stable. Switch to `Ex` when you need fields such as `shadow`, `outerGlow`, `backdrop`, `pattern`, `mask`, `fit`, `crop`, `transform`, or per-corner radius/cuts.

## Pick The API

| Need | Preferred API |
| --- | --- |
| Panels, buttons, rows | `RoundedBox` / `RoundedBoxEx` |
| Chamfered HUD cards | `ChamferBoxEx` |
| Badges, arrows, convex shapes | `RegularPolyEx`, `DiamondEx`, `CaretEx`, `PolyEx` |
| Avatars, icons, item art | `ImageEx`, `IconEx`, `Mask` |
| Health, ammo, loading bars | `ProgressBarEx`, `SegmentBarEx` |
| Circular meters and radial menus | `RingEx`, `ArcEx`, `SectorEx` |
| Plain text | `Text` or native GMod text |
| Text with shader effects | `TextEx`, `TextBoxEx` |
| Gradients and patterns | `LinearGradient`, `RadialGradient`, `WornPattern` |

## Style Tables

All draw state is explicit. MGFX has no global fill or stroke state.

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

Stroke order is always `fill, stroke, strokeWidth`. `stroke == nil`, `strokeWidth == nil`, or `strokeWidth <= 0` means no stroke.

## Text Route

Plain labels, table rows, player names, chat text, and fast-changing counters should stay native or use `MGFX.Text`. Use `TextEx` only when you need shader text effects such as gradient fill, stroke, glow, shadow, weight bias, or composed text boxes.

## Reference Boundary

Concepts and recipes live in this guide. Exact signatures, parameter tables, defaults, return values, and caveats live in [API Reference](../api-reference/).
