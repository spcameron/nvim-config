-- select, swap, and move to textobjects

return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- Functions
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',

            -- Classes / Types
            ['aC'] = '@class.outer',
            ['iC'] = '@class.inner',

            -- Conditionals (if/elif/else in Python, if in Go)
            ['a?'] = '@conditional.outer',
            ['i?'] = '@conditional.inner',

            -- Loops (for/while in Python, for in Go)
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',

            -- Parameters
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
            [']?'] = '@conditional.outer',
            [']l'] = '@loop.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
            ['[?'] = '@conditional.outer',
            ['[l'] = '@loop.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
