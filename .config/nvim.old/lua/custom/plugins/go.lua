return {
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    config = function(_, opts)
      require('gopher').setup(opts)
    end,
    -- auto-install deps
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}
