return {
  'stevearc/conform.nvim',
  version = 'v8.*',
  opts = {
    format_on_save = {
      timeout_ms = 500, -- Timeout before formatting is canceled
      lsp_format = 'fallback', -- Use LSP if no formatter is defined
    },
    formatters_by_ft = {
      typescript = { 'prettier' },
      javascript = { 'prettier' },
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      python = { 'black' },
    },
    formatters = {
      black = {
        prepend_args = { '--fast' },
      },
    },
  },
}
