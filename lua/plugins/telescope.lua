return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  cmd = 'Telescope',
  keys = {
    {
      '<leader>fa',
      function()
        require('telescope.builtin').find_files({ hidden = true })
      end,
      desc = 'Find All Files',
    },
    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>ps',
      function()
        local input = vim.fn.input('Search in repo > ')
        if input == '' then
          return
        end
        require('telescope.builtin').grep_string({ search = input })
      end,
      desc = 'Search in Repo',
    },
    {
      '<leader>da',
      function()
        require('telescope.builtin').diagnostics()
      end,
      desc = 'Project Diagnostics',
    },
    {
      '<leader>de',
      function()
        require('telescope.builtin').diagnostics({ severity = 'error' })
      end,
      desc = 'Project Diagnostics (Errors only)',
    },
    {
      '<Esc>',
      function()
        require('telescope.builtin').buffers({
          sort_lastused = true,
          sort_mru = true,
          ignore_current_buffer = true,
          show_all_buffers = false,
        })
      end,
      desc = 'Show Buffers',
    },
  },
  opts = {
    defaults = {
      path_display = { 'truncate' },
      mappings = {
        i = {
          ['<esc>'] = require('telescope.actions').close,
          ['<C-j>'] = require('telescope.actions').move_selection_next,
          ['<C-k>'] = require('telescope.actions').move_selection_previous,
          ['<C-q>'] = function(prompt_bufnr)
            require('telescope.actions').smart_send_to_qflist(prompt_bufnr)
            vim.cmd([[botright copen]])
          end,
        },
      },
    },
  },
}
