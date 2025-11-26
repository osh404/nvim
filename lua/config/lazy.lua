local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    -- { import = "plugins" },
    -- { import = "plugins/alpha" }, -- 报错，首页
    { import = "plugins/dracula" }, -- 德古拉主题
    -- { import = "plugins/gruvbox" }, -- gruvbox主题
    { import = "plugins/trouble" }, -- 诊断和错误列表插件
    { import = "plugins/nvim-cmp" }, -- 自动补全，集成 LSP、缓冲区、文件路径、片段等多种补全源
    { import = "plugins/telescope" }, -- 搜索插件
    { import = "plugins/mason" }, -- 语言管理
    { import = "plugins/lsp" }, -- LSP语言客户端
    { import = "plugins/go-debug" }, -- debug 调试
    -- { import = "plugins/go-debug2" }, -- debug 调试
    { import = "plugins/treesitter" }, -- 语法高亮
    { import = "plugins/lualine" }, -- 底部状态栏
    { import = "plugins/go-vim" }, -- Go 语言开发插件（go-vim、cmp、lsp要一起配合着使用）
    { import = "plugins/im-select" }, -- 退出Insert模式时候自动切换英文输入法
    { import = "plugins/vscode" }, -- vscode 相关插件
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "dracula", "tokyonight", "habamax", "gruvbox" } },
  checker = {
    enabled = false, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
