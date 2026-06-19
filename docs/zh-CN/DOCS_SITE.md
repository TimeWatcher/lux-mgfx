# MGFX 文档站

MGFX 文档站使用 VitePress。Markdown 源文件保存在 `docs/`，站点配置在 `docs/.vitepress/`，构建产物输出到 `docs-site/`。

## 命令

安装依赖：

```powershell
npm install
```

启动本地开发服务：

```powershell
npm run docs:dev
```

构建静态站点：

```powershell
npm run docs:build
```

预览构建产物：

```powershell
npm run docs:preview
```

## 源文件结构

```text
docs/
  index.md
  API.md
  API_REFERENCE.md        旧详细 API URL 的兼容入口
  api-reference/
    index.md
    frame.md
    primitives.md
    images.md
    widgets.md
    text-api.md
    paint.md
  TEXT.md
  PERFORMANCE.md
  ARCHITECTURE.md
  SHADERS.md
  BATCHING.md
  BATCH_COVERAGE.md
  DOCS_SITE.md
  .vitepress/
    config.mjs
    theme/

docs-site/
  generated static output
```

不要手动编辑 `docs-site/` 中的生成文件。修改 Markdown 或 VitePress 配置后重新构建。

`api-reference/` 来自旧文档站的 `api-reference.js` 结构化数据，并按 API family 拆分。public signature 改动时，必须同时更新概念性的 `API.md` 和对应的详细分组页。`API_REFERENCE.md` 只保留为旧 URL 的兼容入口。

详细 API 页由脚本生成：

```powershell
node .\scripts\generate-api-reference.cjs
```

生成器会读取 `.tmp-old-docs/api-reference.js`；如果本地没有该文件，会从旧 Cloudflare 部署拉取结构化数据。不要手动批量改 `docs/api-reference/*.md` 的表格格式，否则下次生成会覆盖。

## 部署

Cloudflare Pages project:

```text
mgfx-docs
```

部署生成的静态产物：

```powershell
npx wrangler pages deploy docs-site --project-name mgfx-docs
```

如果 Wrangler 要求选择账号，之前的部署缓存使用：

```text
ae643569b59080c5ae1bcc21bb30685e
```

## 打包边界

共享文档和 npm 站点文件放在仓库根目录，不属于 `lua-mgfx` addon。`lua-mgfx/addon.json` 只忽略 addon 内的 shader source、SDK tools、README 等非运行时文件。
