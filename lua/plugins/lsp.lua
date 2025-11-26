return {
  "mason-org/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    -- 不再需要 nvim-lspconfig 作为主要依赖
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "gopls", "lua_ls" },
    })

    -- === 语言服务器配置函数 ===
    local function setup_lsp_server(server_name, config)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = config.filetypes or server_name,
        callback = function(args)
          local root_files = vim.fs.find(config.root_patterns or { ".git" }, { upward = true })
          if #root_files == 0 and not config.allow_single_file then
            return
          end

          local root_dir = root_files[1] and vim.fs.dirname(root_files[1]) or vim.fn.getcwd()

          vim.lsp.start(vim.tbl_extend("force", {
            name = server_name,
            root_dir = root_dir,
          }, config))
        end,
      })
    end

    -- === Lua LSP 配置 ===
    setup_lsp_server("lua_ls", {
      filetypes = { "lua" },
      root_patterns = { ".git", "init.lua" },
      cmd = { "lua-language-server" },
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = {
            globals = {
              "vim",
              "use",
              "describe",
              "it",
              "packer_plugins",
              "P",
              "R",
              "B",
            },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- === Go LSP 配置 ===
    setup_lsp_server("gopls", {
      filetypes = { "go", "gomod" },
      root_patterns = { "go.mod", ".git" },
      cmd = { "gopls", "serve" },
      settings = {
        gopls = {
          analyses = {
            unusedparams = false, -- 启用未使用参数检查
            unusedvariable = false, -- 启用未使用变量检查
            shadow = true, -- 启用变量遮蔽检查
            fieldalignment = false, -- 禁用字段对齐（性能考虑）
            nilness = true, -- 启用 nil 检查
            unusedwrite = true, -- 启用未使用写入检查
          },
          hints = {
            assignVariableTypes = false, -- 禁用变量类型提示
            compositeLiteralFields = false, -- 启用结构体字段提示
            compositeLiteralTypes = false, -- 启用结构体类型提示
            constantValues = false, -- 禁用常量值提示
            functionTypeParameters = false, -- 禁用函数类型参数提示
            parameterNames = false, -- 启用参数名提示
            rangeVariableTypes = false, -- 禁用范围变量类型提示
          },
          -- 静态检查
          staticcheck = false, -- 启用静态检查
          gofumpt = true, -- 启用 gofumpt 格式化
        },
      },
    })

    -- === 通用 LSP 配置 ===
    vim.diagnostic.config({
      virtual_text = { prefix = "●" },
      signs = true,
      underline = true,
      update_in_insert = false, -- 插入模式不更新诊断信息
    })

    -- === 自动格式化 ===
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.go", "*.lua" },
      callback = function()
        vim.lsp.buf.format({
          async = false,
          timeout_ms = 5000,
        })
      end,
    })
  end,
}
