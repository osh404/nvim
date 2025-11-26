-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  -- VSCode 环境下配置
  require("config.vscode").setup()
  -- 禁用一些在 VS Code 中不需要的插件
  vim.g.lazyvim_plugins = {
    -- 在这里列出要禁用的插件
  }
else
  -- LazyVim 配置
  require("config.lazy")
end
