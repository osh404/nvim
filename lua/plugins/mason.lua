return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "delve", -- Go 调试器
      "gopls", -- Go 语言服务器
      "gofumpt", -- 代码格式化
      "goimports", -- 导入管理
      "gomodifytags", -- 结构体标签
      "impl", -- 接口实现
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
    },
  },
}
