-- highlight, edit, and navigate code
-- see `:help nvim-treesitter`

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'clojure',
      'commonlisp',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'go',
      'graphql',
      'html',
      'http',
      'java',
      'javadoc',
      'javascript',
      'json',
      'json5',
      'just',
      'kotlin',
      -- 'latex',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'python',
      'racket',
      'regex',
      'rust',
      'scheme',
      'sql',
      'typescript',
      'query',
      'vim',
      'vimdoc',
    },
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
      disable = function(lang, buf)
        if lang == 'markdown' or lang == 'markdown_inline' then
          return true
        end

        local uv = vim.uv or vim.loop
        local ok, stat = pcall(uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stat and stat.size > 1024 * 1024
      end,
    },
    indent = {
      enable = true,
      disable = { 'ruby', 'yaml', 'markdown', 'markdown_inline' },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
