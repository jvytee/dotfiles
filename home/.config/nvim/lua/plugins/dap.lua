local config = function()
    local dap_python = require "dap-python"
    dap_python.setup "debugpy-adapter"
    dap_python.test_runner = "pytest"

    vim.keymap.set("n", "<localleader>dm", dap_python.test_method)
    vim.keymap.set("n", "<localleader>dc", dap_python.test_class)
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = { "mfussenegger/nvim-dap-python" },
        config = config
    }
}
