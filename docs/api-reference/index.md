# API Reference

This is the task-oriented reference for the public MGFX API. Use [API Overview](../API.md) first if you want the conceptual model and recommended entry points.

These pages are documentation groups only. Application code should call `MGFX.*` in plain GLua or `mgfx.api.*` from `@lux/mgfx` in Lux; do not choose imports based on the page names.

API names, Lua parameter names, and shader terms are kept in English.

## Task Pages

| Area | Page | Main APIs |
| --- | --- | --- |
| Frame scope and diagnostics | [Frame and Debug](./frame) | `StartPanel`, `EndPanel`, `StartScreen`, `EndScreen`, `PushClip`, `PopClip`, `ShaderStatus` |
| Shapes and lines | [Shapes and Lines](./primitives) | `RoundedBoxEx`, `ChamferBoxEx`, `PolyEx`, `LineEx`, `CircleEx`, `CapsuleEx` |
| Images | [Images and Masks](./images) | `ImageEx`, `IconEx`, `Mask`, `MaterialSource`, `TextureSource` |
| HUD meters and sectors | [HUD Meters and Sectors](./widgets) | `ProgressBarEx`, `SegmentBarEx`, `RingEx`, `ArcEx`, `SectorEx` |
| Text | [Text API](./text-api) | `Text`, `TextEx`, `TextBoxEx`, `MeasureText`, `PrewarmText` |
| Paint records and transforms | [Paint, Patterns, Transforms](./paint) | `LinearGradient`, `SmokePattern`, `Transform`, `PointerTilt`, `GetCapabilities` |

## Reading Order

1. [API Overview](../API.md)
2. The task page for the API you are calling
3. [Performance Model](../PERFORMANCE.md) when changing hot paths
4. [Shaders and Packaging](../SHADERS.md) when changing shader parameters or shaderpack contents

## Notes

- New application code should use `@lux/mgfx` / `mgfx.api` in Lux, or `MGFX.*` in plain GLua.
- Subpackages are public enough for narrow imports, but the facade is the normal user-facing API.
- Capabilities describe implemented render slots, not future plans.
