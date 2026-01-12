local config = function()
    local dap = require "dap"
    vim.keymap.set("n", "<localleader>dc", dap.continue)
    vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<localleader>dn", dap.step_over)
    vim.keymap.set("n", "<localleader>ds", dap.step_into)
    vim.keymap.set("n", "<localleader>dr", dap.repl.toggle)
    vim.keymap.set("n", "<localleader>dq", dap.terminate)

    local widgets = require "dap.ui.widgets"
    vim.keymap.set("n", "<localleader>dh", widgets.hover)

    local dap_python = require "dap-python"
    dap_python.setup "debugpy-adapter"
    dap_python.test_runner = "pytest"
    vim.keymap.set("n", "<localleader>dt", dap_python.test_method)
    vim.keymap.set("n", "<localleader>dT", dap_python.test_class)

    require("nvim-dap-virtual-text").setup()
end

return {
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    { "mfussenegger/nvim-dap", config = config },
}
