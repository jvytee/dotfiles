local config_colorscheme = function()
    vim.cmd "colorscheme tokyonight-night"
end

return {
    "ellisonleao/gruvbox.nvim",
    { "LnL7/vim-nix", ft = "nix" },
    { "cespare/vim-toml", ft = "toml" },
    { "folke/tokyonight.nvim", priority = 1000, config = config_colorscheme },
    { "lervag/vimtex", lazy = false },
    { "mfussenegger/nvim-ansible", ft = "yaml" },
}
