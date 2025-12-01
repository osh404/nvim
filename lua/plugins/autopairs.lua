-- 在 Lazy.nvim 配置中添加
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local npairs = require("nvim-autopairs")
        local Rule = require('nvim-autopairs.rule')

        npairs.setup({
            check_ts = true,       -- 启用 treesitter
            ts_config = {
                go = { 'string' }, -- 在 Go 字符串中禁用自动配对
            },
        })

        -- 针对 Go 函数的大括号特殊规则
        npairs.add_rules({
            Rule("(", ")", "go")
                :with_pair(function(opts)
                    return opts.prev_char:match("%(%)") ~= nil
                end)
                :with_move(function(opts)
                    return opts.char == ")"
                end)
                :use_key(")"),

            -- 主要规则：输入 { 时自动补全并换行
            Rule("{", "}", "go")
                :with_pair(function(opts)
                    -- 检查前面是否是函数声明模式
                    local line = vim.api.nvim_get_current_line():sub(1, opts.col - 1)
                    return line:match("func%s+%w+%s*%([^)]*%)%s*$")
                end)
                :with_cr(function()
                    -- 输入 { 后按回车时的行为
                    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
                    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
                    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", true)
                    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
                end)
                :with_move(function(opts)
                    return opts.char == "}"
                end)
                :use_key("}")
        })
    end
}
