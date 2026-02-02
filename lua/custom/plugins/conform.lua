-- autoformatter

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
        }
      end,
      mode = { 'n', 'v' },
      desc = '[f]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = {
        c = true,
        cpp = true,
      }

      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 5000,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      bash = { 'shfmt' },
      css = { 'prettier' },
      go = { 'goimports' },
      html = { 'prettier' },
      javascript = { 'eslint_d', 'prettier' },
      javascriptreact = { 'eslint_d', 'prettier' },
      lua = { 'stylua' },
      python = { 'ruff_fix', 'black' },
      sh = { 'shfmt' },
      sql = { 'pg_format' },
      typescript = { 'eslint_d', 'prettier' },
      typescriptreact = { 'eslint_d', 'prettier' },
      zsh = { 'shfmt' },
    },
    formatters = {
      eslint_d = {
        prefer_local = 'node_modules/.bin',
      },
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
