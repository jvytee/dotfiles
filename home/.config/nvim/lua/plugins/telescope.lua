local config = function()
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>c", builtin.commands, { desc = "Telescope commands" })
    vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>g", builtin.git_files, { desc = "Telescope git files" })
    vim.keymap.set("n", "<leader>k", builtin.keymaps, { desc = "Telescope keymaps" })
    vim.keymap.set("n", "<leader>r", builtin.live_grep, { desc = "Telescope live ripgrep" })

    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
    vim.keymap.set("n", "gq", builtin.diagnostics, bufopts)
end

return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    config = config,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
}
