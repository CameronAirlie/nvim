local function executable_path()
  local input = vim.fn.input({
    prompt = "Path to executable: ",
    default = vim.fn.getcwd() .. "/build/",
    completion = "file",
  })
  if input == "" then
    return nil
  end

  local path = vim.fn.fnamemodify(input, ":p")
  if vim.fn.executable(path) ~= 1 then
    vim.notify("Not an executable file: " .. path, vim.log.levels.ERROR, { title = "DAP" })
    return nil
  end
  return path
end

local function program_arguments()
  return require("dap.utils").splitstr(vim.fn.input("Program arguments: "))
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          commented = true,
          only_first_definition = true,
        },
      },
    },
    keys = {
      {
        "<F5>",
        function()
          vim.notify("Preparing debug session", vim.log.levels.INFO, { title = "DAP" })
          require("dap").continue()
        end,
        desc = "Debug: Start/continue",
      },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        desc = "Debug: Conditional breakpoint",
      },
      {
        "<leader>dl",
        function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
        desc = "Debug: Log point",
      },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
      { "<leader>dL", "<cmd>DapShowLog<cr>", desc = "Debug: Show log" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Debug: Terminate" },
      { "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Debug: Run to cursor" },
      { "<leader>dh", function() require("dap.ui.widgets").hover() end, mode = { "n", "v" }, desc = "Debug: Inspect" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Raise to "TRACE" temporarily when debugging adapter issues
      dap.set_log_level("WARN")

      dapui.setup({
        controls = { enabled = true },
        floating = { border = "rounded" },
      })

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = {
          "--quiet",
          "--interpreter=dap",
          "--eval-command",
          "set print pretty on",
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch executable (GDB, stop at main)",
          type = "gdb",
          request = "launch",
          program = executable_path,
          args = program_arguments,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = true,
        },
        {
          name = "Launch executable (GDB, no initial stop)",
          type = "gdb",
          request = "launch",
          program = executable_path,
          args = program_arguments,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      -- Programs with assets/shared libraries beside the executable (such as
      -- game editors) generally need to start there rather than at the source
      -- repository root. This hook runs after the async program prompt has
      -- been resolved.
      dap.listeners.on_config.executable_cwd = function(config)
        config = vim.deepcopy(config)
        if config.type == "gdb" and type(config.program) == "string" then
          config.cwd = vim.fn.fnamemodify(config.program, ":h")
        end
        return config
      end

      -- Allow project-local .vscode/launch.json files to use this adapter type.
      require("dap.ext.vscode").type_to_filetypes.gdb = { "c", "cpp" }

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "×", texthl = "DiagnosticError" })

      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.after.event_initialized.dap_status = function()
        vim.notify("Debugger connected; launching program", vim.log.levels.INFO, { title = "DAP" })
      end
      dap.listeners.after.event_stopped.dap_status = function(_, body)
        vim.notify("Program stopped: " .. tostring(body.reason), vim.log.levels.INFO, { title = "DAP" })
      end
      -- Keep the UI open after short-lived programs so their output and exit
      -- status do not disappear before they can be inspected.
      dap.listeners.before.event_terminated.dapui_config = function(_, body)
        vim.notify("Debug session terminated" .. (body.restart and " (restarting)" or ""), vim.log.levels.INFO, { title = "DAP" })
      end
      dap.listeners.before.event_exited.dapui_config = function(_, body)
        vim.notify("Program exited with code " .. tostring(body.exitCode), vim.log.levels.INFO, { title = "DAP" })
      end
    end,
  },
}
