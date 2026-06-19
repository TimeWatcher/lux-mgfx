# Docs Site

The MGFX docs site uses VitePress. Markdown source lives in `docs/`; generated output is written to `docs-site/` and is ignored by Git.

## Languages

The default route is English:

```text
docs/index.md
docs/API.md
docs/api-reference/*.md
```

The Chinese mirror lives under:

```text
docs/zh-CN/
docs/zh-CN/api-reference/
```

Keep public-facing English docs current first. Update the Chinese mirror when the same behavior needs localized documentation.

## Commands

```powershell
npm run docs:dev
npm run docs:build
npm run docs:preview
```

Do not edit `docs-site/` manually. Rebuild from `docs/`.

## Structure

```text
docs/
  index.md
  API.md
  API_REFERENCE.md
  api-reference/
  zh-CN/
  .vitepress/
    config.mjs
    theme/
```

## Maintenance Rules

- API changes update `API.md` and the matching `api-reference/` page.
- Shader or shaderpack changes update `SHADERS.md`.
- Runtime performance changes update `PERFORMANCE.md`.
- Architecture or ownership changes update `ARCHITECTURE.md`.
- Keep the language switch working when adding pages.
