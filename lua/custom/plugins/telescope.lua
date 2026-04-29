-- fuzzy finder (files, lsp, etc.)
-- see `:help telescope`

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = 'master',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  opts = {
    pickers = {
      buffers = {
        sort_mru = true,
        ignore_current_buffer = true,
      },
      colorscheme = {
        enable_preview = true,
      },
      find_files = {
        file_ignore_patterns = {
          'node_modules',
          '%.git',
          '%.venv',
        },
        hidden = true,
      },
      live_grep = {
        file_ignore_patterns = {
          'node_modules',
          '%.git',
          '%.venv',
        },
        additional_args = function(_)
          return { '--hidden' }
        end,
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  },
  config = function()
    -- enable telescope extensions (if they are installed)
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- see `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    local function map(mode, l, r, opts)
      opts = opts or {}
      vim.keymap.set(mode, l, r, opts)
    end

    -- keymappings
    map('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
    map('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
    map('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [f]iles' })
    map('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [s]elect telescope' })
    map('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
    map('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch by [g]rep' })
    map('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
    map('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
    map('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
    map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] find existing buffers' })

    map('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] fuzzy search in current buffer' })

    map('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[s]earch [/] in open files' })

    map('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[s]earch [n]eovim files' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
