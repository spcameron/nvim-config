-- status line

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = function()
    local has_icons = vim.g.have_nerd_font

    local function macro_status()
      local rec = vim.fn.reg_recording()
      if rec ~= '' then
        return (has_icons and ' ' or 'REC ') .. '@' .. rec
      end
      local exe = vim.fn.reg_executing()
      if exe ~= '' then
        return (has_icons and ' ' or 'PLAY ') .. '@' .. exe
      end
      return ''
    end

    local grp = vim.api.nvim_create_augroup('LualineMacroRefresh', { clear = true })
    vim.api.nvim_create_autocmd('RecordingEnter', {
      group = grp,
      callback = function()
        require('lualine').refresh { place = { 'statusline' } }
      end,
    })
    vim.api.nvim_create_autocmd('RecordingLeave', {
      group = grp,
      callback = function()
        vim.defer_fn(function()
          require('lualine').refresh { place = { 'statusline' } }
        end, 50)
      end,
    })

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local filename = {
      'filename',
      file_status = true,
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      cond = hide_in_width,
    }

    return {
      options = {
        theme = 'auto',
        icons_enabled = has_icons,
        globalstatus = false,
        component_separators = has_icons and { left = '', right = '' } or { left = '', right = '' },
        section_separators = has_icons and { left = '', right = '' } or { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', diff },
        lualine_c = { filename },
        lualine_x = { macro_status, diagnostics, 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = {
          function()
            return string.format('%2d:%-2d', vim.fn.line '.', vim.fn.col '.')
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'neo-tree', 'quickfix', 'trouble' },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
