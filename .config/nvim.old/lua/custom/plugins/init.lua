-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    init = function() end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    event = 'VeryLazy',
    config = function()
      require('harpoon'):setup()
    end,
  },
  {
    'monkoose/matchparen.nvim',
    config = function()
      require('matchparen'):setup()
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'mikavilpas/yazi.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = 'VeryLazy',
    keys = {
      {
        '<leader>-',
        function()
          require('yazi').yazi()
        end,
        { desc = 'Open Yazi' },
      },
    },
    opts = {
      -- enable this if you want to open yazi instead of netrw
      open_for_directories = false,
    },
  },
  -- {
  --   'S1M0N38/love2d.nvim',
  --   cmd = 'LoveRun',
  --   opts = {},
  --   keys = {
  --     { '<leader>v', desc = 'LÖVE' },
  --     { '<leader>vv', '<cmd>LoveRun<cr>', desc = 'Run LÖVE' },
  --     { '<leader>vs', '<cmd>LoveStop<cr>', desc = 'Stop LÖVE' },
  --   },
  -- },
}
