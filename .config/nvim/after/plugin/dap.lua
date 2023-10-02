local dap = require('dap')
dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = 13000 -- 💀 Use the port printed out or specified with `--port`
}

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        -- CHANGE THIS to your path!
        command = '/home/pritom/git-files/codelldb/adapter/codelldb',
        args = {"--port", "${port}"},

        -- On windows you may have to uncomment this:
        -- detached = false,
    }
}

-- nvim-dap-ui
-- nvim-dap-ui configs
local dap = require('dap')
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

-- start nvim-dap-ui
local dapui = require('dapui')

dapui.setup()

-- dap fires events, we can listen on them to open UI on certain events
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
