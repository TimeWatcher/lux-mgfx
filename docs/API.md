# MGFX API Guide

This page stays at `/API` for older links. New readers should start with the runtime-specific guides:

- [Plain GLua Quick Start](./guide/glua)
- [Lux Quick Start](./guide/lux)
- [Core Concepts](./guide/concepts)
- [API Reference](./api-reference/)

## Same API, Two Facades

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

Plain GLua uses PascalCase names on `MGFX.*`. Lux uses lowerCamelCase names on `mgfx.api.*`. The renderer behavior and style fields are the same.

| GLua | Lux |
| --- | --- |
| `MGFX.StartPanel` | `mgfx.api.startPanel` |
| `MGFX.RoundedBoxEx` | `mgfx.api.roundedBoxEx` |
| `MGFX.ImageEx` | `mgfx.api.imageEx` |
| `MGFX.ProgressBarEx` | `mgfx.api.progressBarEx` |
| `MGFX.LinearGradient` | `mgfx.api.linearGradient` |
| `MGFX.TextEx` | `mgfx.api.textEx` |

## What To Read

| Need | Page |
| --- | --- |
| Install and first draw call in a normal addon | [Plain GLua Quick Start](./guide/glua) |
| Install and first draw call in Lux | [Lux Quick Start](./guide/lux) |
| Frame scope, `Name` / `NameEx`, style tables | [Core Concepts](./guide/concepts) |
| Shadow, glow, backdrop, patterns | [Effects](./guide/effects) |
| Exact signatures and fields | [API Reference](./api-reference/) |
| Hot path rules and performance tradeoffs | [Performance Model](./PERFORMANCE) |
| Shaderpack and packaging details | [Shaders and Packaging](./SHADERS) |

## API Groups

| Area | Main APIs |
| --- | --- |
| Frame scope | `StartPanel`, `EndPanel`, `StartScreen`, `EndScreen`, `PushClip`, `PopClip` |
| Shapes and lines | `RoundedBoxEx`, `ChamferBoxEx`, `RegularPolyEx`, `PolyEx`, `LineEx`, `CircleEx`, `CapsuleEx` |
| Images and masks | `ImageEx`, `IconEx`, `Mask` |
| HUD meters and sectors | `ProgressBarEx`, `SegmentBarEx`, `RingEx`, `ArcEx`, `SectorEx` |
| Text | `Text`, `TextEx`, `TextBoxEx`, `MeasureText`, `PrewarmText` |
| Paint and transforms | `LinearGradient`, `RadialGradient`, `EllipticalRadialGradient`, `WornPattern`, `Transform`, `PointerTilt`, `GetCapabilities` |

MGFX is a renderer, not a UI framework. It does not own layout, input, focus, component lifecycle, animation state, or hit testing.
