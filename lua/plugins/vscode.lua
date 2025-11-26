local is_vscode = vim.g.vscode == 1

return {
  -- ========== 在 VS Code 中禁用的插件 ==========
  {
    "folke/which-key.nvim",
    enabled = not is_vscode,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = not is_vscode,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = not is_vscode,
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = not is_vscode,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = not is_vscode,
  },
  {
    "rcarriga/nvim-notify",
    enabled = not is_vscode,
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = not is_vscode,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = not is_vscode,
  },
  {
    "L3MON4D3/LuaSnip",
    enabled = not is_vscode,
  },
  {
    "windwp/nvim-autopairs",
    enabled = not is_vscode,
  },
  {
    "numToStr/Comment.nvim",
    enabled = not is_vscode,
  },

  -- ========== VS Code 专用插件和优化 ==========
  {
    "vscode-neovim/vscode-neovim",
    cond = is_vscode,
    config = function()
      -- VS Code 集成优化配置
      vim.g.vscode_extension_path = vim.fn.stdpath("data") .. "/vscode"

      -- 禁用一些原生功能以提升性能
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.writebackup = false
    end,
  },

  -- ========== 在 VS Code 中有用的插件 ==========
  {
    "nvim-lualine/lualine.nvim",
    enabled = not is_vscode, -- 在 VS Code 中通常不需要状态栏
  },

  -- ========== 调试和开发辅助 ==========
  {
    "mfussenegger/nvim-dap",
    enabled = not is_vscode, -- 使用 VS Code 的调试功能
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = not is_vscode,
  },

  -- ========== 主题和外观 ==========
  {
    "folke/tokyonight.nvim",
    enabled = not is_vscode, -- 使用 VS Code 的主题
  },
  {
    "catppuccin/nvim",
    enabled = not is_vscode,
  },
}
