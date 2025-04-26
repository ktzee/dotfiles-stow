local harpoon = require 'harpoon'

vim.keymap.set('n', '<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Toggle Harpoon M[e]nu' })

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end, { desc = '[A]ppend File to Harpoon List' })

vim.keymap.set('n', '<A-1>', function()
  harpoon:list():select(1)
end, { desc = 'Select Harpoon File 1' })

vim.keymap.set('n', '<A-2>', function()
  harpoon:list():select(2)
end, { desc = 'Select Harpoon File 2' })

vim.keymap.set('n', '<A-3>', function()
  harpoon:list():select(3)
end, { desc = 'Select Harpoon File 3' })

vim.keymap.set('n', '<A-4>', function()
  harpoon:list():select(4)
end, { desc = 'Select Harpoon File 4' })
