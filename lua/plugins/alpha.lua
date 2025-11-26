-- ~/.config/nvim/lua/plugins/alpha.lua
return {
  -- ========== 禁用 LazyVim 默认的启动界面 ==========
  {
    "echasnovski/mini.starter",
    enabled = false,
  },

  -- ========== 配置 Alpha 启动界面 ==========
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    lazy = false, -- 重要：必须设置为非懒加载
    priority = 1000, -- 高优先级确保最先加载
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- ========== 自定义头部 ==========
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
        "                  🚀 LazyVim Edition                ",
        "                                                     ",
      }

      -- ========== 按钮配置 ==========
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New File", "<cmd>ene<CR>"),
        dashboard.button("f", "  Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", "  Live Grep", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("c", "  Configuration", "<cmd>e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("s", "  Restore Session", "<cmd>SessionRestore<CR>"),
        dashboard.button("l", "  Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("m", "  Mason", "<cmd>Mason<CR>"),
        dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
      }

      -- ========== 页脚配置 ==========
      dashboard.section.footer.val = function()
        local stats = require("lazy").stats()
        local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
        local plugins_text = "⚡ Loaded "
          .. stats.count
          .. " plugins in "
          .. string.format("%.3f", stats.startuptime)
          .. "ms"

        return {
          plugins_text,
          datetime,
          "https://github.com/LazyVim/starter",
        }
      end

      -- ========== 高亮配置 ==========
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- ========== 布局配置 ==========
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      -- ========== 选项配置 ==========
      dashboard.config.opts = {
        margin = 5,
        setup = function()
          vim.cmd([[
            autocmd AlphaReady if !filereadable(expand('%')) | set laststatus=0 | endif
            autocmd BufUnload <buffer> set laststatus=3
          ]])
        end,
      }

      -- 设置 Alpha
      alpha.setup(dashboard.config)

      -- 自动命令处理
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.opt.laststatus = 0
          vim.opt.showtabline = 0
          vim.opt.cmdheight = 1
        end,
      })

      vim.api.nvim_create_autocmd("BufUnload", {
        buffer = 0,
        callback = function()
          vim.opt.laststatus = 3
          vim.opt.showtabline = 2
          vim.opt.cmdheight = 0
        end,
      })
    end,
  },
}
