return {
  'stevearc/conform.nvim',
  opts = {
    format_on_save = {
      timeout_ms = 500, -- Timeout before formatting is canceled
      lsp_format = 'fallback', -- Use LSP if no formatter is defined
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt' },
    },
  },
}
