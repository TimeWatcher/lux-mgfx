# Text Rendering

MGFX text has two routes:

```text
plain text without shader effects  -> native GMod text
text with shader effects           -> MGFX text composer
```

This keeps normal UI text cheap while allowing high-quality display text when it matters.

## Native Route

Use native text for:

- player names
- scoreboard rows
- chat and log lines
- small labels
- fast-changing counters
- table-like UI

Native text is predictable and cheap. It should be the default for operational UI.

## Composer Route

MGFX uses the composer when a text style requires shader-side work:

- gradient face
- soft stroke or outline
- glow
- shader shadow
- surface polish
- weight adjustment

```lua
MGFX.TextEx("READY", "DermaLarge", x, y, {
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(80, 180, 255), Color(255, 210, 90)),
    glow = {color = Color(80, 180, 255, 110), blur = 10},
    shadow = {x = 0, y = 2, blur = 4, color = Color(0, 0, 0, 150)},
})
```

## Prewarming

`PrewarmText` is only useful for composer text. Do not prewarm ordinary labels.

Good candidates:

- fixed HUD headings
- known menu titles
- stable status labels
- predictable numeric ranges

Avoid prewarming:

- player-generated strings
- long logs
- frequently changing table rows
- one-off temporary messages

## Text Boxes

Use `TextBoxEx` when MGFX should measure and wrap the text for you. Use native GMod drawing when your UI already owns layout and wrapping.

## Practical Guidance

- Keep small CJK labels on native text unless they need explicit effects.
- Keep `letterSpacing` at `0` for most CJK text.
- Use low surface polish values for small labels.
- Use shader text sparingly on high-frequency HUD elements.
