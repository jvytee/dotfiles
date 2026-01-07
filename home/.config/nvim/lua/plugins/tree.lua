local config = function()
    local tree = require("nvim-tree")
    tree.setup {
        renderer = {
            add_trailing = true,
            group_empty = true,
            highlight_git = true,
            highlight_opened_files = "all",
        },
        update_focused_file = {
            enable = true,
            update_root = true,
        },
        view = {
            width = 32,
        },
    }

    vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeFocus<cr>", { noremap = true, silent = true })
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = config
}
