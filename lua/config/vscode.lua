local M = {}

function M.setup()
  -- 检查是否在 VS Code 中运行
  if not vim.g.vscode then
    return
  end

  print("🚀 Loading VS Code Neovim configuration...")

  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- ========== 基本设置优化 ==========
  -- 设置 leader 键（默认是空格）
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  vim.opt.timeoutlen = 700 -- 更快的超时(效果：按下 <leader>后，系统等待 250ms 来判断是单个键还是组合键)
  vim.opt.updatetime = 100 -- 更快的更新(效果：CursorHold事件在光标保持静止一段时间后触发。updatetime设置就是这个"一段时间"的定义)
  vim.opt.clipboard = "unnamedplus" -- 系统剪贴板集成
  vim.opt.mouse = "a"

  -- 禁用一些在 VS Code 中不需要的 UI 元素
  -- vim.opt.showmode = false
  -- vim.opt.ruler = false
  -- vim.opt.laststatus = 0

  -- ========== 可视模式优化 ==========
  -- 缩进
  map("v", "<", "<gv", opts)
  map("v", ">", ">gv", opts)

  -- ========== Insert模式优化 ==========
  -- 移动删除
  -- <C-b> <C-f> <C-u> <C-k>

  -- ========== 文件和工作区操作 (spc f) ==========
  -- 最近使用文件
  map("n", "<leader>ff", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>", {
    desc = "Open files",
  })
  -- 在文件中搜索内容(也可以先选择内容在进行搜索)
  map("v", "<leader>fg", "<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>", {
    desc = "Find selected text in files",
  })
  -- 命令面板中搜索 (vscode=com+shift+p)
  map("n", "<leader>fc", "<cmd>call VSCodeNotify('workbench.action.showCommands')<cr>", {
    desc = "Fuzzy find commands",
  })
  -- 设置搜索
  map("n", "<leader>fC", "<cmd>call VSCodeNotify('workbench.action.openSettings')<cr>", {
    desc = "Fuzzy find settings",
  })

  -- ========== 缓冲区管理 (spc b) ==========
  map("n", "<leader>bb", "<cmd>call VSCodeNotify('workbench.action.showAllEditors')<cr>", { desc = "List buffers" })
  map("n", "<leader>bd", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>", { desc = "Close buffer" })
  map(
    "n",
    "<leader>bD",
    "<cmd>call VSCodeNotify('workbench.action.closeEditorsInGroup')<cr>",
    { desc = "Close all buffers" }
  )
  map("n", "<leader>bn", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>", { desc = "Next buffer" })
  map("n", "<leader>bp", "<cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>", { desc = "Previous buffer" })

  -- ========== 窗口管理 (spc w) ==========
  map("n", "<leader>ww", "<cmd>call VSCodeNotify('workbench.action.splitEditor')<cr>", { desc = "Split horizontal" })
  map(
    "n",
    "<leader>wv",
    "<cmd>call VSCodeNotify('workbench.action.splitEditorOrthogonal')<cr>",
    { desc = "Split vertical" }
  )
  map("n", "<leader>wc", "<cmd>call VSCodeNotify('workbench.action.closeEditor')<cr>", { desc = "Close split" })
  map(
    "n",
    "<leader>wo",
    "<cmd>call VSCodeNotify('workbench.action.joinAllGroups')<cr>",
    { desc = "Close other splits" }
  )
  map(
    "n",
    "<leader>w=",
    "<cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<cr>",
    { desc = "Balance windows" }
  )
  -- 窗口跳转
  map("n", "<C-h>", "<cmd>call VSCodeNotify('workbench.action.navigateLeft')<cr>", { desc = "Navigate left" })
  map("n", "<C-j>", "<cmd>call VSCodeNotify('workbench.action.navigateDown')<cr>", { desc = "Navigate down" })
  map("n", "<C-k>", "<cmd>call VSCodeNotify('workbench.action.navigateUp')<cr>", { desc = "Navigate up" })
  map("n", "<C-l>", "<cmd>call VSCodeNotify('workbench.action.navigateRight')<cr>", { desc = "Navigate right" })

  -- ========== 代码导航和理解 (spc c) ==========
  -- 代码导航
  -- 定义
  map("n", "gd", "<cmd>call VSCodeNotify('editor.action.revealDefinition')<cr>", { desc = "Go to definition" })
  -- 声明
  map("n", "gD", "<cmd>call VSCodeNotify('editor.action.revealDeclaration')<cr>", { desc = "Go to declaration" })
  -- map("n", "gD", function()
  --   vim.api.nvim_command("call VSCodeNotify('editor.action.revealDeclaration')")
  -- end, { desc = "Go to declaration" })
  -- 实现
  map("n", "gI", "<cmd>call VSCodeNotify('editor.action.goToImplementation')<cr>", { desc = "Go to implementation" })
  -- 引用
  map("n", "gr", "<cmd>call VSCodeNotify('editor.action.goToReferences')<cr>", { desc = "Find references" })
  map("n", "K", "<cmd>call VSCodeNotify('editor.action.showDefinitionPreviewHover')<cr>", { desc = "Hover" })
  map("n", "<leader>k", "<cmd>call VSCodeNotify('editor.action.showDefinitionPreviewHover')<cr>", { desc = "Hover" })
  -- 代码跳转
  -- <ctl-i> <ctl-o> <ctl - -> <ctl - shift->

  -- 修复和重构
  map("n", "<leader>ca", "<cmd>call VSCodeNotify('editor.action.quickFix')<cr>", { desc = "Code action" })
  map("n", "<leader>cr", "<cmd>call VSCodeNotify('editor.action.rename')<cr>", { desc = "Rename symbol" })
  map("n", "<leader>cf", "<cmd>call VSCodeNotify('editor.action.formatDocument')<cr>", { desc = "Format document" })

  -- 接口实现
  map("n", "<leader>ci", "<cmd>call VSCodeNotify('go.impl.cursor')<cr>", {
    desc = "Generate interface implementation",
  })

  -- 显示所有go命令操作
  map("n", "<leader>cg", "<cmd>call VSCodeNotify('go.show.commands')<cr>", { desc = "Format document" })
  -- 填充结构体json
  map("n", "<leader>ct", "<cmd>call VSCodeNotify('go.add.tags')<cr>", {
    desc = "Add struct tags",
  })

  -- ========== 调试功能 (spc d)==========
  map(
    "n",
    "<leader>db",
    "<cmd>call VSCodeNotify('editor.debug.action.toggleBreakpoint')<cr>",
    { desc = "Toggle breakpoint" }
  )
  map(
    "n",
    "<leader>dB",
    "<cmd>call VSCodeNotify('editor.debug.action.toggleConditionalBreakpoint')<cr>",
    { desc = "Toggle conditional breakpoint" }
  )
  map("n", "<leader>dc", "<cmd>call VSCodeNotify('workbench.action.debug.continue')<cr>", { desc = "Continue" })
  map("n", "<leader>dC", "<cmd>call VSCodeNotify('workbench.action.debug.run')<cr>", { desc = "Run" })
  map("n", "<leader>do", "<cmd>call VSCodeNotify('workbench.action.debug.stepOver')<cr>", { desc = "Step over" })
  map("n", "<leader>di", "<cmd>call VSCodeNotify('workbench.action.debug.stepInto')<cr>", { desc = "Step into" })
  map("n", "<leader>du", "<cmd>call VSCodeNotify('workbench.action.debug.stepOut')<cr>", { desc = "Step out" })
  map("n", "<leader>dr", "<cmd>call VSCodeNotify('workbench.action.debug.restart')<cr>", { desc = "Restart debug" })
  map("n", "<leader>dq", "<cmd>call VSCodeNotify('workbench.action.debug.stop')<cr>", { desc = "Stop debug" })

  -- ========== Git 版本控制 (spc g)==========
  map("n", "<leader>gg", "<cmd>call VSCodeNotify('workbench.view.scm')<cr>", { desc = "Git" })
  map("n", "<leader>gs", "<cmd>call VSCodeNotify('workbench.action.git.stage')<cr>", { desc = "Git stage" })
  map("n", "<leader>gu", "<cmd>call VSCodeNotify('workbench.action.git.unstage')<cr>", { desc = "Git unstage" })
  map("n", "<leader>gc", "<cmd>call VSCodeNotify('workbench.action.git.commit')<cr>", { desc = "Git commit" })
  map("n", "<leader>gp", "<cmd>call VSCodeNotify('workbench.action.git.push')<cr>", { desc = "Git push" })
  map("n", "<leader>gl", "<cmd>call VSCodeNotify('gitlens.showQuickRepoStatus')<cr>", { desc = "Git log" })
  map("n", "<leader>gb", "<cmd>call VSCodeNotify('gitlens.toggleFileBlame')<cr>", { desc = "Git blame" })
  map("n", "<leader>gd", "<cmd>call VSCodeNotify('workbench.action.git.openChange')<cr>", { desc = "Git diff" })

  -- ========== 工具类（spc t）==========
  map(
    "n",
    "<leader>tt",
    "<cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<cr>",
    { desc = "Toggle terminal" }
  )
  map("n", "<leader>tn", "<cmd>call VSCodeNotify('workbench.action.terminal.new')<cr>", { desc = "New terminal" })
  map("n", "<leader>tk", "<cmd>call VSCodeNotify('workbench.action.terminal.kill')<cr>", { desc = "Kill terminal" })
  -- 打开Claude code
  map("n", "<leader>tc", "<cmd>call VSCodeNotify('claude-vscode.editor.openLast')<cr>", { desc = "Clear terminal" })

  -- ========== 搜索 (spc s) ==========
  -- 当前文件下查找替换
  map("n", "<leader>sr", "<cmd>call VSCodeNotify('editor.action.startFindReplaceAction')<cr>", { desc = "Replace" })
  -- 全路径搜索并替换
  map("n", "<leader>sR", "<cmd>call VSCodeNotify('workbench.action.replaceInFiles')<cr>", {
    desc = "Find and replace in files by path",
  })
  -- 符号搜索 (函数、类等)
  map("n", "<leader>ss", "<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>", {
    desc = "Fuzzy find symbols",
  })
  -- 工作区符号搜索
  map("n", "<leader>sS", "<cmd>call VSCodeNotify('workbench.action.showAllSymbols')<cr>", {
    desc = "Fuzzy find symbols in workspace",
  })
  -- 工作区搜索内容/代码片段
  map("n", "<leader>sw", "<cmd>call VSCodeNotify('workbench.view.search')<cr>", {
    desc = "find word",
  })
  -- ========== 项目相关 （spc p）==========
  map(
    "n",
    "<leader>pp",
    "<cmd>call VSCodeNotify('workbench.action.openRecent')<cr>",
    { desc = "Search recent project" }
  )
  -- 在新窗口中打开项目
  map("n", "<leader>pn", "<cmd>call VSCodeNotify('workbench.action.newWindow')<cr>", {
    desc = "New project window",
  })

  -- ========== 视图和面板 ==========
  map("n", "<leader>e", "<cmd>call VSCodeNotify('workbench.view.explorer')<cr>", { desc = "Explorer" })
  -- 切换侧边栏显示/隐藏
  map("n", "<leader>ec", "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<cr>", {
    desc = "Toggle sidebar",
  })
  -- 打开输出面板
  map(
    "n",
    "<leader>vo",
    "<cmd>call VSCodeNotify('workbench.action.output.toggleOutput')<cr>",
    { desc = "Toggle output" }
  )
  -- 打开问题面板
  -- map("n", "<leader>vp", "<cmd>call VSCodeNotify('workbench.action.togglePanel')<cr>", { desc = "Toggle panel" })
  map("n", "<leader>vp", "<cmd>call VSCodeNotify('workbench.actions.view.problems')<cr>", { desc = "view problems" })

  --========== 沉浸模式 (spc z) ==========
  -- 切换沉浸模式（禅模式）
  map("n", "<leader>zz", "<cmd>call VSCodeNotify('workbench.action.toggleZenMode')<cr>", {
    desc = "Toggle Zen mode",
  })
  -- 隐藏最左侧状态栏
  map("n", "<leader>zl", "<cmd>call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<cr>", {
    desc = "toggleActivityBarVisibility",
  })

  -- 标签页切换
  map("n", "L", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>", {
    desc = "Next tab",
  })
  map("n", "H", "<cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>", {
    desc = "Previous tab",
  })
  -- 快速跳转到特定标签页（数字键 1-9）
  -- for i = 1, 9 do
  --   map("n", "<leader>t" .. i, function()
  --     vim.fn.VSCodeNotify("workbench.action.openEditorAtIndex" .. i)
  --   end, { desc = "Go to tab " .. i })
  -- end
  -- map("n", "<leader>tc", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>", {
  --   desc = "Close tab",
  -- })
  -- map("n", "<leader>to", "<cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<cr>", {
  --   desc = "Close other tabs",
  -- })
  -- map("n", "<leader>tC", "<cmd>call VSCodeNotify('workbench.action.closeAllEditors')<cr>", {
  --   desc = "Close all tabs",
  -- })

  --========== 退出相关（spc + q）==========
  -- 全屏切换
  map("n", "<leader>qm", "<cmd>call VSCodeNotify('workbench.action.toggleFullScreen')<cr>", {
    desc = "Toggle fullscreen",
  })
  -- 进入全屏
  map("n", "<leader>qM", "<cmd>call VSCodeNotify('workbench.action.toggleFullScreen')<cr>", {
    desc = "Enter fullscreen",
  })
  -- 退出全屏
  map("n", "<leader>qe", "<cmd>call VSCodeNotify('workbench.action.toggleFullScreen')<cr>", {
    desc = "Exit fullscreen",
  })
  -- 退出 VS Code（完全退出）
  map("n", "<leader>qq", "<cmd>call VSCodeNotify('workbench.action.quit')<cr>", {
    desc = "Quit VS Code",
  })

  -- ========== Markdown 查看和编辑 ==========
  -- 切换 Markdown 预览
  map("n", "<leader>mp", "<cmd>call VSCodeNotify('markdown.showPreview')<cr>", {
    desc = "Preview Markdown",
  })
  -- 在侧边打开预览
  map("n", "<leader>ms", "<cmd>call VSCodeNotify('markdown.showPreviewToSide')<cr>", {
    desc = "Preview Markdown to side",
  })
  -- 关闭预览
  map("n", "<leader>mc", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>", {
    desc = "Close Markdown preview",
  })
  -- 刷新预览
  map("n", "<leader>mr", "<cmd>call VSCodeNotify('markdown.preview.refresh')<cr>", {
    desc = "Refresh Markdown preview",
  })

  --=========== 其他命令=============
  -- 重新加载配置
  map("n", "<leader>rr", "<cmd>call VSCodeNotify('workbench.action.reloadWindow')<cr>", { desc = "Reload window" })
  -- 打开settings.json
  map(
    "n",
    "<leader>as",
    "<cmd>call VSCodeNotify('workbench.action.openSettingsJson')<cr>",
    { desc = "Open settings JSON" }
  )

  -- ========== 模式指示器 ==========
  -- 在状态栏显示当前模式
  -- local function update_mode_indicator()
  --   local mode = vim.fn.mode()
  --   local modes = {
  --     n = "NORMAL",
  --     i = "INSERT",
  --     v = "VISUAL",
  --     V = "V-LINE",
  --     ["\22"] = "V-BLOCK", -- 修正：使用正确的转义字符
  --     c = "COMMAND",
  --     t = "TERMINAL",
  --     r = "REPLACE",
  --     s = "SELECT",
  --   }
  --   vim.b.vscode_mode = modes[mode] or mode
  --
  --   -- 调试输出（可选）
  --   -- print("Mode changed to: " .. (modes[mode] or mode))
  -- end
  --
  -- -- 自动命令来更新模式指示器
  -- vim.api.nvim_create_autocmd("ModeChanged", {
  --   pattern = "*:*", -- 监听所有模式变化
  --   callback = update_mode_indicator,
  -- })
  --
  -- -- 初始更新
  -- update_mode_indicator()

  print("✅ VS Code keymaps and configuration loaded successfully!")
  print("📋 Available keymaps: <leader> + [key] for most operations")
end

return M
