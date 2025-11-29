-- lua/plugins/dracula.lua
return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- 这里可以传递主题特定的选项
    -- 查看插件文档了解可用选项
  },
  -- config = function(_, opts)
  --   vim.opt.termguicolors = true
  --   vim.cmd.colorscheme("dracula")
  --   -- 可选：如果你喜欢 soft 版本
  --   -- vim.cmd.colorscheme("dracula-soft")
  -- end,
}
