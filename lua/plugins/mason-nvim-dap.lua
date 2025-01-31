return {
  'jay-babu/mason-nvim-dap.nvim',
  dependencies = { 'williamboman/mason.nvim' },
  opts = {
    ensure_installed = { 'codelldb' }, -- Ensure Rust debugger is installed
    automatic_installation = true,
  },
}
