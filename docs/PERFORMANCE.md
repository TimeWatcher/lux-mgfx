# MGFX Performance Model

MGFX optimizes the immediate drawing model instead of hiding it behind a large scheduler. Garry's Mod UI performance is usually lost through Lua-side bookkeeping, temporary tables, material parameter churn, and unnecessary Source API calls, not draw count alone.

## Design Goals

- Keep shape and HUD-meter rendering on immediate shader/fallback paths.
- Flatten public style records at the API boundary; internal draw layers should receive prepared scalar, fill, and effect parameters.
- Upload hot-path parameters through the shared matrix parameter page when possible.
- Use focused fused effect shaders when they remove repeated Lua setup without changing the source-over result.
- Treat patterns as shader paint fields instead of geometry recipes.
- Avoid per-frame allocations in common drawing calls.
- Keep text routing explicit: native text for normal labels, composer text only for shader effects.

## Current Baseline

The current representative stress case is a complex shop UI using many rounded
boxes, gradients, strokes, shadows, glows, and image/text rows. With diagnostics
disabled, recent in-game testing showed:

```text
Full item list      stable 130+ FPS
Lighter categories  stable 160+ FPS
```

This result came from reducing Lua-side preparation and redundant passes. It
was not achieved by reintroducing a general batch scheduler.

## Hot Path Rules

| Rule | Reason |
| --- | --- |
| Prefer `Name(...)` for very simple calls. | Short signatures avoid table allocation and style normalization. |
| Use `NameEx(..., style)` when parameters need names. | Readability wins once a call has effects, masks, or multiple optional fields. |
| Reuse style tables for stable HUD elements. | Lua table churn is visible in frequently painted panels. |
| Use paint records for gradients and patterns. | The renderer can keep the effect inside the shape shader. |
| Do not emulate patterns with many primitives. | Many small line/box calls add Lua and draw overhead without improving quality. |

## Prepared Draw Layers

Public API calls may use style tables because that is the ergonomic interface
for GLua and Lux callers. Renderer internals should not keep passing those
tables through multiple layers.

The hot path should follow this shape:

```text
public API style table
  -> one boundary parse
  -> prepared fill/stroke/effect scalar parameters
  -> shader/fallback draw
```

Avoid this shape in new renderer code:

```text
style table
  -> helper table/spec
  -> forwarded style table
  -> second normalization
  -> shader/fallback draw
```

Rounded boxes, chamfers, progress/segment widgets, image round/chamfer paths,
line-backed rectangles, and polygon/chamfer fallback helpers now use prepared
parameters internally. This keeps the public API readable while removing
repeated `shadowRaw`, `outerGlowRaw`, `innerGlowRaw`, `backdropStyle`,
`patternStyle`, `fillFromStyle`, and `fillVisible` work from inner loops.

## Parameter Upload

The hot path should prefer matrix pages over individual float constants:

```text
c11 / $viewprojmat     MGFXExtraParams, main 16-float page
c15 / $invviewprojmat  MGFXAuxParams, auxiliary 16-float page
```

Local GMod profiling showed repeated `SetFloat` calls are several times more expensive than `SetUnpacked + SetMatrix`. Treat `$c0..$c3` as compatibility/diagnostic registers, not the default parameter path for new shaders.

## Fused Effect Passes

The current renderer intentionally fuses compatible `shadow + outerGlow` work for rounded boxes, chamfers, rings, and image masks. This removes duplicated style preparation, material setup, and draw calls while preserving the visual layers.

Rounded boxes also support layered `shadow = { {...}, {...} }`. This is cheaper
than stacking multiple full `RoundedBoxEx` calls: style parsing happens once,
the renderer loops only the shadow path for each layer, and the body/effects
that belong to the source shape are drawn once.

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
