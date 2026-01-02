local config = function()
    local dap = require "dap"
    vim.keymap.set("n", "<localleader>dc", dap.continue)
    vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<localleader>dn", dap.step_over)
    vim.keymap.set("n", "<localleader>ds", dap.step_into)
    vim.keymap.set("n", "<localleader>dr", dap.repl.toggle)
    vim.keymap.set("n", "<localleader>dq", dap.repl.toggle)

    local widgets = require "dap.ui.widgets"
    vim.keymap.set("n", "<localleader>dh", widgets.hover)

    local dap_view = require "dap-view"
    vim.keymap.set("n", "<localleader>dv", ":DapViewToggle<cr>")

    local dap_python = require "dap-python"
    dap_python.setup "debugpy-adapter"
    dap_python.test_runner = "pytest"
end

return {
    { "igorlfs/nvim-dap-view", lazy = false },
    { "mfussenegger/nvim-dap", config = config },
    "mfussenegger/nvim-dap-python",
}
