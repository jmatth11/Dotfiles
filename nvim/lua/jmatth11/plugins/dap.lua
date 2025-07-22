return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python",
      "mxsdev/nvim-dap-vscode-js",
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
      }
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()

      -- JS/TS setup
      require("dap-vscode-js").setup({
        node_path = "node",                                                                                                      -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = "/home/jmatth11/.local/share/nvim/site/pack/packer/opt/vscode-js-debug",                                 -- Path to vscode-js-debug installation.
        debugger_cmd = { "extension" },                                                                                          -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
        log_file_path = "(stdpath cache)/dap_vscode_js.log",                                                                     -- Path for file logging
        log_file_level = 0,                                                                                                      -- Logging level for output to file. Set to false to disable file logging.
        log_console_level = vim.log.levels
        .ERROR                                                                                                                   -- Logging level for output to console. Set to false to disable console output.
      })

      local js_based_languages = { "typescript", "javascript", "typescriptreact" }
      for _, language in ipairs(js_based_languages) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch File with Jest",
            args = { '--no-cache' },
            skipFiles = { '<node_internals>/**/*.js' },
            port = 9229,
            cwd = "${workspaceFolder}",
            runtimeArgs = {
              '--inspect-brk',
              './node_modules/.bin/jest',
              '--no-coverage',
              '--', "${file}",
            },
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Start Chrome with \"localhost\"",
            url = "http://localhost:3001",
            webRoot = "${workspaceFolder}",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
          }
        }
      end

      -- Python setup
      require("dap-python").setup("~/git/patracorp/ml-service/.venv/bin/")

      dap.listeners.after.event_initialized["dapui_config"] = function()
        ui.open({})
      end
      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

      -- Keymaps
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)
      vim.keymap.set('n', '<leader>ui', ui.toggle)
    end,
  }
}
