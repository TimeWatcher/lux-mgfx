---
layout: home

hero:
  name: "MGFX"
  text: "Modern GMod FX"
  tagline: "A shader-backed immediate renderer for Garry's Mod UI. MGFX keeps the direct drawing model you already know, while adding anti-aliased shapes, gradients, masks, glow, backdrop blur, rings, sectors, images, and optional shader text effects."
  actions:
    - theme: brand
      text: Read the API
      link: /API
    - theme: alt
      text: Plain GLua Usage
      link: /API#plain-glua-usage
    - theme: alt
      text: 中文文档
      link: /zh-CN/

features:
  - title: Immediate first
    details: Shapes and widgets use direct shader/fallback paths. There is no heavy general-purpose batch scheduler between your HUD code and the renderer.
  - title: Shape-aware effects
    details: Rounded boxes, chamfer boxes, circles, capsules, rings, arcs, sectors, convex polygons, and image masks clip glow and backdrop effects to their own coverage.
  - title: Real paint records
    details: Linear, radial, conic, ring/sector radial, angular gradients, stripe patterns, and smoke patterns are paint slots instead of hand-expanded geometry.
  - title: Lux and plain GLua
    details: Lux projects import @lux/mgfx. Non-Lux projects can load the bundled runtime and call MGFX.* directly.
---

## Quick Start

```lua
function PANEL:Paint(w, h)
    MGFX.StartPanel(self, w, h)

    MGFX.RoundedBoxEx(0, 0, w, h, {
        radius = 10,
        fill = Color(8, 14, 20, 170),
        backdrop = {
            blur = 8,
            tint = Color(0, 8, 12, 120),
        },
        outerGlow = {
            color = Color(70, 205, 255, 64),
            width = 12,
            softness = 0.58,
        },
    })

    MGFX.ProgressBarEx(24, 84, w - 48, 10, 0.72, {
        radius = 5,
        track = Color(10, 18, 24, 190),
        fill = MGFX.LinearGradient(0, 0, 1, 0, {
            {0.00, Color(30, 130, 255, 230)},
            {0.55, Color(60, 200, 255, 230)},
            {1.00, Color(255, 210, 110, 230)},
        }),
    })

    MGFX.EndPanel()
end
```

## Documentation

<div class="mgfx-capability-grid">
  <a href="./API">
    <span>API</span>
    <strong>Overview</strong>
    <small>Frame scope, primitives, images, widgets, text, paint records, transforms, and capability queries.</small>
  </a>
  <a href="./api-reference/">
    <span>Reference</span>
    <strong>API Reference</strong>
    <small>Function signatures, style fields, return values, examples, and caveats grouped by API family.</small>
  </a>
  <a href="./PERFORMANCE">
    <span>Runtime</span>
    <strong>Performance Model</strong>
    <small>Immediate paths, matrix parameter upload, shader/fallback routing, and allocation rules.</small>
  </a>
  <a href="./SHADERS">
    <span>Shaders</span>
    <strong>Build and Packaging</strong>
    <small>Shaderpack generation, parameter layout, gradient LUTs, GMA mounting, and Source engine limits.</small>
  </a>
</div>

## Scope

MGFX is a renderer, not a UI framework. It does not own layout, input, focus, component lifecycle, transition state, or hit testing. Callers compute the current visual state every frame and pass explicit draw arguments to `MGFX.*`.

Text is also not forced through MGFX. Plain labels should use native GMod text. Use `MGFX.TextEx` only when you need shader text effects such as gradient faces, glow, stroke, or high-quality shadow.

## Maintenance Rules

- Public API changes must update [API Overview](./API) and the matching [API Reference group](./api-reference/).
- Shader parameter layout, gradient LUT, alpha, or shaderpack changes must update [Shaders and Packaging](./SHADERS).
- Runtime performance changes must update [Performance Model](./PERFORMANCE).
- Do not edit `docs-site/` by hand. Update `docs/` and rebuild the site.

## Example: Wheel Sector

```lua
local fill = MGFX.SectorAngularGradient({
    {0.00, Color(35, 212, 232, 170)},
    {0.52, Color(80, 220, 160, 150)},
    {1.00, Color(245, 158, 11, 135)},
})

MGFX.SectorEx(cx, cy, innerR, outerR, startDeg, endDeg, {
    fill = fill,
    stroke = Color(255, 255, 255, 34),
    strokeWidth = 1,
    backdrop = {blur = 7, tint = Color(4, 10, 14, 120)},
    innerGlow = {color = Color(255, 96, 78, 90), width = 28},
    transform = MGFX.PointerTilt(mx, my, {
        perspective = 900,
        maxRotateX = 4,
        maxRotateY = 6,
    }),
})
```
