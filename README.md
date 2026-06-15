# Lux MGFX

Lux MGFX is the standalone package set and shader tooling for the Lux UI and
drawing stack.

It is not a submodule of `lux`. It lives as a peer repository and is consumed
through `luxc install` or by adding this repository as a package source.

## Install

Install from GitHub:

```powershell
luxc install @lux/mgfx --from github:TimeWatcher/lux-mgfx --tag v0.1.0
```

Install from a local checkout:

```powershell
luxc install @lux/mgfx --from C:\Development\gmod\lux-mgfx
```

`luxc install` writes the project dependency entry and lockfile. MGFX package
dependencies are resolved from this package set automatically; users should not
list every `@lux/mgfx/*` module by hand.

After installing, import MGFX from Lux code:

```lux
import { installGlobal } from "@lux/mgfx"

client {
  installGlobal("MGFX")
}
```

## What it contains

- `@lux/mgfx`
- `@lux/mgfx/capabilities`
- `@lux/mgfx/commands`
- `@lux/mgfx/console`
- `@lux/mgfx/demo`
- `@lux/mgfx/frame`
- `@lux/mgfx/geometry`
- `@lux/mgfx/materials`
- `@lux/mgfx/paint`
- `@lux/mgfx/primitives`
- `@lux/mgfx/profiler`
- `@lux/mgfx/roundrect`
- `@lux/mgfx/shaderpack`
- `@lux/mgfx/style`
- `@lux/mgfx/text`
- `@lux/mgfx/widgets`
- `@lux/mgfx/wheel_demo`

`@lux/mgfx` is the normal entry point. The subpackages remain importable for
advanced users that want a narrower dependency surface.

## Shader tooling

MGFX ships precompiled Source shader bytecode (`.vcs`) in the package tree.
Garry's Mod does not include a shader compiler, so the compiler binary used to
regenerate that bytecode is stored as repository tooling under `tools/mgfx`.

The shader tooling is intentionally outside the Lux package module tree. It is
not installed as a Lux package and it is not emitted into generated Lua unless
MGFX code explicitly embeds a packed shader module.

Useful maintenance commands:

```powershell
cd lux\mgfx\shadersrc
python .\build.py --pack-only
python .\build.py
```

`--pack-only` rebuilds the base64 shaderpack Lua from existing `.vcs` files.
Running without `--pack-only` invokes the bundled shader build chain first.

## License

MGFX is licensed for non-commercial use under `LICENSE-MGFX-NC`.
Commercial use requires separate written authorization.

## Related projects

- Lux compiler and language: https://github.com/TimeWatcher/lux
- Lux built-in packages: https://github.com/TimeWatcher/lux-packages
- Lux documentation: https://timewatcher.github.io/lux-docs-site/
