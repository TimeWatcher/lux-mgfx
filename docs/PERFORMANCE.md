# MGFX Performance Model

MGFX optimizes the immediate drawing model instead of hiding it behind a large scheduler. Garry's Mod UI performance is usually lost through Lua-side bookkeeping, temporary tables, material parameter churn, and unnecessary Source API calls, not draw count alone.

## Design Goals

- Keep shape and HUD-meter rendering on immediate shader/fallback paths.
- Upload hot-path parameters through the shared matrix parameter page when possible.
- Use focused fused effect shaders when they remove repeated Lua setup without changing the source-over result.
- Treat patterns as shader paint fields instead of geometry recipes.
- Avoid per-frame allocations in common drawing calls.
- Keep text routing explicit: native text for normal labels, composer text only for shader effects.

## Hot Path Rules

| Rule | Reason |
| --- | --- |
| Prefer `Name(...)` for very simple calls. | Short signatures avoid table allocation and style normalization. |
| Use `NameEx(..., style)` when parameters need names. | Readability wins once a call has effects, masks, or multiple optional fields. |
| Reuse style tables for stable HUD elements. | Lua table churn is visible in frequently painted panels. |
| Use paint records for gradients and patterns. | The renderer can keep the effect inside the shape shader. |
| Do not emulate patterns with many primitives. | Many small line/box calls add Lua and draw overhead without improving quality. |

## Parameter Upload

The hot path should prefer matrix pages over individual float constants:

```text
c11 / $viewprojmat     MGFXExtraParams, main 16-float page
c15 / $invviewprojmat  MGFXAuxParams, auxiliary 16-float page
```

Local GMod profiling showed repeated `SetFloat` calls are several times more expensive than `SetUnpacked + SetMatrix`. Treat `$c0..$c3` as compatibility/diagnostic registers, not the default parameter path for new shaders.

## Fused Effect Passes

The current renderer intentionally fuses compatible `shadow + outerGlow` work for rounded boxes, chamfers, rings, and image masks. This removes duplicated style preparation, material setup, and draw calls while preserving the visual layers.

Do not fuse layers just because two shaders look similar. Backdrop blur reads the framebuffer, pattern layers can affect blend order, and convex polygons need their auxiliary page for vertices, so those paths must stay separate unless a measured implementation proves pixel-equivalent output.

## Shader and Fallback Routing

Shader paths are the normal renderer path. Fallbacks exist for missing shaders, disabled shader mode, unsupported combinations, or platform limitations.

Fallback output should remain readable and stable, but it is allowed to lose advanced visual fidelity such as exact glow softness, procedural smoke, or shader text composition.

## Text

Plain labels, player names, scoreboard rows, chat lines, logs, and fast-changing counters should stay on native GMod text unless they need shader effects.

Use MGFX text composition only for:

- gradient text faces
- soft outline or stroke
- glow titles
- polished display text
- stable labels worth prewarming

High-churn text with shader effects can consume atlas space quickly. Prewarm only predictable strings.

## Practical Checklist

- Draw large background panels first, then foreground widgets, then text.
- Prefer one `StartPanel` / `EndPanel` pair per panel paint.
- Avoid nested `PushClip` unless the clipped content actually needs it.
- Reuse gradients, masks, and style tables when they are stable.
- Avoid constructing many `Color(...)` objects in tight loops.
- Keep smoke/stripe effects in `pattern` fields.

## When Adding Renderer Features

Do not add a generalized batching layer to solve a single UI case. Add a focused shader/fallback path only when:

- the call site exists and is measurable
- the visual result can be matched reliably
- parameter layout is documented
- API docs and examples are updated
