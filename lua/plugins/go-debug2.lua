-- ~/.config/nvim/lua/plugins/go-debug.lua
return {
  -- ========== 必需依赖 ==========
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },

  -- ========== DAP 核心 ==========
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
    },
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
          name = "Debug Current File",
          request = "launch",
          program = "${file}",
          console = "integratedTerminal",
        },
        {
          type = "go",
          name = "Debug with Args",
          request = "launch",
          program = "${file}",
          args = function()
            local input = vim.fn.input("Program arguments: ")
            return vim.split(input, " ")
          end,
          console = "integratedTerminal",
        },
        {
          type = "go",
          name = "Debug Test",
          request = "launch",
          mode = "test",
          program = "${file}",
          console = "integratedTerminal",
        },
        {
          type = "go",
          name = "Debug Package Tests",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
          console = "integratedTerminal",
        },
        {
          type = "go",
          name = "Attach to Process",
          request = "attach",
          processId = require("dap.utils").pick_process,
          console = "integratedTerminal",
        },
      }

      -- 自定义符号
      vim.fn.sign_define("DapBreakpoint", {
        text = "🔴",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "➡️",
        texthl = "DapStopped",
        linehl = "DapStoppedLine",
        numhl = "DapStoppedNumber",
      })
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
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          args = {},
          build_flags = "",
        },
      })

      -- 自动安装 delve 如果未找到
      vim.defer_fn(function()
        local mason_registry = require("mason-registry")
        if not vim.fn.executable("dlv") and not mason_registry.is_installed("delve") then
          vim.notify("Installing delve via Mason...")
          vim.cmd("MasonInstall delve")
        end
      end, 1000)
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
        icons = {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "▸",
        },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        expand_lines = true,
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.35 },
              { id = "breakpoints", size = 0.15 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 50,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
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
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value
          else
            return variable.name .. " = " .. variable.value
          end
        end,
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })
    end,
  },
}
