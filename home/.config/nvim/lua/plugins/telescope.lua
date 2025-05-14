local config = function()
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>b", builtin.buffers, {})
    vim.keymap.set("n", "<leader>c", builtin.commands, {})
    vim.keymap.set("n", "<leader>f", builtin.find_files, {})
    vim.keymap.set("n", "<leader>g", builtin.git_files, {})
    vim.keymap.set("n", "<leader>k", builtin.keymaps, {})
    vim.keymap.set("n", "<leader>r", builtin.live_grep, {})

    vim.keymap.set("n", "<localleader>e", function()
        vim.diagnostic.open_float {
            border = "rounded",
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            focusable = false,
            scope = "cursor",
            source = "always",
        }
    end, bufopts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
    vim.keymap.set("n", "<localleader>q", builtin.diagnostics, bufopts)
end

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = config,
    dependencies = { "nvim-lua/plenary.nvim" },
    priority = 900
}
