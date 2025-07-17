return {
  'lewis6991/gitsigns.nvim',
  version = 'v0.*',
  lazy = false,
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    signcolumn = true, -- Ensure signs appear in the left column
    watch_gitdir = {
      follow_files = true,
    },
    update_debounce = 1000,
  },
  keys = {
    {
      '<leader>hb',
      function()
        require('gitsigns').blame_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>hr',
      function()
        require('gitsigns').reset_hunk()
      end,
      desc = 'Git Reset Hunk',
    },
    {
      '<leader>hp',
      function()
        require('gitsigns').preview_hunk()
      end,
      desc = 'Git Diff Hunk',
    },
    {
      ']h',
      function()
        require('gitsigns').next_hunk()
      end,
      desc = 'Git Move to Next Hunk',
    },
    {
      '[h',
      function()
        require('gitsigns').prev_hunk()
      end,
      desc = 'Git Move to Previous Hunk',
    },
  },
}
