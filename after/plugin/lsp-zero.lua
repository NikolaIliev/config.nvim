local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lsp = require('lsp-zero').preset({
  manage_nvim_cmp = {
    -- we'll set up mappings manually
    set_basic_mappings = false,
    set_extra_mappings = false,
  },
})
local lspconfig = require('lspconfig')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  -- async format on save
  if client.name == 'null-ls' then
    require('lsp-format').on_attach(client)
  end
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

lsp.configure('tsserver', {
  -- setting correct root dir is important, especially in a monorepo
  root_dir = function(fname)
    return lspconfig.util.root_pattern('tsconfig.base.json')(fname) or lspconfig.util.path.dirname(fname)
  end,
})

lsp.setup()

local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- tools not supported by mason.nvim
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.rustfmt,
    -- workspace diagnostics - unstable
    --
    --null_ls.builtins.diagnostics.tsc.with({
    --cwd = function()
    --return lspconfig.util.root_pattern('tsconfig.base.json')(vim.fn.expand("%:p:h"))
    --end,
    --command = "./node_modules/typescript/bin/tsc",
    --args = {"-b", "--pretty", "false"},
    --timeout = 60000
    --}),
    null_ls.builtins.code_actions.gitsigns,
  },
})

-- for debugging purposes. Root dir must be set correctly, especially in a monorepo
function _G.print_root_dir()
  local bufnr = vim.api.nvim_get_current_buf()
  local client_id = vim.lsp.get_active_clients()[1].id
  local root_dir = vim.lsp.buf_get_clients(bufnr)[client_id].config.root_dir
  print('Root directory:', root_dir)
end

vim.api.nvim_command('command! PrintRootDir lua _G.print_root_dir()')
