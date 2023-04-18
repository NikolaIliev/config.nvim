local Terminal = require('toggleterm.terminal').Terminal

function OpenTerminal(opts)
  return function()
    local count = vim.api.nvim_eval('v:count1')
    local merged_opts = { count = count }

    for k, v in pairs(opts) do
      merged_opts[k] = v
    end

    local term = Terminal:new(merged_opts)

    term:toggle()

    vim.cmd('normal ' .. term.id .. ':ToggleTermSetName ' .. 'Terminal ' .. count)
  end
end

-- open floating terminal
vim.keymap.set('n', '<leader>tf', OpenTerminal({ direction = 'float', float_opts = { border = 'double' } }))

-- open horizontal terminal
vim.keymap.set('n', '<leader>th', OpenTerminal({ direction = 'horizontal' }))
--
-- open vertical terminal
vim.keymap.set('n', '<leader>tv', OpenTerminal({ direction = 'vertical' }))

-- open node terminal
vim.keymap.set('n', '<leader>tn', OpenTerminal({ cmd = 'node', direction = 'float' }))
