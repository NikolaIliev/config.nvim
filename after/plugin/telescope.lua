require('telescope').setup({
  defaults = {
    path_display = { 'truncate' },
  },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fa', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>sa', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, {})

vim.keymap.set('n', '<Esc>', function()
  builtin.buffers({ sort_lastused = true })
end, {})

vim.keymap.set('n', '<leader>pd', function()
  builtin.diagnostics({ severity = 'error' })
end, {})

vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input('Grep > ') })
end, {})
