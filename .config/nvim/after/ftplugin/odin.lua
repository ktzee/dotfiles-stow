vim.keymap.set({ "n", "i", "v" }, "<F5>", ":w<CR> :!odin run .<CR>", { buffer = true, silent = true })
