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

-- sane undo config
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- search
vim.opt.incsearch = true

-- disable line wrapping
vim.opt.wrap = false

-- keep 20 rows always visible when scrolling
vim.opt.scrolloff = 20

-- status column - relative line numbers + padding
-- also does not show numbers in e.g. terminal mode
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = "%s%=%{&nu ? (v:lnum > 0 ? (v:relnum == 0 ? v:lnum : v:relnum) : ' ') . '    ' : ''}"

-- login shell
vim.opt.shell = 'zsh --login'

-- display hidden characters
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·' }

vim.opt.fillchars = {
  horiz = '─', -- Horizontal split line
  horizup = '┴', -- Bottom of a split
  horizdown = '┬', -- Top of a split
  vert = '│', -- Vertical split line
  vertleft = '┤', -- Right side of a vertical split
  vertright = '├', -- Left side of a vertical split
  verthoriz = '┼', -- Cross intersection of vertical and horizontal splits
}
