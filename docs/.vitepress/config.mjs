import { defineConfig } from "vitepress";

const headingRegex = /<h([1-6])[^>]*>(.*?<a.*? href="#.*?".*?>.*?<\/a>)<\/h\1>/gi;
const headingContentRegex = /(.*?)<a.*? href="#(.*?)".*?>.*?<\/a>/i;
const hiddenSearchSections = new Set([
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

export default defineConfig({
  title: "MGFX",
  description: "MGFX 中文文档",
  lang: "zh-CN",
  cleanUrls: true,
  outDir: "../docs-site",
  lastUpdated: true,
  markdown: {
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
      options: {
        detailedView: false,
        disableQueryPersistence: true,
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
      },
    },
    nav: [
      { text: "指南", link: "/" },
      { text: "API 总览", link: "/API" },
      { text: "详细 API", link: "/api-reference/" },
      { text: "性能", link: "/PERFORMANCE" },
      { text: "Shader 与打包", link: "/SHADERS" },
    ],
    sidebar: [
      {
        text: "使用文档",
        items: [
          { text: "总览", link: "/" },
          { text: "API 总览", link: "/API" },
          {
            text: "详细 API",
            collapsed: false,
            items: [
              { text: "分组入口", link: "/api-reference/" },
              { text: "帧作用域与调试", link: "/api-reference/frame" },
              { text: "基础图元", link: "/api-reference/primitives" },
              { text: "图像与遮罩", link: "/api-reference/images" },
              { text: "组件图元", link: "/api-reference/widgets" },
              { text: "文本 API", link: "/api-reference/text-api" },
              { text: "绘制、图案、变换与能力", link: "/api-reference/paint" },
            ],
          },
          { text: "文字渲染", link: "/TEXT" },
          { text: "性能", link: "/PERFORMANCE" },
        ],
      },
      {
        text: "维护文档",
        items: [
          { text: "内部架构", link: "/ARCHITECTURE" },
          { text: "Shader 与打包", link: "/SHADERS" },
          { text: "文档站维护", link: "/DOCS_SITE" },
        ],
      },
      {
        text: "历史记录",
        collapsed: true,
        items: [
          { text: "已移除的批处理设计", link: "/BATCHING" },
          { text: "已移除的批处理覆盖面", link: "/BATCH_COVERAGE" },
        ],
      },
    ],
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
    socialLinks: [],
  },
  vite: {
    build: {
      emptyOutDir: true,
    },
  },
});
