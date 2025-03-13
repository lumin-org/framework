import { defineConfig, type DefaultTheme } from "vitepress";
import { tabsMarkdownPlugin } from "vitepress-plugin-tabs";

export default defineConfig({
  head: [["link", { rel: "icon", href: "/framework/favicon.ico" }]],
  title: "Framework",
  base: "/framework/",
  titleTemplate: ":title - Lumin",
  description: "A feather light game framework for Luau",
  lastUpdated: true,
  lang: "en-us",
  markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin);
    },
  },
  themeConfig: {
    nav: nav(),
    sidebar: {
      "/guide/": { base: "/guide/", items: guide() },
      "/api/": { base: "/api/", items: reference() },
    },

    outline: [2, 3],
    search: { provider: "local" },
    editLink: {
      pattern: "https://github.com/lumin-org/framework/edit/main/docs/:path",
    },

    socialLinks: [
      { icon: "github", link: "https://github.com/lumin-org/framework" },
      { icon: "discord", link: "https://lumin-org.github.io/to/discord" },
      { icon: "bluesky", link: "https://lumin-org.github.io/to/bluesky" },
    ],
  },
});

function nav(): DefaultTheme.NavItem[] {
  return [
    { text: "Guide", link: "/guide/introduction" },
    { text: "API", link: "/api/" },
    { text: "Changelog", link: "/changelog" },
  ];
}

function guide(): DefaultTheme.SidebarItem[] {
  return [
    {
      text: "Getting Started",
      collapsed: false,
      items: [
        { text: "Introduction", link: "introduction" },
        { text: "Installation", link: "installation" },
      ],
    },
    {
      text: "Providers",
      collapsed: false,
      items: [
        { text: "Creating Providers", link: "creating-providers" },
        { text: "Dependencies", link: "dependencies" },
        { text: "Init & Start", link: "init-and-start" },
        { text: "Configurations", link: "provider-configurations" },
      ],
    },
    {
      text: "Hooks",
      collapsed: false,
      items: [
        { text: "Creating Hooks", link: "creating-hooks" },
        { text: "Unique Callbacks", link: "unique-callbacks" },
      ],
    },
    {
      text: "Starting",
      collapsed: false,
      items: [
        { text: "Adding Directories", link: "adding-dirs" },
        { text: "Starting Framework", link: "starting-framework" },
        { text: "Configurations", link: "start-configurations" },
      ],
    },
    {
      text: "Errors",
      collapsed: true,
      items: [
        { text: "Already Started", link: "errors#alreadystarted" },
        { text: "Provider Duplicate", link: "errors#providerduplicate" },
        { text: "Fatal Init", link: "errors#fatalinit" },
        { text: "Fatal Add Module", link: "errors#fataladdmodule" },
        { text: "Reserved Name", link: "errors#reservedname" },
        { text: "Invalid Type", link: "errors#invalidtype" },
      ],
    },
  ];
}

function reference(): DefaultTheme.SidebarItem[] {
  return [
    {
      items: [
        { text: "Framework", link: "/" },
        { text: "Hook", link: "hook" },
      ],
    },
  ];
}
