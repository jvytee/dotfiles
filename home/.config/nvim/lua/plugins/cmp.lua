local config = function()
    local cmp = require("cmp")
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.call("vsnip#anonymous", args.body)
            end
        },
        mapping = cmp.mapping.preset.insert {
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<cr>"] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources(
            {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "vsnip" },
            },
            {
                { name = "path" },
                { name = "buffer" },
            }
        ),
        window = {
            completion = cmp.config.bordered,
            documentation = cmp.config.bordered,
        },
    }
end

return {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip",
    { "hrsh7th/nvim-cmp", config = config }
}
