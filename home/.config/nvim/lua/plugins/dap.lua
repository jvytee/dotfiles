local config = function()
    local dap = require "dap"
    vim.keymap.set("n", "<localleader>dc", dap.continue)
    vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<localleader>dn", dap.step_over)
    vim.keymap.set("n", "<localleader>ds", dap.step_into)
    vim.keymap.set("n", "<localleader>dr", dap.repl.toggle)
    vim.keymap.set("n", "<localleader>dq", dap.terminate)

    local widgets = require "dap.ui.widgets"
    local sidebar = widgets.sidebar(widgets.scopes)
    vim.keymap.set("n", "<localleader>dh", widgets.hover)
    vim.keymap.set("n", "<localleader>du", sidebar.toggle)
end

local config_dap_python = function()
    local dap_python = require "dap-python"
    dap_python.setup "debugpy-adapter"
    dap_python.test_runner = "pytest"
    vim.keymap.set("n", "<localleader>dt", dap_python.test_method)
    vim.keymap.set("n", "<localleader>dT", dap_python.test_class)
end


return {
    { "mfussenegger/nvim-dap", config = config },
    { "mfussenegger/nvim-dap-python", ft = "python", config = config_dap_python }
}
