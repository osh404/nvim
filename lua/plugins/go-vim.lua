-- ~/.config/nvim/lua/plugins/vim-go.lua
return {
  {
    "fatih/vim-go",
    ft = { "go", "gomod" },
    build = ":GoInstallBinaries", -- 自动安装 Go 工具
    init = function()
      -- 禁用 vim-go 的默认键位映射，使用自定义
      vim.g.go_doc_keywordprg_enabled = 0
      vim.g.go_def_mapping_enabled = 0
      vim.g.go_code_completion_enabled = 0
    end,
    config = function()
      -- vim-go 配置
      vim.g.go_fmt_command = "gofumpt" -- 使用 gofumpt 格式化
      vim.g.go_fmt_fail_silently = 1 -- 格式化失败不报错
      vim.g.go_fmt_autosave = 1 -- 自动保存时格式化
      vim.g.go_imports_autosave = 1 -- 自动保存时组织导入
      vim.g.go_mod_fmt_autosave = 1 -- 自动格式化 go.mod
      -- 语法高亮
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_generate_tags = 1
      -- 诊断和检查
      vim.g.go_diagnostics_enabled = 1
      vim.g.go_metalinter_enabled = { "golint", "vet" }
      vim.g.go_metalinter_autosave_enabled = { "golint", "vet" }
      -- 其他配置
      vim.g.go_auto_type_info = 1 -- 自动类型信息
      vim.g.go_def_mode = "gopls" -- 使用 gopls 跳转定义
      vim.g.go_info_mode = "gopls" -- 使用 gopls 信息
      vim.g.go_jump_to_error = 0 -- 不自动跳转到错误
      -- 设置快捷键
      -- require("config.vim-go-keymaps").setup()
    end,
  },
}
