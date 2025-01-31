return {
  'nvim-treesitter/nvim-treesitter',
  version = 'v0.*',
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    ensure_installed = { 'lua', 'rust', 'markdown', 'markdown_inline' },
    sync_install = false,
    auto_install = true,
  },
}
