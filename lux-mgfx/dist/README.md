# MGFX Legacy Precompiled Loader

`dist/lua` is the legacy Lux-generated Garry's Mod loader build. It is kept for
comparison and maintainer workflows while the repository moves non-Lux users to
the sibling `../lua-mgfx` pure Lua addon source.

For new plain GLua integrations, use `../lua-mgfx` instead of this generated
tree. The generated autorun file here loads MGFX on the client and calls
`installGlobal("MGFX")`, so ordinary GLua can still call `MGFX.RoundedBox`,
`MGFX.TextEx`, and the rest of the public facade if this tree is copied.

Regenerate this tree from the Lux sources with:

```powershell
.\tools\build-precompiled.ps1
```

Pass `-Luxc C:\path\to\luxc.exe` when `luxc` is not on `PATH`.
