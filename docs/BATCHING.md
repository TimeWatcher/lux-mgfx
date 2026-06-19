# Removed Shape Batching Design

This document is historical. The runtime batching prototype was removed.

MGFX now favors focused immediate shader paths and simple fallbacks. The old scheduler tried to classify many calls, build runs, upload data textures, and flush around barriers. In real GMod UI this added Lua-side work and complexity without providing a reliable win.

## Why It Was Removed

- Complex UIs mix many primitive families.
- Text, clip, images, masks, and transforms introduce frequent barriers.
- Data-texture batching required many shader variants.
- The scheduler performed substantial work even when it rejected a run.
- Debugging order and fallback behavior became harder.

## Current Rule

Do not reintroduce a general shape batching scheduler. Add focused immediate shader/fallback paths only when the call site and performance benefit are clear.

## Still Useful Lessons

- Avoid per-call allocation.
- Keep parameter upload compact.
- Keep patterns in shaders.
- Keep text routing separate.
- Keep fallback behavior obvious.
