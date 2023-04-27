vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', ':Ex<CR>')

-- more ergonomic navigation over buffer splits
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- in terminal mode, more ergonomic way to go to normal mode
vim.keymap.set('t', '<C-w>', '<C-\\><C-n>')

-- remap scrolling
vim.keymap.set('n', '<C-f>', 'L5j')
vim.keymap.set('n', '<C-b>', 'H5k')

-- for some reason in terminal mode shift+space outputs escape
-- this keymap restores the sane behavior
vim.keymap.set('t', '<S-Space>', '<Space>')
