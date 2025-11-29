-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  -- VSCode 环境下配置
  require("config.vscode").setup()
  require("config.lazy")
else
  -- LazyVim 配置
  require("config.lazy")
  require("config.options")
  require("config.keymaps")
  --  主题应用
  vim.cmd.colorscheme("dracula") -- 应用主题
  -- vim.cmd.colorscheme("dracula-soft")
  -- vim.cmd.colorscheme("tokyonight-night") -- 应用主题
end
