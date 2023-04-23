require('telescope').setup({
  defaults = {
    path_display = { 'truncate' },
  },
})

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

local function telescope_builtin(fn, opts)
  return function()
    builtin[fn](themes.get_ivy(opts))
  end
end

vim.keymap.set('n', '<leader>fa', telescope_builtin('find_files'), {})
vim.keymap.set('n', '<leader>ff', telescope_builtin('git_files'), {})
vim.keymap.set('n', '<leader>ss', telescope_builtin('lsp_document_symbols'), {})
vim.keymap.set('n', '<leader>sa', telescope_builtin('lsp_workspace_symbols'), {})
vim.keymap.set('n', '<leader>gb', telescope_builtin('git_branches'), {})
vim.keymap.set('n', '<leader>gs', telescope_builtin('git_status'), {})
vim.keymap.set('n', '<leader>gh', telescope_builtin('git_bcommits'), {})

vim.keymap.set('n', '<Esc>', telescope_builtin('buffers', { sort_lastused = true }), {})

vim.keymap.set('n', '<leader>pd', telescope_builtin('diagnostics', { severity = 'error' }), {})

vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input('Grep > ') })
end, {})
