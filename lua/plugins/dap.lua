local dap = require('dap')
local dapui = require('dapui')
local dapgo = require('dap-go')
local nvim_dap_virtual_text = require('nvim-dap-virtual-text')

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '➡️', texthl = 'DapStopped', linehl = 'DebugLineHL', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🔶', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '⚠️', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

dapui.setup()
dapgo.setup()
nvim_dap_virtual_text.setup {
  display_callback = function(variable)
    local name = string.lower(variable.name)
    local value = string.lower(variable.value)
    if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
      return "(凸ಠ益ಠ)凸"
    end
    if #variable.value > 15 then
      return " " .. string.sub(variable.value, 1, 15) .. "... "
    end

    return " " .. variable.value
  end
}
-- Configure Debuggers
local dap_executables = {
  codelldb = vim.fn.exepath("codelldb"),
}

dap.adapters.codelldb = {
  type = 'executable',
  command = dap_executables['codelldb'],
  name = 'codelldb',
  detached = true,
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  }
}

-- Keymap

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<leader>?", function()
  require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F13>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
