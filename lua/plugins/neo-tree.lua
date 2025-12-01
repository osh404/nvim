-- 在 Lazy.nvim 配置中
return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        filesystem = {
            hijack_netrw_behavior = "disabled", -- 完全禁用 netrw 接管
        },
    }
}
