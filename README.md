# MGFX

**Source-available, shader-backed immediate rendering for Garry's Mod UI.**

![MGFX overview](lux-mgfx/images/hero.png)

This repository now carries two maintained MGFX implementations:

- `lua-mgfx/` is the plain GLua addon. This is the source to copy or package for non-Lux Garry's Mod projects.
- `lux-mgfx/` is the Lux package project. It contains the Lux source tree, shader tooling, and the legacy generated loader output.

MGFX is a renderer, not a UI framework. It provides immediate draw calls for rounded shapes, chamfers, polygons, rings, progress widgets, images, text effects, gradients, masks, glow layers, backdrop effects, and shader-backed polish. Layout, input, focus, animation state, and panel lifecycle stay in caller code.

## Install

For a plain Lua addon, use `lua-mgfx/` as the addon root:

```text
garrysmod/addons/mgfx/
  lua/
  materials/
  resource/
  addon.json
```

Garry's Mod loads the autorun files automatically and exposes `MGFX.*` on the client.

For a Lux project, install the package set from the repository root:

```powershell
luxc install @lux/mgfx --from github:TimeWatcher/lux-mgfx --tag v0.1.0
```

Local checkout:

```powershell
luxc install @lux/mgfx --from C:\Development\gmod\lux-mgfx
```

The root `lux.package.toml` points to `lux-mgfx/lux/mgfx`, so existing Lux install commands can keep using the repository root.

## Effects

`shadow`, `outerGlow`, and `backdrop` are separate effects:

- `shadow` is an external soft pass for shader-backed shapes. It supports `x/y`, `offsetX/offsetY`, `dx/dy`, `offset = {x, y}`, `blur`, `spread`, `opacity`, `softness`, and color/tint. Convex poly still uses its silhouette fallback.
- `outerGlow` is an external glow pass. It supports the same offset aliases, but defaults to no offset.
- `backdrop` samples and tints the background inside the current shape or image mask. It is not a shadow.

`innerGlow` remains clipped inside the shape and does not use offset.

## Layout

```text
lua-mgfx/       Plain GLua addon source and docs
lux-mgfx/       Lux package source, shader tools, and legacy generated dist
lux.package.toml
README.md
LICENSE*
NOTICE
```

`lux-mgfx/dist/lua` is the old Lux-generated GLua loader tree. The canonical non-Lux implementation is `lua-mgfx/`; future release packaging should prefer that pure Lua tree.

## License

MGFX source is available under the Lux MGFX Non-Commercial License. Commercial use requires separate written authorization. See `LICENSE`, `LICENSE-MGFX-NC`, and `NOTICE`.
