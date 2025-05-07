local config_colorscheme = function()
    vim.cmd "colorscheme gruvbox"
end

return {
    "LnL7/vim-nix",
    "cespare/vim-toml",
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = config_colorscheme },
    "hrsh7th/vim-vsnip",
    "lervag/vimtex",
}
