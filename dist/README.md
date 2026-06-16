# MGFX Precompiled Loader

`dist/lua` is the precompiled Garry's Mod loader build for users who do not use
Lux.

Copy the contents of `dist/lua` into your addon's or gamemode's `lua`
directory. The generated autorun file loads MGFX on the client and calls
`installGlobal("MGFX")`, so ordinary GLua can call `MGFX.RoundedBox`,
`MGFX.TextEx`, and the rest of the public facade.

Regenerate this tree from the Lux sources with:

```powershell
.\tools\build-precompiled.ps1
```

Pass `-Luxc C:\path\to\luxc.exe` when `luxc` is not on `PATH`.
