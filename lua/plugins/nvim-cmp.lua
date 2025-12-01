return {
    -- nvim-cmp 核心插件
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP 源
            "hrsh7th/cmp-buffer",   -- 缓冲区源
            "hrsh7th/cmp-path",     -- 路径源
            "hrsh7th/cmp-cmdline",  -- 命令行源
            "hrsh7th/cmp-vsnip",    -- Vsnip 源（可选）
            "onsails/lspkind.nvim", -- 美化图标（可选）
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- 如果使用 vsnip
                        -- 如果使用 luasnip: require('luasnip').lsp_expand(args.body)
                        -- 如果使用 snippy: require('snippy').expand_snippet(args.body)
                        -- 如果不使用 snippets: args.body
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                -- 这里重要
                sources = cmp.config.sources({
                    -- 优先级从高到低
                    { name = "nvim_lsp", priority = 1000 }, -- 从LSP服务器获取智能补全建议（最高优先级）
                    { name = "luasnip",  priority = 750 },  -- Snippet 补全
                    { name = "buffer",   priority = 500 },  -- 缓冲区补全
                    { name = "path",     priority = 250 },  -- 路径补全
                    { name = "nvim_lua", priority = 100 },  -- Neovim Lua API 补全
                }),
                -- 格式化显示
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text", -- 显示图标和文字
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
                -- 窗口配置
                window = {
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel",
                    }),

                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
                    }),
                },
            })
        end,
    },
}
