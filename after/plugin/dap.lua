
local dap = require("dap")

dap.adapters.gdb = {
    type = "executable",
    command = "arm-none-eabi-gdb",
    args = { "-i", "dap" }
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
}

dap.configurations.cpp = dap.configurations.c

local ok_dapui, dapui = pcall(require, "dapui")
if ok_dapui then
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

local ok_virtual_text, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if ok_virtual_text then
    dap_virtual_text.setup()
end

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP continue" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP step into" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "DAP step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP conditional breakpoint" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP run last" })
vim.keymap.set("n", "<leader>du", function()
    if ok_dapui then
        dapui.toggle()
    end
end, { desc = "DAP toggle UI" })
