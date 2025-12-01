-- 更完整的配置
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signs_staged = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
        -- 关键配置：在行号列显示
        signcolumn = false, -- 禁用默认的 signcolumn
        numhl = false,      -- 禁用行号高亮
        linehl = false,     -- 禁用整行高亮
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <date> • <summary>",
        -- 按键绑定
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- 导航 - Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Next git hunk" })

            map("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Previous git hunk" })

            -- 动作 - Actions
            -- 暂存操作
            map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
            map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage entire buffer" })
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo last stage hunk" })

            -- 重置操作
            map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
            map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset entire buffer" })

            -- 查看和预览
            map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
            map("n", "<leader>hd", gs.diffthis, { desc = "Diff current hunk" })
            map("n", "<leader>hD", function()
                gs.diffthis("~")
            end, { desc = "Diff with last version" })

            -- Blame 功能
            map("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end, { desc = "Blame current line (full)" })
            map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })

            -- 其他功能
            map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted lines display" })

            -- 文本对象 - Text objects
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select git hunk" })
        end,
    },
}
