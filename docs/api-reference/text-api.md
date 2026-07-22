# Text API

MGFX text keeps plain text cheap and routes shader effects through a composer only when needed.

Plain GLua calls `MGFX.*`. Lux calls the same APIs as lowerCamelCase methods on `mgfx.api`.

## Functions

```lua
MGFX.Text(text, font, x, y, color, alignX, alignY)
MGFX.TextEx(text, font, x, y, color, alignX, alignY, style)

MGFX.TextBox(text, font, x, y, w, h, color, alignX, alignY)
MGFX.TextBoxEx(text, font, x, y, w, h, style)

MGFX.MeasureText(text, font)
MGFX.MeasureTextBox(text, font, w, style)
MGFX.PrewarmText(text, font, style)
```

## Plain Text

```lua
MGFX.Text("Player", "DermaDefault", x, y, Color(220, 230, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
```

Plain text should remain native where possible. This is the correct path for player names, table rows, small labels, and fast-changing counters.

## Effect Text

::: code-group

```lua [GLua]
MGFX.TextEx("OVERTIME", "DermaLarge", x, y, nil, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, {
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(255, 210, 90), Color(255, 80, 70)),
    glow = {color = Color(255, 96, 78, 120), blur = 10},
    shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 150)},
})
```

```lux [Lux]
import * as mgfx from "@lux/mgfx"

local draw = mgfx.api

draw.textEx("OVERTIME", "DermaLarge", x, y, nil, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, {
  fill = draw.linearGradient(0, 0, 1, 0, Color(255, 210, 90), Color(255, 80, 70)),
  glow = {color = Color(255, 96, 78, 120), blur = 10},
  shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 150)},
});
```

:::

Use effect text for headings, status words, scoreboard headers, and other stable display text.

## Style Fields

| Field | Meaning |
| --- | --- |
| `fill` / `color` | Text color or paint record. |
| `alignX` / `alignY` | Text alignment. |
| `shadow` | Text shadow. |
| `stroke` | Text outline/stroke. |
| `glow` | Soft text glow. |
| `weight` | Optional shader-side weight adjustment. |
| `italic` | Italic style hint. |
| `letterSpacing` | Tracking. Keep `0` for most CJK/small text. |
| `lineHeight` | Line spacing multiplier for boxes. |

## Prewarming

```lua
MGFX.PrewarmText("READY", "DermaLarge", style)
```

Prewarming only helps composer text. Do not prewarm ordinary native labels.

[Back to API Reference](./index)
