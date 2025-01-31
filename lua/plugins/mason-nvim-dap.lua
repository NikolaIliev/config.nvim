return {
  'jay-babu/mason-nvim-dap.nvim',
  version = 'v2.*',
  dependencies = { 'williamboman/mason.nvim' },
  opts = {
    ensure_installed = { 'codelldb' }, -- Ensure Rust debugger is installed
    automatic_installation = true,
  },
}
