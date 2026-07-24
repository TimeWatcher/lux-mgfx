# Coverage Masks and Antialiased Clip

MGFX has two separate masking concepts:

- `ImageEx` accepts an image-mask style record such as `{kind = "circle"}`. It affects that image draw only.
- `MGFX.Mask(painter)` creates reusable coverage for `MGFX.Clip`. It can clip any mixture of shapes, images, text, and native drawing inside one callback.

Keeping these concepts separate is intentional: a coverage Mask describes geometry, while `Clip` decides where and when that geometry is applied.

This page teaches the model and common recipes. For every public signature,
return value, preset option, restriction, and self-clipping callback rule, use
the [complete Mask and Clip API reference](../api-reference/masks-and-clip).

## Create coverage

```lua
local badgeMask = MGFX.Mask(function(m, w, h)
    m:Draw(function()
        MGFX.Circle(w / 2, h / 2, math.min(w, h) * 0.48, color_white)
    end)

    m:Subtract(function()
        MGFX.Circle(w * 0.69, h * 0.31, math.min(w, h) * 0.18, color_white)
    end)
end)
```

The painter receives a restricted coverage recorder. Only MGFX drawing APIs are supported inside its operation callbacks. They are interpreted as alpha coverage: RGB is ignored, ordinary color blending does not choose the geometry operation, and unsupported bleed effects raise an error. Do not mutate render targets, camera/model matrices, scissor, or blend overrides directly from a painter.

The initial coverage is zero. For old coverage `A` and one callback result `B`, the operations are:

| Method | Coverage result |
| --- | --- |
| `m:Draw(callback)` / `m:Union(callback)` | `max(A, B)` |
| `m:Subtract(callback)` | `A * (1 - B)` |
| `m:Intersect(callback)` | `A * B` |
| `m:Xor(callback)` | `A + B - 2AB` |
| `m:Invert()` | `1 - A` inside the current Clip bounds |

`Draw` is simply the convenient name for `Union`; because the initial coverage is zero, the first draw naturally initializes the Mask.

## Apply a Mask

```lua
MGFX.Clip(badgeMask, x, y, 120, 72, function()
    MGFX.Image(x - 16, y, 152, 72, material)
    MGFX.Text("READY", "DermaLarge", x + 60, y + 36,
        color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

-- Equivalent object form:
badgeMask:Clip(x, y, 120, 72, drawContents)
```

The painter uses local coordinates `[0, w] x [0, h]`; the content callback keeps the normal current-frame coordinates. A Mask has no public pixel size. MGFX rasterizes custom coverage at the effective device extent and preserves transparent padding plus a right/bottom guard texel for antialiasing, so a full-screen custom Mask is valid.

The raster cache key includes the Mask content revision, destination size, framebuffer/device size, and fractional screen-pixel phase. Whole-pixel translation reuses the same raster; subpixel translation may not. MGFX transforms are rejected because the current backend supports axis-aligned frame mapping only. Caller-owned `cam.PushModelMatrix` state is not observable and is likewise outside the Clip contract.

If values captured by the painter change, call `mask:Invalidate()` before the next use. A Clip takes a snapshot of the Mask state when it begins, so changes during nested drawing affect a later Clip, not the active one. `MGFX.Clip` and `mask:Clip` forward the callback's exact return count and values.

## Presets

```lua
MGFX.Masks.Circle
MGFX.Masks.Capsule
MGFX.Masks.Rounded({radius = 12, units = "local"})
MGFX.Masks.Rounded({radius = 0.12, units = "bounds"})
MGFX.Masks.Chamfer({cuts = {tl = 12, tr = 2, br = 12, bl = 2}, units = "local"})
```

`Circle` uses an inscribed circle in the destination bounds; it does not stretch into an ellipse. `Capsule` follows the destination aspect ratio. `local` units are Clip-local UI units, while `bounds` units are multiplied by the shorter side.

## Clip to the shape itself

The common container case does not need a second Mask definition. Four shape APIs accept an optional final child callback and reuse their own analytical boundary:

```lua
MGFX.RoundedBoxEx(x, y, w, h, style, children)
MGFX.CircleEx(cx, cy, radius, style, children)
MGFX.CapsuleEx(x, y, w, h, style, children)
MGFX.ChamferBoxEx(x, y, w, h, style, children)
```

```lua
MGFX.RoundedBoxEx(x, y, w, h, {
    radius = 18,
    fill = Color(8, 18, 24, 230),
    stroke = Color(100, 220, 170, 180),
    strokeWidth = 2,
}, function(childX, childY, childW, childH)
    MGFX.ImageEx(childX, childY, childW, childH, material, {fit = "cover"})
end)
```

Rounded, capsule, and chamfer callbacks receive `x, y, w, h`. A circle callback receives its bounding square: `cx - radius, cy - radius, radius * 2, radius * 2`. The callback keeps normal frame coordinates; it does not switch to `(0, 0)` like a custom Mask painter.

The container order is background/effects, clipped children, then foreground stroke, so children cannot cover the inner half of a centered border. The complete request is validated before anything draws. Self-clipping rejects active or style-level transforms, non-positive dimensions, dimensions larger than the framebuffer, and per-corner radius tables on `RoundedBoxEx`; ordinary non-container drawing still supports those radius tables.

See [Coverage Masks, Clip, and Self-Clipping](../api-reference/masks-and-clip) for every signature, callback coordinate rule, preset option, recorder method, and cache constraint.

## Rendering and cost

Clip is callback-only so MGFX can always close the render-target transaction, even when the callback fails. It does not use stencil. Each active Clip captures the framebuffer before and after its body, then composites those snapshots with continuous shader coverage. The coarse rectangular scissor limits work but never defines the visible edge.

One Clip performs two framebuffer copies plus one bounded composite draw. Custom Mask coverage is rasterized only on a cache miss; analytical presets do not need a coverage RT. A cache miss composes directly into a bucketed local accumulator/scratch pair and retains the accumulator as the cached texture, so it neither clears a full-frame coverage target nor copies an accumulator into a separate mask RT. Nesting is capped at four levels; `BeginCommands` and nested Clip scopes inside a Mask painter are rejected.

Each reached depth keeps two full-frame `BGRA8888` snapshot RTs: about 15.82 MiB at 1920x1080 or 63.28 MiB at 3840x2160. Custom Masks additionally allocate two local `BGRA8888` coverage RTs per encountered size bucket at that depth. Buckets start at 32 pixels, grow by powers of two, and are capped just beyond the framebuffer extent; their memory and clear/combine bandwidth therefore scale with the Mask bounds instead of the full screen.

All MGFX-owned render-target, 2D camera, matrix, scissor, blend, alpha-write, modulation, blend-factor, and surface-alpha changes use protected cleanup paths. GMod does not expose getters for existing `OverrideBlend` or `OverrideAlphaWriteEnable` descriptors, so `Clip` must not be entered inside a caller-owned override scope; MGFX cannot reconstruct state the engine does not expose.

The Clip installer is idempotent for an unchanged runtime. A partial hot reload that replaces wrapped draw/frame functions is rejected before allocating new RTs; perform a full client Lua refresh instead of stacking another wrapper generation and leaking another RT namespace.

For one image, prefer `ImageEx(..., {mask = {kind = "circle"}})`. Use `MGFX.Mask` and `MGFX.Clip` when multiple draws must share one antialiased boundary.
