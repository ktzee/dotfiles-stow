return { "catppuccin/nvim", name = "catppuccin", priority = 1000,
        config = function ()
            vim.cmd.colorscheme("catppuccin")
        end,
        integrations = {
            cmp = true,
            gitsigns = true,
            treesitter = true,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
        }
}
