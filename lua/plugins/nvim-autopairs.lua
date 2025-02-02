return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
  config = function(_, opts)
    local npairs = require('nvim-autopairs')
    npairs.setup()

    local Rule = require('nvim-autopairs.rule')

    npairs.add_rule(Rule('<', '>'))
  end,
}
