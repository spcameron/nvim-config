-- snippet engine

return {
  'L3MON4D3/LuaSnip',
  version = '2.*',
  build = (function()
    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      return
    end
    return 'make install_jsregexp'
  end)(),
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
  },
  opts = {},
  config = function(_, opts)
    local luasnip = require 'luasnip'

    luasnip.setup(opts)

    local group = vim.api.nvim_create_augroup('spc_luasnip_cleanup', { clear = true })

    local function leave_snippet()
      if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not luasnip.session.jump_active
      then
        luasnip.unlink_current()
      end
    end

    vim.api.nvim_create_autocmd('ModeChanged', {
      group = group,
      pattern = '*',
      callback = leave_snippet,
      desc = 'Unlink LuaSnip snippet when leaving insert/select mode',
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
