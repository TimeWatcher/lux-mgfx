# API Reference

This section is the task-oriented reference for public MGFX functions. It is intentionally about signatures, fields, return values, and caveats. Start with [Core Concepts](../guide/concepts) if you want the mental model first.

These pages are documentation groups only. Application code should call `MGFX.*` in plain GLua or `mgfx.api.*` from `@lux/mgfx`; do not choose imports based on page names.

## Runtime Names

| Plain GLua | Lux |
| --- | --- |
| `MGFX.StartPanel(...)` | `mgfx.api.startPanel(...)` |
| `MGFX.RoundedBoxEx(...)` | `mgfx.api.roundedBoxEx(...)` |
| `MGFX.ImageEx(...)` | `mgfx.api.imageEx(...)` |
| `MGFX.ProgressBarEx(...)` | `mgfx.api.progressBarEx(...)` |
| `MGFX.LinearGradient(...)` | `mgfx.api.linearGradient(...)` |
| `MGFX.TextEx(...)` | `mgfx.api.textEx(...)` |

API names, Lua parameter names, and shader terms are kept in English.

## Task Pages

| Area | Page | Main APIs |
| --- | --- | --- |
| Frame scope and diagnostics | [Frame and Debug](./frame) | `StartPanel`, `EndPanel`, `StartScreen`, `EndScreen`, `PushClip`, `PopClip`, `ShaderStatus` |
| Shapes and lines | [Shapes and Lines](./primitives) | `RoundedBoxEx`, `ChamferBoxEx`, `PolyEx`, `LineEx`, `CircleEx`, `CapsuleEx` |
| Images | [Images and Masks](./images) | `ImageEx`, `IconEx`, `Mask`, `MaterialSource`, `TextureSource` |
| HUD meters and sectors | [HUD Meters and Sectors](./widgets) | `ProgressBarEx`, `SegmentBarEx`, `RingEx`, `ArcEx`, `SectorEx` |
| Text | [Text API](./text-api) | `Text`, `TextEx`, `TextBoxEx`, `MeasureText`, `PrewarmText` |
| Paint records and transforms | [Paint, Patterns, Transforms](./paint) | `LinearGradient`, `SmokePattern`, `WornPattern`, `Transform`, `PointerTilt`, `GetCapabilities` |

## Reading Order

1. [Plain GLua Quick Start](../guide/glua) or [Lux Quick Start](../guide/lux)
2. [Core Concepts](../guide/concepts)
3. The task page for the API you are calling
4. [Performance Model](../PERFORMANCE) when changing hot paths
5. [Shaders and Packaging](../SHADERS) when changing shader parameters or shaderpack contents

## Notes

- Subpackages are public enough for maintainers and narrow tooling, but the facade is the normal user-facing API.
- Capabilities describe implemented render slots, not future plans.
