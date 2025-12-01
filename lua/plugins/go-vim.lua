return {
    "ray-x/go.nvim",
    dependencies = {                       -- 依赖项修正
        "ray-x/guihua.lua",                -- GUI 相关功能支持
        "neovim/nvim-lspconfig",           -- Neovim LSP 配置
        "nvim-treesitter/nvim-treesitter", -- 语法高亮增强
    },
    event = { "CmdlineEnter" },            -- 触发加载的时机
    ft = { "go", "gomod" },                -- 仅对 Go 和 Go mod 文件生效
    build = function()                     -- 修正构建命令
        require("go.install").update_all_sync()
    end,
    config = function()
        require("go").setup({
            verbose = true, -- 不显示详细日志
            diagnostic = { -- LSP 诊断（错误提示）配置
                -- true: default nvim setup
                hdlr = false, -- -- 不覆盖默认 LSP 诊断处理器
                underline = true,
                virtual_text = { spacing = 2, prefix = '' }, -- virtual text setup
                signs = { '', '', '', '' }, -- set to true to use default signs, an array of 4 to specify custom signs
                update_in_insert = false, -- 不在插入模式更新诊断(提高性能)
            },
            dap_debug = false, -- 禁用 DAP 调试（默认）

        })
        -- require("go.format").gofmt()  -- 只使用 gofmt
        require("go.format").goimports() -- goimports + gofmt

        -- 自动格式化配置 (修正缩进和语法)
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            group = format_sync_grp,
            callback = function()
                -- require("go.format").gofmt()
                require("go.format").goimports() -- goimports + gofmt
            end,
        })
    end
}
