local is_vscode = vim.g.vscode == 1

return {
  -- ========== VS Code 中启用的插件 ==========
  {
    "vscode-neovim/vscode-neovim",
    cond = is_vscode,
    config = function()
      -- VS Code 集成优化配置
      -- vim.g.vscode_extension_path = vim.fn.stdpath("data") .. "/vscode"

      -- 禁用一些原生功能以提升性能
      -- vim.opt.swapfile = false
      -- vim.opt.backup = false
      -- vim.opt.writebackup = false
    end,
  },
  -- 移动跳转插件(在vscode中启用)
  {
    "folke/flash.nvim",
    version = "*", -- 使用最新 commit
    -- enabled = not is_vscode, -- 在 VS Code 中通常不需要状态栏
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      -- jump = {
      --   pos = "start",
      -- },
      -- search = {
      --   mode = "search",
      -- },
      -- label = {
      --   format = function(opts)
      --     -- 确保 count 是数字，默认 0
      --     return tostring(opts.count or 0)
      --     -- return string.format("%d", opts.count)
      --   end,
      -- },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash: Jump (forward)",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({ search = { backward = true } })
        end,
        desc = "Flash: Jump (backward)",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash in Command-line",
      },
    },
  },

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
