return {
  'mfussenegger/nvim-dap',
  version = '0.*',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- Debugging UI
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text', -- Inline debug info
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local dappython = require('dap-python')

    -- Get `codelldb` path from Mason
    local codelldb_path = require('mason-registry').get_package('codelldb'):get_install_path() .. '/codelldb'

    -- Configure Rust debugging with `codelldb`
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--port', '${port}' },
      },
    }

    -- Rust DAP Config
    dap.configurations.rust = {
      {
        name = 'Launch Rust Program',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      },
    }

    require('dap-python').setup(vim.fn.getcwd() .. '/.venv/bin/python3')

    -- Setup Debug UI & Virtual Text
    dapui.setup()
    require('nvim-dap-virtual-text').setup()

    -- Auto Open/Close Debug UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
  keys = {
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Start/Continue Debugging',
    },
    {
      '<F10>',
      function()
        require('dap').step_over()
      end,
      desc = 'Step Over',
    },
    {
      '<F11>',
      function()
        require('dap').step_into()
      end,
      desc = 'Step Into',
    },
    {
      '<F12>',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = 'Conditional Breakpoint',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = 'Open Debug REPL',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Run Last Debugging Session',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'Toggle Debug UI',
    },
  },
}
