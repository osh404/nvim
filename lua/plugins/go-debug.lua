-- ~/.config/nvim/lua/plugins/go-debug.lua
return {
  -- ========== 必需依赖 ==========
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },

  -- ========== DAP 核心 ==========
  -- 调试器：delve
  -- nvim-dap: 用于连接调试器
  {
    "mfussenegger/nvim-dap",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")

      -- Go 调试适配器
      dap.adapters.go = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      -- Go 调试配置
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug with args",
          request = "launch",
          program = "${file}",
          args = function()
            local args_string = vim.fn.input("Program arguments: ")
            return vim.split(args_string, " +")
          end,
        },
        {
          type = "go",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
        {
          type = "go",
          name = "Debug package",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
    end,
  },

  -- ========== Go 专用调试插件 ==========
  {
    "leoluz/nvim-dap-go",
    ft = { "go", "gomod" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dap-go").setup({
        -- 外部工具配置
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          args = {},
        },
      })
    end,
  },

  -- ========== DAP 调试界面 ==========
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
        },
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "↶",
            run_last = "↻",
            terminate = "⏹",
          },
        },
      })

      -- 自动打开/关闭 DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- ========== 调试虚拟文本 ==========
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
      })
    end,
  },
}
