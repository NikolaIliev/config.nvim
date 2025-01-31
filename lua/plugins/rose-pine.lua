return {
  'rose-pine/neovim',
  name = 'rose-pine',
  version = 'v3.*',
  opts = {
    dim_inactive_windows = true,
  },
  init = function()
    vim.cmd('colorscheme rose-pine')
  end,
}
