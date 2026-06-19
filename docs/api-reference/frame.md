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

MGFX.ShaderStatus()
MGFX.HasShaders()
MGFX.GetCapabilities(target)
MGFX.Supports(target, key)
```

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

Clips subsequent drawing to a rectangular scissor region. This is not a general shape mask. Shape masks are per-primitive shader coverage.

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
