const fs = require("fs");
const https = require("https");
const path = require("path");
const vm = require("vm");

const root = path.resolve(__dirname, "..");
const localSource = path.join(root, ".tmp-old-docs", "api-reference.js");
const sourceUrl = "https://2cbdcb54.mgfx-docs.pages.dev/assets/api-reference.js";
const outDir = path.join(root, "docs", "api-reference");

const groups = {
  frame: {
    file: "frame.md",
    title: "帧作用域与调试",
    label: "帧作用域",
    badge: "Frame",
    summary: "管理 MGFX 绘制帧、矩形裁剪和调试叠层。所有坐标都相对于当前 active frame。",
    when: [
      "在 `PANEL:Paint` 里使用 `StartPanel` / `EndPanel`。",
      "在 `HUDPaint` 或屏幕空间 overlay 里使用 `StartScreen` / `EndScreen`。",
      "`PushClip` / `PopClip` 只做矩形 scissor，不是任意形状 mask。",
    ],
  },
  primitives: {
    file: "primitives.md",
    title: "基础图元",
    label: "图元",
    badge: "Shape",
    summary: "Rounded、Chamfer、Poly、Line、Circle、Capsule 以及通用 shape style 能力。",
    when: [
      "简单热路径优先用短签名，复杂视觉用 `NameEx(..., style)`。",
      "高级效果放在 `style` 里：`fill`、`stroke`、`innerGlow`、`outerGlow`、`backdrop`、`pattern`、`transform`。",
      "`Poly` / `PolyEx` 的 public contract 是凸多边形，复杂路径应先拆成凸片段。",
    ],
  },
  images: {
    file: "images.md",
    title: "图像与遮罩",
    label: "图像",
    badge: "Image",
    summary: "图像、图标、fit/crop/uv、shape mask、texture mask 和 image-specific glow/backdrop。",
    when: [
      "普通图像用 `Image`，需要遮罩、布局或特效时用 `ImageEx`。",
      "圆形头像、切角头像和纹理遮罩都通过 `style.mask = MGFX.Mask(...)` 表达。",
      "任意形状 backdrop 应挂在当前 shape/image 的 `style.backdrop` 上，而不是画独立 blur primitive。",
    ],
  },
  widgets: {
    file: "widgets.md",
    title: "组件图元",
    label: "组件",
    badge: "Widget",
    summary: "ProgressBar、SegmentBar、Ring、Arc、Sector 这些 renderer-level widget。",
    when: [
      "`RingEx(cx, cy, radius, width, style)` 和 `ArcEx(cx, cy, radius, width, startDeg, endDeg, style)` 把宽度放在几何参数里。",
      "`SectorEx(cx, cy, innerRadius, outerRadius, startDeg, endDeg, style)` 是真正扇区，不是圆弧加宽。",
      "周向渐变使用 shape-local angular gradient，不要把它和全局 conic gradient 混为一谈。",
    ],
  },
  text: {
    file: "text-api.md",
    title: "文本 API",
    label: "文本",
    badge: "Text",
    summary: "字体别名、文本样式、测量、预热、原生文本路径和 shader text effects。",
    when: [
      "普通 label、scoreboard、表格、日志和聊天优先用原生 GMod text。",
      "只有需要渐变字面、描边、glow、shadow、surface polish 等 shader 特效时才进入 MGFX text composer。",
      "稳定的特效文本可以用 `PrewarmText` 提前烘焙。",
    ],
  },
  paint: {
    file: "paint.md",
    title: "绘制记录、图案、变换与能力",
    label: "Paint / Pattern / Transform / 能力",
    badge: "Paint",
    summary: "Color/gradient paint record、程序化 pattern、2.5D transform helper 和 capability query。",
    when: [
      "Linear、Radial、Conic、Ring/Sector radial、Shape/Ring/Arc/Sector angular 都支持 stop 表，并统一走 LUT。",
      "Pattern 应作为 paint slot 交给 shader 数学化处理，不要在调用层展开成大量线段。",
      "2.5D 视觉倾斜使用 `style.transform`、`PushTransform` 或 `PointerTilt`，不新增 `ProjectedXXX` 图元族。",
    ],
  },
};

function fetchText(url) {
  return new Promise((resolve, reject) => {
    https
      .get(url, (res) => {
        if (res.statusCode !== 200) {
          reject(new Error(`GET ${url} failed: ${res.statusCode}`));
          res.resume();
          return;
        }
        const chunks = [];
        res.on("data", (chunk) => chunks.push(chunk));
        res.on("end", () => resolve(Buffer.concat(chunks).toString("utf8")));
      })
      .on("error", reject);
  });
}

async function loadSource() {
  if (fs.existsSync(localSource)) {
    return fs.readFileSync(localSource, "utf8");
  }
  return await fetchText(sourceUrl);
}

function pick(value) {
  if (value == null) return "";
  if (typeof value === "string") return value;
  if (typeof value === "number" || typeof value === "boolean") return String(value);
  if (value.zh || value.en) return value.zh || value.en || "";
  if (value.text) return pick(value.text);
  if (value.code) return `\`${value.code}\``;
  return "";
}

function escapeTable(value) {
  return String(value)
    .replace(/\r?\n/g, "<br>")
    .replace(/\|/g, "\\|");
}

function renderInline(value) {
  if (value == null) return "";
  if (typeof value === "string") return value;
  if (typeof value === "number" || typeof value === "boolean") return String(value);
  if (value.zh || value.en) return pick(value);
  if (value.code != null) {
    const code = String(value.code).replace(/`/g, "\\`");
    const text = value.text ? pick(value.text) : "";
    return text ? `\`${code}\`<br>${text}` : `\`${code}\``;
  }
  if (value.text) return pick(value.text);
  return "";
}

function anchor(name) {
  return String(name)
    .trim()
    .toLowerCase()
    .replace(/\./g, "-")
    .replace(/[^\p{L}\p{N}\s_-]/gu, "")
    .replace(/\s+/g, "-");
}

function codeBlock(code) {
  return ["```lua", code.trimEnd(), "```", ""].join("\n");
}

function paramsTable(params) {
  if (!params || params.length === 0) return "";
  const lines = ["#### 参数", "", "| 参数 | 说明 |", "| --- | --- |"];
  for (const row of params) {
    lines.push(`| ${escapeTable(renderInline(row[0]))} | ${escapeTable(renderInline(row[1]))} |`);
  }
  lines.push("");
  return lines.join("\n");
}

function detailTable(table) {
  if (!table || !table.rows || table.rows.length === 0) return "";
  const columns = (table.columns || []).map((column) => pick(column));
  const width = Math.max(columns.length, ...table.rows.map((row) => row.length));
  while (columns.length < width) columns.push("字段");

  const lines = [`#### ${pick(table.title) || "详细用法"}`, ""];
  lines.push(`| ${columns.map(escapeTable).join(" | ")} |`);
  lines.push(`| ${columns.map(() => "---").join(" | ")} |`);
  for (const row of table.rows) {
    const cells = [];
    for (let i = 0; i < width; i++) cells.push(escapeTable(renderInline(row[i])));
    lines.push(`| ${cells.join(" | ")} |`);
  }
  lines.push("");
  return lines.join("\n");
}

function itemSection(item) {
  const lines = [`## ${item.name}`, "", codeBlock(item.signature), pick(item.summary), ""];
  const params = paramsTable(item.params);
  if (params) lines.push(params);

  if (item.notes && item.notes.length) {
    lines.push("#### 用法说明", "");
    for (const note of item.notes) lines.push(`- ${pick(note)}`);
    lines.push("");
  }

  if (item.returns) {
    lines.push("#### 返回值", "", pick(item.returns), "");
  }

  if (item.detailTables && item.detailTables.length) {
    for (const table of item.detailTables) lines.push(detailTable(table));
  }

  if (item.example) {
    lines.push("#### 示例", "", codeBlock(item.example));
  }
  return lines.join("\n").trimEnd() + "\n";
}

function groupPage(group) {
  const meta = groups[group.id];
  const lines = [
    `# ${meta.title}`,
    "",
    meta.summary,
    "",
    "## 适用边界",
    "",
  ];

  for (const line of meta.when) lines.push(`- ${line}`);
  lines.push("", "## 本页 API", "");
  for (const item of group.items) {
    lines.push(`- [${item.name}](#${anchor(item.name)}) - ${pick(item.summary)}`);
  }

  lines.push("", "## 函数参考", "");
  for (const item of group.items) lines.push(itemSection(item));
  lines.push("[返回详细 API 入口](./index)", "");
  return lines.join("\n");
}

function indexPage(data) {
  const lines = [
    "# 详细 API 参考",
    "",
    "这里是 MGFX public API 的逐函数参考。概念说明、推荐使用方式和整体设计边界请先看 [API 总览](../API.md)。",
    "",
    "API 名称、Lua 参数名和 shader 术语保留英文；解释性文本统一使用中文。",
    "",
    "## 分组入口",
    "",
    '<div class="mgfx-capability-grid">',
  ];

  for (const group of data.groups) {
    const meta = groups[group.id];
    lines.push(`  <a href="./${meta.file.replace(/\.md$/, "")}">`);
    lines.push(`    <span>${meta.badge}</span>`);
    lines.push(`    <strong>${meta.title}</strong>`);
    lines.push(`    <small>${meta.summary}</small>`);
    lines.push("  </a>");
  }

  lines.push("</div>", "", "## 阅读顺序", "");
  lines.push("- 新代码先看 [API 总览](../API.md)，确认 MGFX 的边界和通用 style 写法。");
  lines.push("- 查具体签名、字段、默认值和示例时，再进入对应分组页。");
  lines.push("- 改 public API 时，同步更新概念页和详细分组页；不要只改 demo 或注释。");
  lines.push("", "## 分组说明", "");
  for (const group of data.groups) {
    const meta = groups[group.id];
    lines.push(`- **${meta.title}**：${meta.summary}`);
  }
  lines.push("");
  return lines.join("\n");
}

async function main() {
  const source = await loadSource();
  const sandbox = { window: {} };
  vm.createContext(sandbox);
  vm.runInContext(source, sandbox, { filename: "api-reference.js" });
  const data = sandbox.window.MGFX_API_REFERENCE;
  if (!data || !Array.isArray(data.groups)) {
    throw new Error("MGFX_API_REFERENCE data not found");
  }

  fs.mkdirSync(outDir, { recursive: true });
  fs.writeFileSync(path.join(outDir, "index.md"), indexPage(data), "utf8");
  for (const group of data.groups) {
    const meta = groups[group.id];
    if (!meta) throw new Error(`Unknown API group: ${group.id}`);
    fs.writeFileSync(path.join(outDir, meta.file), groupPage(group), "utf8");
  }

  fs.writeFileSync(
    path.join(root, "docs", "API_REFERENCE.md"),
    [
      "# 详细 API 参考",
      "",
      "这个页面保留给旧链接使用。新的详细参考已经按功能拆分：",
      "",
      "- [分组入口](./api-reference/)",
      "- [帧作用域与调试](./api-reference/frame)",
      "- [基础图元](./api-reference/primitives)",
      "- [图像与遮罩](./api-reference/images)",
      "- [组件图元](./api-reference/widgets)",
      "- [文本 API](./api-reference/text-api)",
      "- [绘制记录、图案、变换与能力](./api-reference/paint)",
      "",
    ].join("\n"),
    "utf8",
  );
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
