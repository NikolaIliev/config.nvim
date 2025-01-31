return {
  'stevearc/oil.nvim',
  opts = {
    -- Use floating window
    float = {
      padding = 2, -- Adds padding around the floating window
      max_width = 80, -- Maximum width of the window
      max_height = 30, -- Maximum height
      border = 'rounded', -- Window border (rounded, double, etc.)
    },
    view_options = {
      show_hidden = true, -- Show hidden files
    },
    keymaps = {
      ['_'] = false, -- oil.nvim overrides _ (which usually goes to the first character of the current line). disable this override
      ['<Esc>'] = 'actions.close',
    },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    {
      '-',
      function()
        require('oil').open_float()
      end,
      desc = 'Open Oil in Floating Window',
    },
  },
}
