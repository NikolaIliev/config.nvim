return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto', -- Keeps it neutral, no extra colors
      icons_enabled = true,
      component_separators = { left = '', right = '' }, -- No separators
      section_separators = { left = '', right = '' }, -- No separators
      disabled_filetypes = { 'oil' }, -- Disable in oil.nvim
      globalstatus = true,
    },
    sections = {
      lualine_a = { {
        'mode',
        fmt = function(str)
          return str:sub(1, 1)
        end,
      } }, -- Only show single-letter mode
      lualine_b = { 'branch', 'diff' }, -- Git branch
      lualine_c = {
        { 'filename', path = 1, symbols = { modified = '●', readonly = '', unnamed = '[No Name]' } },
      },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_lsp' },
          symbols = { error = '✖ ', warn = '⚠ ', hint = '💡', info = 'ℹ' },
        },
        { 'filetype', icon_only = true }, -- Shows only the icon (from `nvim-web-devicons`)
      },
      lualine_y = { 'progress' }, -- Shows progress in file
      lualine_z = { 'location' }, -- Shows line/column
    },
    inactive_sections = { -- Keeps it even cleaner when inactive
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}
