return {
    {
        "Julian/lean.nvim",
        event = { "BufReadPre *.lean", "BufNewFile *.lean" },

        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },

        -- see details below for full configuration options
        opts = {
            mappings = true,
        }
    }
}
