local config = function()
    local dap = require "dap"
    vim.keymap.set("n", "<localleader>dt", dap.terminate)

    vim.keymap.set("n", "<localleader>dc", dap.continue)
    vim.keymap.set("n", "<localleader>do", dap.step_over)
    vim.keymap.set("n", "<localleader>di", dap.step_into)
    vim.keymap.set("n", "<localleader>de", dap.step_out)
    vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<localleader>dB", dap.set_breakpoint)
    vim.keymap.set("n", "<localleader>dP", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end)
    vim.keymap.set("n", "<localleader>dr", dap.repl.open)
    vim.keymap.set("n", "<localleader>dl", dap.run_last)

    local dap_ui_widgets = require "dap.ui.widgets"
    vim.keymap.set({"n", "v"}, "<localleader>dh", function()
        dap_ui_widgets.hover()
    end)
    vim.keymap.set({"n", "v"}, "<localleader>dp", function()
        dap_ui_widgets.preview()
    end)
    vim.keymap.set("n", "<localleader>df", function()
        dap_ui_widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set("n", "<localleader>ds", function()
        dap_ui_widgets.centered_float(widgets.scopes)
    end)

    local dap_python = require "dap-python"
    dap_python.setup "debugpy-adapter"
    dap_python.test_runner = "pytest"

    vim.keymap.set("n", "<localleader>dM", dap_python.test_method)
    vim.keymap.set("n", "<localleader>dC", dap_python.test_class)
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = { "mfussenegger/nvim-dap-python" },
        config = config
    }
}
