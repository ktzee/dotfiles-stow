-- C-specific settings
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- Autoformat on save
vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = 0,
  callback = function()
    -- Save the current cursor position
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local current_col = vim.api.nvim_win_get_cursor(0)[2]

    -- Execute clang-format silently
    vim.cmd 'silent! %!clang-format'

    -- Restore the cursor position
    vim.api.nvim_win_set_cursor(0, { current_line, current_col })
  end,
})
