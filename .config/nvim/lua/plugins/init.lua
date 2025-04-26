-- drop here plugins that require minimal config
-- those that do live in individual files in this path
return {
    "numToStr/Comment.nvim",
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    { -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        config = function() -- This is the function that runs, AFTER loading
            require('which-key').setup()
        end,
    },
    -- Highlight todo, notes, etc in comments
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
    { -- Autoformat
        'stevearc/conform.nvim',
        opts = {
            notify_on_error = true,
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            -- log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                lua = { 'stylua' },
                -- Conform can also run multiple formatters sequentially
                python = { 'isort', 'black' },
                go = { 'goimports', 'gofumpt', 'golines' },
                --
                -- You can use a sub-list to tell conform to run *until* a formatter
                -- is found.
                javascript = { 'prettier' },
                html = { 'rustywind', 'prettier' },
                json = { 'jq' },
                svelte = { 'prettier', 'rustywind' },
                c = { 'clang-format' },
                odin = { 'odinfmt' },
            },
        },
    },
    'neovim/nvim-lspconfig' -- config in config.lsp-config
}
