-- catppuccin-mocha colortheme

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha',
    auto_integrations = true,
    integrations = {
      blink_cmp = true,
      -- add others here later (telescope, gitsigns, treesitter, etc.)
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}

-- vim: ts=2 sts=2 sw=2 et
