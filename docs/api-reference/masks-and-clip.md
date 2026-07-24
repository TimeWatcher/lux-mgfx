# Coverage Masks, Clip, and Self-Clipping

This page is the complete reference for reusable antialiased coverage Masks,
callback-based `Clip`, and shape self-clipping. For the design overview and a
short first example, see [Coverage Masks and Antialiased Clip](../guide/masks-and-clip).

Do not confuse coverage Masks with `ImageEx(..., {mask = ...})`. An image mask
belongs to one image draw. A coverage Mask can clip any mixture of shapes,
images, text, and native drawing in a callback.

Plain GLua uses `MGFX.*`. Lux exposes the same facade as lowerCamelCase methods
on `mgfx.api`.

## API summary

```lua
local mask = MGFX.Mask(painter)

mask:Invalidate()
MGFX.Clip(mask, x, y, w, h, callback)
mask:Clip(x, y, w, h, callback)

MGFX.Masks.Circle
MGFX.Masks.Capsule
MGFX.Masks.Rounded(options)
MGFX.Masks.Chamfer(options)

MGFX.RoundedBoxEx(x, y, w, h, style, children)
MGFX.CircleEx(cx, cy, radius, style, children)
MGFX.CapsuleEx(x, y, w, h, style, children)
MGFX.ChamferBoxEx(x, y, w, h, style, children)
```

## `MGFX.Mask`

```lua
local mask = MGFX.Mask(function(m, w, h)
    -- Define coverage with m:Draw/Union/Subtract/Intersect/Xor/Invert.
end)
```

Creates an immutable Mask object. The painter is stored, not immediately
rendered. MGFX executes it when `Clip` first needs coverage for a destination;
later compatible uses reuse the raster cache.

| Painter argument | Meaning |
| --- | --- |
| `m` | Restricted coverage recorder. It is valid only while this painter is running. |
| `w`, `h` | Current Clip destination size in local UI units. The painter coordinate space is `[0, w] x [0, h]`. |

The painter should describe the complete Mask from empty coverage every time it
runs. Captured external state is allowed, but call `mask:Invalidate()` after
that state changes.

### Coverage recorder methods

The accumulator starts at `A = 0`. Each callback is rendered into temporary
coverage `B`.

| Method | Formula | Returns |
| --- | --- | --- |
| `m:Draw(callback)` | `max(A, B)` | `m` |
| `m:Union(callback)` | `max(A, B)` | `m` |
| `m:Subtract(callback)` | `A * (1 - B)` | `m` |
| `m:Intersect(callback)` | `A * B` | `m` |
| `m:Xor(callback)` | `A + B - 2AB` | `m` |
| `m:Invert()` | `1 - A` inside `[0, w] x [0, h]` | `m` |

`Draw` is an alias for `Union`. Because the accumulator begins empty, the first
`Draw` naturally initializes it. Operations cannot be nested, and recorder
methods cannot be saved and called after the painter returns.

```lua
local ringMask = MGFX.Mask(function(m, w, h)
    local radius = math.min(w, h) * 0.5

    m:Draw(function()
        MGFX.Circle(w * 0.5, h * 0.5, radius, color_white)
    end)

    m:Subtract(function()
        MGFX.Circle(w * 0.5, h * 0.5, radius - 8, color_white)
    end)
end)
```

### What a painter may draw

MGFX drawing calls inside an operation callback are interpreted as coverage.
RGB is ignored; the final alpha/antialiasing coverage remains meaningful. The
operation is chosen only by `Draw`, `Subtract`, and the other recorder methods,
not by ordinary color blending.

Supported families include rounded/chamfer boxes, circles, capsules, lines,
convex polygons, rings/arcs/sectors, images/icons, text/text boxes, progress
bars, and segment bars. Their normal and `Ex` forms may be used. A transparent
fill produces transparent coverage; a centered stroke contributes its own
coverage and can extend beyond the fill boundary.

The following are intentionally rejected while recording:

- `shadow`, `outerGlow`, `innerGlow`, and `backdrop` style effects;
- `RoundedBoxBackdrop` and `TextBatchEx`;
- nested recorder operations, nested `Clip`/`PushClip` scopes, and command
  batching;
- direct changes to render targets, 2D cameras, model matrices, scissor, blend,
  or alpha-write state.

## `MGFX.Clip`

```lua
local a, b = MGFX.Clip(mask, x, y, w, h, function()
    MGFX.Image(x, y, w, h, material)
    return "value", 42
end)
```

Applies a Mask to every draw issued by `callback`. The object form is exactly
equivalent:

```lua
mask:Clip(x, y, w, h, callback)
```

| Parameter | Meaning |
| --- | --- |
| `mask` | Object returned by `MGFX.Mask` or one of `MGFX.Masks`. |
| `x`, `y` | Clip origin in the current MGFX frame. |
| `w`, `h` | Positive Clip size. It also parameterizes the Mask painter or preset. |
| `callback` | Content transaction. Its exact return count and values are forwarded. |

The Mask painter uses coordinates relative to `(0, 0)`. The content callback
does not: it keeps the current frame's ordinary coordinates and normally draws
at `x`, `y`. Native `surface` drawing is allowed in the content callback because
the completed framebuffer result is clipped during composition.

`Clip` requires an active `StartPanel` or `StartScreen` frame, the shader/render
target path, finite positive dimensions no larger than the framebuffer, and an
axis-aligned MGFX frame. At most four `Clip` transactions may be nested. An
active MGFX transform is rejected. `PushClip`/`PopClip` calls made by the content
must remain balanced.

`Clip` has no stencil or binary fallback. If the continuous coverage path is
unavailable it raises an error instead of silently changing edge quality.

## Mask invalidation and cache behavior

```lua
local notch = 0.25
local mask = MGFX.Mask(function(m, w, h)
    m:Draw(function()
        MGFX.RoundedBox(0, 0, w, h, 12, color_white)
    end)
    m:Subtract(function()
        MGFX.Circle(w * notch, 0, 10, color_white)
    end)
end)

notch = 0.4
mask:Invalidate()
```

`mask:Invalidate()` increments the custom Mask's content revision and returns
the same Mask object. Preset Masks are immutable and reject invalidation.

A custom raster can be reused only when its content revision, destination size,
effective target bucket, and fractional screen-pixel phase remain compatible.
Integer-pixel translation normally reuses coverage; subpixel translation may
rerasterize to preserve antialiased edge sampling. A Clip snapshots the Mask
state when it begins, so invalidation during nested drawing affects a later
Clip, not the active transaction.

## Preset Masks

Presets implement the same Mask protocol but stay analytical: they do not run a
painter or allocate custom coverage RTs.

### Circle and capsule

```lua
MGFX.Clip(MGFX.Masks.Circle, x, y, w, h, callback)
MGFX.Clip(MGFX.Masks.Capsule, x, y, w, h, callback)
```

`Circle` is an inscribed circle centered in the destination bounds. A `300 x
100` destination therefore produces a 100-pixel-diameter circle, not an
ellipse. `Capsule` fills the destination bounds with an end radius equal to half
the shorter side.

### Rounded

```lua
MGFX.Masks.Rounded({radius = 12, units = "local"})
MGFX.Masks.Rounded({radius = 0.12, units = "bounds"})
MGFX.Masks.Rounded(12) -- shorthand for local radius = 12
```

| Option | Default | Meaning |
| --- | --- | --- |
| `radius` | `0` | Scalar corner radius. |
| `units` | `"local"` | `"local"` uses UI units; `"bounds"` multiplies by `min(w, h)`. |

The resolved radius is clamped to half the shorter side.

### Chamfer

```lua
MGFX.Masks.Chamfer({
    cuts = {tl = 16, tr = 4, br = 16, bl = 4},
    units = "local",
})
```

`cuts` accepts one number, `{tl, tr, br, bl}`, or an array in that order.
`units = "bounds"` multiplies every cut by the shorter side. Resolved cuts are
non-negative and clamped to the shorter side.

## Shape self-clipping

The four container shapes accept an optional final `children` callback:

```lua
MGFX.RoundedBoxEx(x, y, w, h, style, function(cx, cy, cw, ch)
    MGFX.ImageEx(cx, cy, cw, ch, material, {fit = "cover"})
end)
```

Self-clipping reuses the shape's own analytical boundary. You do not create or
repeat a Mask. Rendering order is:

1. shape fill, pattern, backdrop, shadow, and glow layers;
2. `children` through the shape boundary;
3. the shape stroke as a foreground layer.

This order keeps children from covering the inner half of a centered stroke.
The shape call returns its normal draw result; child return values are not used.

### Signatures and child bounds

| Shape | Signature | Values passed to `children` |
| --- | --- | --- |
| Rounded box | `RoundedBoxEx(x, y, w, h, style, children)` | `x, y, w, h` |
| Circle | `CircleEx(cx, cy, radius, style, children)` | bounding square `cx - radius, cy - radius, radius * 2, radius * 2` |
| Capsule | `CapsuleEx(x, y, w, h, style, children)` | `x, y, w, h` |
| Chamfer box | `ChamferBoxEx(x, y, w, h, style, children)` | `x, y, w, h` |

```lua
MGFX.CircleEx(cx, cy, radius, {
    fill = Color(8, 18, 24),
    stroke = Color(120, 220, 170),
    strokeWidth = 2,
}, function(x, y, sizeW, sizeH)
    MGFX.ImageEx(x, y, sizeW, sizeH, avatar, {fit = "cover"})
end)
```

Self-clipping requires a function callback, positive finite bounds no larger
than the framebuffer, and no active or style-level MGFX transform.
`RoundedBoxEx` currently requires a scalar `style.radius` for self-clipping;
per-corner radius tables remain valid for ordinary drawing but are rejected in
this container form. `ChamferBoxEx` accepts its normal scalar, array, or named
`style.cuts` values.

## Rendering cost and state contract

Each `Clip` performs two framebuffer copies and one bounded composite draw.
Analytical presets add no custom coverage rasterization. On a custom Mask cache
miss, Boolean coverage is composed into bucketed local accumulator/scratch RTs;
the accumulator itself becomes the cached texture.

Each reached nesting depth retains two full-frame snapshot RTs. Custom Masks
also retain two local coverage RTs for every size bucket encountered at that
depth. Use one `Clip` around related content rather than many tiny Clips.

MGFX protects its own render-target, camera, matrix, scissor, blend,
alpha-write, modulation, and surface-alpha changes. GMod exposes no getter for
an existing `OverrideBlend` or `OverrideAlphaWriteEnable` descriptor, so do not
enter `Clip` while caller code owns either override scope.

[Back to API Reference](./index)
