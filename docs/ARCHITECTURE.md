# Architecture

This page records the current maintenance boundaries for MGFX. Public API details live in [API Overview](./API) and the [API Reference](./api-reference/).

## What MGFX Owns

MGFX owns rendering:

- shader-backed immediate shapes
- fallback drawing paths
- image masks
- text routing and optional composer text
- frame scopes and clipping
- paint records for gradients and patterns
- prepared scalar/fill/effect draw layers below the public API boundary
- visual transforms
- runtime capability queries

MGFX does not own:

- layout
- input
- focus
- component lifecycle
- animation state
- transitions
- hit testing

Callers compute the current visual state and submit draw calls every frame.

## Module Boundaries

These are internal maintenance boundaries, not user-facing entry points. Application code should call `MGFX.*` or `mgfx.api.*`; it should not decide whether a draw call belongs to `roundrect`, `primitives`, `widgets`, `paint`, or `style`.

| Area | Responsibility |
| --- | --- |
| `roundrect` | Rounded boxes, circles, capsules, shared glow/shadow style normalization. |
| `primitives` | Lines, convex polygons, chamfer boxes, regular polygons, diamonds, carets. |
| `widgets` | Progress bars, segment bars, rings, arcs, sectors, images, icons. |
| `style` | Fill records, gradients, masks, pattern records, color helpers. |
| `materials` | Shaderpack mount, render targets, material creation, shader status. |
| `text` | Native text route, shader text composer, measuring, prewarming. |
| `api` | Public facade used by Lux and the precompiled runtime. |

## Hot Draw Pipeline

Public API calls are allowed to accept style tables. Internal renderer code
should not keep forwarding those tables once a call has crossed the public API
boundary.

The intended shape is:

```text
MGFX.RoundedBoxEx(..., style)
  -> resolve public aliases and defaults once
  -> pass scalar radius/fill/stroke/effect parameters
  -> execute shader/fallback draw path
```

The renderer should avoid hidden chains like:

```text
widget helper -> temporary style table -> shape helper -> style normalization -> draw
```

That chain is both harder to read and measurably slower in GMod because it
adds table reads, temporary records, cache checks, and duplicated effect
normalization before the actual draw call.

## Transforms

Transforms are draw-phase visual transforms. They do not affect layout or hit testing.

Do not add primitive-specific projected APIs such as `ProjectedRoundedBoxEx` or `ProjectedRing`. Use `style.transform`, `PushTransform`, or `PointerTilt`.

## Masks

Masks are per-primitive shader coverage, not a global stencil stack. Avoid stencil-based shape masks unless a future feature proves it needs stencil semantics.

## Public API Discipline

The project is still stabilizing, so incompatible public API improvements are allowed when they make the renderer clearer. However, every public API change must update:

- API overview
- grouped API reference
- examples or demos that rely on the old shape
- plain GLua and Lux usage if both are affected

## Runtime Packages

Lux projects use `@lux/mgfx`. Plain GLua projects use the precompiled loader and global `MGFX.*` facade. Both routes should expose the same public behavior.
