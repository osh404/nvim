-- return {
--   "nvim-lualine/lualine.nvim",
--   event = "VeryLazy",
--   -- vscode = true,
--   opts = function()
--     return {
--       --[[add your custom lualine config here]]
--     }
--   end,
-- }
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
  config = function()
    require("lualine").setup({
      -- options = { theme = "catppuccin" } -- catppuccin主题
      options = { theme = "dracula" }, -- 德古拉主题
    })
  end,
}
