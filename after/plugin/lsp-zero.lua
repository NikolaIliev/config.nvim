local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lsp = require('lsp-zero').preset({
  manage_nvim_cmp = {
    -- we'll set up mappings manually
    set_sources = 'recommended',
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

-- autocompletion mappings
cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  },
})

-- formatting
lsp.format_on_save({
  async = true,

  servers = {
    ['null-ls'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'lua', 'json', 'yaml' },
  },
})

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
    null_ls.builtins.code_actions.gitsigns,
  },
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require('mason-null-ls').setup({
  ensure_installed = nil,
  automatic_installation = false, -- You can still set this to `true`
  automatic_setup = true,
})

-- Required when `automatic_setup` is true
require('mason-null-ls').setup_handlers()
