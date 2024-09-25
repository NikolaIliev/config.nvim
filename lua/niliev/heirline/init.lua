local BufferName = {
  provider = ' %{bufname()}',
}

local Mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,

  static = {
    mode_mapping = {
      n = 'Normal',
      nt = 'Normal', -- terminal (normal mode)
      c = 'Normal', -- command mode, who cares
      i = 'Insert',
      t = 'Insert', -- terminal (insert mode)
      v = 'Visual',
      V = 'VLines',
      ['\22'] = 'VBlock',
    },
  },

  provider = function(self)
    return (self.mode_mapping[self.mode] or self.mode) .. ' '
  end,

  update = 'ModeChanged',
}

local Diagnostics = {
  provider = function()
    local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local errors = #diagnostics

    local result = {}
    if errors > 0 then
      table.insert(result, 'E: ' .. errors)
    end

    return table.concat(result, ' ')
  end,

  update = { 'DiagnosticChanged', 'BufEnter' }, -- Update when diagnostics change or buffer changes
}

local StatusLine = { Mode, BufferName, Diagnostics }
local WinBar = {}
local TabLine = {}

function Config()
  require('heirline').setup({
    statusline = StatusLine,
    winbar = WinBar,
    tabline = TabLine,
    opts = {
      disable_winbar_cb = function()
        return true
      end,
    },
  })
end

return { Config = Config }
