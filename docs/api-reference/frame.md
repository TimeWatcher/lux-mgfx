# Frame and Debug API

Frame APIs define the coordinate space and flush recorded text/clip commands.

## Functions

```lua
MGFX.StartPanel(panel, w, h)
MGFX.EndPanel()

MGFX.StartScreen(w, h)
MGFX.EndScreen()

MGFX.PushClip(x, y, w, h)
MGFX.PopClip()

local mask = MGFX.Mask(painter)
MGFX.Clip(mask, x, y, w, h, callback)
mask:Clip(x, y, w, h, callback)

MGFX.ShaderStatus()
MGFX.HasShaders()
MGFX.GetCapabilities(target)
MGFX.Supports(target, key)
```

Lux uses the same functions as lowerCamelCase methods under `mgfx.api`.

## Common Template

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

local draw = mgfx.api

fn PANEL:Paint(w, h) {
  draw.startPanel(self, w, h)
  draw.roundedBox(0, 0, w, h, 8, Color(20, 24, 32, 230))
  draw.endPanel();
}
```

:::

## `StartPanel`

```lua
MGFX.StartPanel(panel, w, h)
```

Starts a panel-local MGFX frame. Coordinates inside the frame are relative to the panel, not screen coordinates.

Use this at the start of `PANEL:Paint(w, h)` and call `EndPanel()` before returning.

## `StartScreen`

```lua
MGFX.StartScreen(w, h)
```

Starts a screen-space MGFX frame, usually from `HUDPaint`.

## Clip Stack

```lua
MGFX.PushClip(x, y, w, h)
MGFX.PopClip()
```

`PushClip` clips subsequent drawing to a rectangular scissor region. It remains a cheap coarse clip, not a general shape mask.

For arbitrary-content shape clipping, define coverage and apply it with the callback-only `Clip` transaction:

```lua
local rounded = MGFX.Masks.Rounded({radius = 18, units = "local"})

MGFX.Clip(rounded, x, y, w, h, function()
    MGFX.Image(x - 20, y, w + 40, h, material)
    MGFX.Text("ANTIALIASED", "DermaLarge", x + w / 2, y + h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)
```

`MGFX.Mask(function(m, w, h) ... end)` records custom vector coverage. The recorder exposes `Draw`/`Union`, `Subtract`, `Intersect`, `Xor`, and `Invert`; see the complete [Coverage Masks, Clip, and Self-Clipping API](./masks-and-clip) for signatures, formulas, presets, invalidation, cache behavior, and shape children callbacks.

Clip does not use stencil. It captures the framebuffer before and after the callback and composites those snapshots through continuous shader coverage. This preserves antialiased edges even when the content mixes MGFX shapes, text, images, native `surface` drawing, and backdrop effects.

Each Clip costs two framebuffer copies and one bounded composite draw. The rectangular scissor is only a coarse performance bound; it does not define the shape edge. Clip requires the shader/render-target path, axis-aligned frame mapping, finite dimensions no larger than the framebuffer, and at most four nested scopes. It raises an error when unavailable instead of falling back to a binary clip. Do not call `BeginCommands` inside Clip or coverage recording; an active command batch is flushed before capture and resumed after compositing. Do not enter Clip while the caller owns a `render.OverrideBlend` or `render.OverrideAlphaWriteEnable` scope, because GMod exposes no getter with which MGFX could restore that descriptor.

## Diagnostics

```lua
local status = MGFX.ShaderStatus()
print(status.ok, status.version, status.reason)
```

`ShaderStatus` reports whether the shader runtime is active. Fallback rendering is expected when shaders are unavailable or forced off.

## Capabilities

```lua
if MGFX.Supports(MGFX.TARGET.POLY, "outerGlow") then
    MGFX.PolyEx(points, {outerGlow = {width = 12}})
end
```

Capabilities are useful for tools and optional feature probes. Normal drawing code usually does not need to branch on them.
