function OpenTerminal(opts)
  return function()
    local Terminal = require('toggleterm.terminal').Terminal
    local count = vim.api.nvim_eval('v:count1')
    local merged_opts = { count = count }

    for k, v in pairs(opts) do
      merged_opts[k] = v
    end

    if merged_opts.direction == 'float' then
      merged_opts.dir = vim.fn.expand('%:p:h') -- Get the directory of the current buffer
    end

    local term = Terminal:new(merged_opts)

    term:toggle()

    vim.cmd('normal ' .. term.id .. ':ToggleTermSetName ' .. 'Terminal ' .. count)
  end
end

return {
  'akinsho/toggleterm.nvim',
  opts = {
    shading_factor = 2,
    hide_numbers = true,
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.3
      end
    end,
  },
  keys = {
    { '<leader>tf', OpenTerminal({ direction = 'float', float_opts = { border = 'rounded' } }) },
    { '<leader>tv', OpenTerminal({ direction = 'vertical' }) },
    { '<leader>th', OpenTerminal({ direction = 'horizontal' }) },
  },
}
