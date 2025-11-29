-- 复用 opt 参数
local opt = { noremap = true, silent = true }
-----------------------------------------------------------------------------
-- Insert 模式下移动、删除
-----------------------------------------------------------------------------
vim.keymap.set("i", "<C-a>", "<ESC>I", opt) -- 移动到行首
vim.keymap.set("i", "<C-e>", "<ESC>A", opt) -- 移动到行尾
vim.keymap.set("i", "<C-n>", "<Down>", opt) -- 移动到下一行
vim.keymap.set("i", "<C-p>", "<Up>", opt)   -- 移动到上一行
-- vim.keymap.set("i", "<C-b>", "<Left>", opt)  -- 左移
-- vim.keymap.set("i", "<C-f>", "<Right>", opt) -- 右移
-- 修改成延迟执行，避免键位冲突
vim.defer_fn(function()
  local opt = { noremap = true, silent = true }
  vim.keymap.set("i", "<C-b>", "<Left>", opt)
  vim.keymap.set("i", "<C-f>", "<Right>", opt)
end, 100) -- 延迟 100 毫秒执行


-- <C-h> 删除光标后的字符 自带了
vim.keymap.set("i", "<C-d>", "<Del>", opt)    -- 删除光标后字符
-- vim.keymap.set("i", "<C-k>", "<Esc>d$i", opt) -- 无效，删除到行尾
vim.keymap.set("i", "<C-u>", "<Esc>d0i", opt) -- 删除到行首

vim.keymap.set("i", "<C-z>", "<Esc>ui", opt)  -- 撤销
-----------------------------------------------------------------------------
--- go 语言相关---
-----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>cI", ":GoImports<CR>", { desc = "整理imports" })
vim.keymap.set("n", "<leader>ci", ":GoImpl<CR>", { desc = "实现接口" })
vim.keymap.set("n", "<leader>cx", "<cmd>GoFix<cr>", { desc = "快速修复" })
vim.keymap.set("n", "<leader>ce", ":GoIfErr<CR>", { desc = "生成err结构" })

-----------------------------------------------------------------------------
--- debug 相关
-----------------------------------------------------------------------------
local map = vim.keymap.set
-- -- 调试基础功能
-- map("n", "<leader>db", function()
--   require("dap").toggle_breakpoint()
-- end, { desc = "Toggle Breakpoint" })
-- map("n", "<leader>dB", function()
--   require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
-- end, { desc = "Breakpoint Condition" })
-- map("n", "<leader>dc", function()
--   require("dap").continue()
-- end, { desc = "Continue" })
-- map("n", "<leader>di", function()
--   require("dap").step_into()
-- end, { desc = "Step Into" })
-- map("n", "<leader>do", function()
--   require("dap").step_over()
-- end, { desc = "Step Over" })
-- map("n", "<leader>dO", function()
--   require("dap").step_out()
-- end, { desc = "Step Out" })
-- map("n", "<leader>dr", function()
--   require("dap").restart()
-- end, { desc = "Restart" })
-- map("n", "<leader>dt", function()
--   require("dap").terminate()
-- end, { desc = "Terminate" })
-- map("n", "<leader>dp", function()
--   require("dap").pause()
-- end, { desc = "Pause" })
--
-- -- 调试界面控制
-- map("n", "<leader>du", function()
--   require("dapui").toggle()
-- end, { desc = "Toggle DAP UI" })
-- map("n", "<leader>de", function()
--   require("dapui").eval()
-- end, { desc = "Evaluate" })
-- map("v", "<leader>de", function()
--   require("dapui").eval()
-- end, { desc = "Evaluate" })
--
-- -- 断点管理
-- map("n", "<leader>dl", function()
--   require("dap").list_breakpoints()
-- end, { desc = "List Breakpoints" })
-- map("n", "<leader>dC", function()
--   require("dap").clear_breakpoints()
-- end, { desc = "Clear Breakpoints" })
--
-- -- Go 专用调试命令
-- map("n", "<leader>dgt", function()
--   require("dap-go").debug_test()
-- end, { desc = "Debug Go Test" })
-- map("n", "<leader>dgl", function()
--   require("dap-go").debug_last_test()
-- end, { desc = "Debug Last Go Test" })
--
-- -- 变量查看
-- map("n", "<leader>dw", function()
--   local widgets = require("dap.ui.widgets")
--   widgets.centered_float(widgets.scopes)
-- end, { desc = "Scopes Widget" })
--
-- map("n", "<leader>dh", function()
--   local widgets = require("dap.ui.widgets")
--   widgets.hover()
-- end, { desc = "Hover Variables" })
--
-- -- 重绘界面
-- map("n", "<leader>dR", function()
--   require("dapui").float_element("repl")
-- end, { desc = "REPL Float" })
-----------------------------------------------------------------------------
-- ========== 基础调试控制 ==========
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Debug: Start/Continue" })

map("n", "<leader>dv", function()
  require("dap").step_over()
end, { desc = "Debug: Step over" })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Debug: Step into" })

map("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "Debug: Step out" })

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle breakpoint" })

map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Conditional breakpoint" })

map("n", "<leader>dl", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point: "))
end, { desc = "Debug: Log point" })

map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Debug: Open REPL" })

map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Debug: Terminate" })

-- ========== 调试界面控制 ==========
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Debug: Toggle UI" })

map("n", "<leader>de", function()
  require("dapui").eval()
end, { desc = "Debug: Evaluate expression" })

-- ========== Go 专用调试 ==========
map("n", "<leader>dgt", function()
  if vim.bo.filetype == "go" then
    require("dap-go").debug_test()
  end
end, { desc = "Go: Debug test" })

map("n", "<leader>dgl", function()
  if vim.bo.filetype == "go" then
    require("dap-go").debug_last()
  end
end, { desc = "Go: Debug last test" })

-- ========== 断点管理 ==========
map("n", "<leader>dC", function()
  require("dap").clear_breakpoints()
end, { desc = "Debug: Clear all breakpoints" })

map("n", "<leader>dL", function()
  require("dap").list_breakpoints()
end, { desc = "Debug: List breakpoints" })
-- 变量查看
map("n", "<leader>dw", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "Scopes Widget" })

map("n", "<leader>dh", function()
  local widgets = require("dap.ui.widgets")
  widgets.hover()
end, { desc = "Hover Variables" })
