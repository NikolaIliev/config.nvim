local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lsp = require('lsp-zero').preset({
  manage_nvim_cmp = {
    -- we'll set up mappings manually
    set_basic_mappings = false,
    set_extra_mappings = false,
  },
})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
end)

-- sign icons
lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»',
})

lsp.format_on_save({
  format_opts = {
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { 'javascript', 'typescript', 'typescriptreact', 'json', 'yaml', 'lua' },
  },
})

-- autocompletion mappings
cmp.setup({
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'nvim_lsp_signature_help' },
  },
})

-- formatting
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

lsp.setup()

local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- tools not supported by mason.nvim
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
  },
})
