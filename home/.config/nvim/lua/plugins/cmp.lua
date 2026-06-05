local config = function()
    local cmp = require("cmp")
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.snippet.expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert {
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources(
            {
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "buffer" },
            },
            {
                { name = "nvim_lua" },
                { name = "vimtex" },
            }
        ),
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
    }
end

return {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "micangl/cmp-vimtex",
    { "hrsh7th/nvim-cmp", config = config }
}
