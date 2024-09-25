-- mode is shown in our statusline
vim.o.showmode = false
-- ruler is integrated in our statusline
vim.opt.ruler = false
-- fast update times - what's not to like
vim.opt.updatetime = 50

-- Tab set to two spaces

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- display line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- sane undo config
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- search
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- disable line wrapping
vim.opt.wrap = false

-- keep 20 rows always visible when scrolling
vim.opt.scrolloff = 20

-- always display sign column
vim.opt.signcolumn = 'yes'

-- login shell
vim.opt.shell = 'zsh --login'

-- display hidden characters
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·' }
