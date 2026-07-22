import { defineConfig } from "vitepress";

const headingRegex = /<h([1-6])[^>]*>(.*?<a.*? href="#.*?".*?>.*?<\/a>)<\/h\1>/gi;
const headingContentRegex = /(.*?)<a.*? href="#(.*?)".*?>.*?<\/a>/i;
const hiddenSearchSections = new Set([
  "Scope",
  "On This Page",
  "Function Reference",
  "Reading Order",
  "Groups",
  "适用边界",
  "本页 API",
  "函数参考",
  "阅读顺序",
  "分组说明",
]);

function clearHtmlTags(value) {
  return String(value || "")
    .replace(/<script\b[^>]*>[\s\S]*?<\/script>/gi, " ")
    .replace(/<style\b[^>]*>[\s\S]*?<\/style>/gi, " ")
    .replace(/<[^>]*>/g, " ")
    .replace(/&nbsp;/g, " ")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&amp;/g, "&")
    .replace(/&quot;/g, "\"")
    .replace(/&#39;/g, "'")
    .replace(/\s+/g, " ")
    .trim();
}

function splitSearchSections(_file, html) {
  const matches = [];
  for (const match of html.matchAll(headingRegex)) {
    const parsed = headingContentRegex.exec(match[2]);
    const title = clearHtmlTags(parsed?.[1] || "");
    const anchor = parsed?.[2] || "";
    if (!title) continue;
    matches.push({
      level: Number(match[1]),
      title,
      anchor,
      start: match.index,
      end: match.index + match[0].length,
    });
  }

  const sections = [];
  let pageTitle = "";
  let current = null;

  function flush() {
    if (!current || current.skip) return;
    const text = clearHtmlTags(current.text);
    if (!text && current.titles.length <= 1) return;
    sections.push({
      anchor: current.anchor,
      titles: current.titles,
      text,
    });
  }

  for (let i = 0; i < matches.length; i++) {
    const heading = matches[i];
    const next = matches[i + 1];
    const content = html.slice(heading.end, next ? next.start : html.length);

    if (heading.level === 1) {
      flush();
      pageTitle = heading.title;
      current = {
        anchor: heading.anchor,
        titles: [heading.title],
        text: content,
        skip: false,
      };
      continue;
    }

    if (heading.level === 2) {
      flush();
      current = {
        anchor: heading.anchor,
        titles: pageTitle ? [pageTitle, heading.title] : [heading.title],
        text: content,
        skip: hiddenSearchSections.has(heading.title),
      };
      continue;
    }

    if (current && !current.skip) {
      current.text += ` ${heading.title} ${content}`;
    }
  }

  flush();
  return sections;
}

const searchOptions = {
  detailedView: false,
  disableQueryPersistence: true,
  miniSearch: {
    searchOptions: {
      prefix: true,
      fuzzy: 0.15,
      boost: {
        title: 8,
        titles: 4,
        text: 1,
      },
    },
    _splitIntoSections: splitSearchSections,
  },
};

const englishSidebar = [
  {
    text: "User Guide",
    items: [
      { text: "Overview", link: "/" },
      { text: "Plain GLua Quick Start", link: "/guide/glua" },
      { text: "Lux Quick Start", link: "/guide/lux" },
      { text: "Core Concepts", link: "/guide/concepts" },
      { text: "Effects", link: "/guide/effects" },
      {
        text: "API Reference",
        collapsed: false,
        items: [
          { text: "Reference Home", link: "/api-reference/" },
          { text: "Frame and Debug", link: "/api-reference/frame" },
          { text: "Primitives", link: "/api-reference/primitives" },
          { text: "Images and Masks", link: "/api-reference/images" },
          { text: "Widgets", link: "/api-reference/widgets" },
          { text: "Text API", link: "/api-reference/text-api" },
          { text: "Paint, Patterns, Transforms", link: "/api-reference/paint" },
        ],
      },
      { text: "Text Rendering", link: "/TEXT" },
      { text: "Performance", link: "/PERFORMANCE" },
    ],
  },
  {
    text: "Maintainers",
    items: [
      { text: "Architecture", link: "/ARCHITECTURE" },
      { text: "Shaders and Packaging", link: "/SHADERS" },
      { text: "Docs Site", link: "/DOCS_SITE" },
    ],
  },
  {
    text: "Historical Notes",
    collapsed: true,
    items: [
      { text: "Removed Batching Design", link: "/BATCHING" },
      { text: "Removed Batching Coverage", link: "/BATCH_COVERAGE" },
    ],
  },
];

const chineseSidebar = [
  {
    text: "使用文档",
    items: [
      { text: "总览", link: "/zh-CN/" },
      { text: "普通 GLua 快速开始", link: "/zh-CN/guide/glua" },
      { text: "Lux 快速开始", link: "/zh-CN/guide/lux" },
      { text: "核心概念", link: "/zh-CN/guide/concepts" },
      { text: "特效指南", link: "/zh-CN/guide/effects" },
      {
        text: "详细 API",
        collapsed: false,
        items: [
          { text: "分组入口", link: "/zh-CN/api-reference/" },
          { text: "帧作用域与调试", link: "/zh-CN/api-reference/frame" },
          { text: "基础图元", link: "/zh-CN/api-reference/primitives" },
          { text: "图像与遮罩", link: "/zh-CN/api-reference/images" },
          { text: "组件图元", link: "/zh-CN/api-reference/widgets" },
          { text: "文本 API", link: "/zh-CN/api-reference/text-api" },
          { text: "绘制、图案、变换与能力", link: "/zh-CN/api-reference/paint" },
        ],
      },
      { text: "文字渲染", link: "/zh-CN/TEXT" },
      { text: "性能", link: "/zh-CN/PERFORMANCE" },
    ],
  },
  {
    text: "维护文档",
    items: [
      { text: "内部架构", link: "/zh-CN/ARCHITECTURE" },
      { text: "Shader 与打包", link: "/zh-CN/SHADERS" },
      { text: "文档站维护", link: "/zh-CN/DOCS_SITE" },
    ],
  },
  {
    text: "历史记录",
    collapsed: true,
    items: [
      { text: "已移除的批处理设计", link: "/zh-CN/BATCHING" },
      { text: "已移除的批处理覆盖面", link: "/zh-CN/BATCH_COVERAGE" },
    ],
  },
];

export default defineConfig({
  title: "MGFX",
  description: "Shader-backed immediate UI rendering for Garry's Mod",
  lang: "en-US",
  cleanUrls: true,
  outDir: "../docs-site",
  lastUpdated: true,
  markdown: {
    languageAlias: {
      lux: "lua",
    },
    theme: {
      light: "github-light",
      dark: "github-dark",
    },
  },
  ignoreDeadLinks: [
    /^https?:\/\//,
  ],
  head: [
    ["meta", { name: "theme-color", content: "#ffffff" }],
    ["link", { rel: "icon", type: "image/svg+xml", href: "/favicon.svg" }],
  ],
  themeConfig: {
    siteTitle: "MGFX",
    search: {
      provider: "local",
      options: searchOptions,
    },
    nav: [
      {
        text: "Get Started",
        items: [
          { text: "Plain GLua", link: "/guide/glua" },
          { text: "Lux", link: "/guide/lux" },
          { text: "Core Concepts", link: "/guide/concepts" },
          { text: "Effects", link: "/guide/effects" },
        ],
      },
      { text: "API Reference", link: "/api-reference/" },
      { text: "Performance", link: "/PERFORMANCE" },
      { text: "Shaders", link: "/SHADERS" },
    ],
    sidebar: englishSidebar,
    outline: {
      level: [2, 3],
      label: "On This Page",
    },
    docFooter: {
      prev: "Previous",
      next: "Next",
    },
    lastUpdated: {
      text: "Last updated",
      formatOptions: {
        dateStyle: "medium",
        timeStyle: "short",
      },
    },
    socialLinks: [],
  },
  locales: {
    root: {
      label: "English",
      lang: "en-US",
    },
    "zh-CN": {
      label: "简体中文",
      lang: "zh-CN",
      link: "/zh-CN/",
      title: "MGFX",
      description: "MGFX 中文文档",
      themeConfig: {
        search: {
          provider: "local",
          options: {
            ...searchOptions,
            translations: {
              button: {
                buttonText: "搜索",
                buttonAriaLabel: "搜索文档",
              },
              modal: {
                displayDetails: "显示详细结果",
                resetButtonTitle: "清空搜索",
                backButtonTitle: "关闭搜索",
                noResultsText: "没有找到",
                footer: {
                  selectText: "选择",
                  selectKeyAriaLabel: "回车",
                  navigateText: "切换",
                  navigateUpKeyAriaLabel: "向上箭头",
                  navigateDownKeyAriaLabel: "向下箭头",
                  closeText: "关闭",
                  closeKeyAriaLabel: "Esc",
                },
              },
            },
          },
        },
        nav: [
          {
            text: "开始使用",
            items: [
              { text: "普通 GLua", link: "/zh-CN/guide/glua" },
              { text: "Lux", link: "/zh-CN/guide/lux" },
              { text: "核心概念", link: "/zh-CN/guide/concepts" },
              { text: "特效指南", link: "/zh-CN/guide/effects" },
            ],
          },
          { text: "详细 API", link: "/zh-CN/api-reference/" },
          { text: "性能", link: "/zh-CN/PERFORMANCE" },
          { text: "Shader 与打包", link: "/zh-CN/SHADERS" },
        ],
        sidebar: chineseSidebar,
        outline: {
          level: [2, 3],
          label: "本页目录",
        },
        docFooter: {
          prev: "上一页",
          next: "下一页",
        },
        lastUpdated: {
          text: "最后更新",
          formatOptions: {
            dateStyle: "medium",
            timeStyle: "short",
          },
        },
      },
    },
  },
  vite: {
    build: {
      emptyOutDir: true,
    },
  },
});
