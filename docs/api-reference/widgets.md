# HUD Meters and Sectors

These immediate draw helpers cover common HUD meters and radial shapes. They do not store state; pass the current value every frame.

## Functions

```lua
MGFX.ProgressBarEx(x, y, w, h, value, style)
MGFX.SegmentBarEx(x, y, w, h, value, style)
MGFX.RingEx(cx, cy, radius, width, style)
MGFX.ArcEx(cx, cy, radius, width, startDeg, endDeg, style)
MGFX.SectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, style)
```

## Progress Bars

```lua
MGFX.ProgressBarEx(x, y, w, h, value, {
    radius = h * 0.5,
    track = Color(10, 18, 24, 190),
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(80, 170, 255), Color(90, 220, 180)),
    padding = 2,
})
```

`value` is normally `0..1`. Clamp before drawing if your gameplay value can overshoot.

## Segment Bars

```lua
MGFX.SegmentBarEx(x, y, w, h, value, {
    segments = 12,
    gap = 2,
    track = Color(10, 18, 24, 190),
    fill = Color(80, 190, 255),
})
```

Use segment bars for discrete ammo, charges, cooldown ticks, or armor cells.

## Rings and Arcs

```lua
MGFX.RingEx(cx, cy, 42, 7, {
    value = 0.72,
    fill = MGFX.RingAngularGradient({
        {0, Color(80, 170, 255)},
        {1, Color(255, 210, 90)},
    }),
})

MGFX.ArcEx(cx, cy, 48, 8, -90, 190, {
    fill = Color(80, 190, 255),
})
```

Use `RingEx` for closed circular meters and `ArcEx` for partial meters.

Compatible ring `shadow` and `outerGlow` layers may share one fused shader pass. `shadow` remains a projected offset effect; `outerGlow` remains an exterior glow.

## Sectors

```lua
MGFX.SectorEx(cx, cy, innerR, outerR, startDeg, endDeg, {
    fill = MGFX.SectorAngularGradient({
        {0, Color(35, 212, 232, 170)},
        {1, Color(245, 158, 11, 135)},
    }),
    stroke = Color(255, 255, 255, 34),
    strokeWidth = 1,
})
```

Sectors are for radial menu wedges or wheel selections. Use real radii and angles rather than approximating with polygons.

[Back to API Reference](./index)
