-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })

  use('tpope/vim-surround')

  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

  use('mbbill/undotree')

  use({
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = function()
      require('toggleterm').setup({
        shell = 'zsh --login',
        shading_factor = 2,
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.3
          end
        end,
      })
    end,
  })

  use({
    'rebelot/heirline.nvim',
    event = 'UiEnter',
    config = function()
      require('niliev.heirline').Config()
    end,
  })

  -- LSP
  use({
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    },
  })

  use('jose-elias-alvarez/null-ls.nvim')

  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  })

  -- hunks & line number decoration for added/changed/deleted lines
  use('lewis6991/gitsigns.nvim', { lock = true })

  -- async format on save
  use "lukas-reineke/lsp-format.nvim"
end)
