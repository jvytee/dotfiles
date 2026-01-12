local config_colorscheme = function()
    vim.cmd "colorscheme tokyonight-night"
end

return {
    "LnL7/vim-nix",
    "cespare/vim-toml",
    "ellisonleao/gruvbox.nvim",
    "lervag/vimtex",
    "mfussenegger/nvim-ansible",
    { "folke/tokyonight.nvim", priority = 1000, config = config_colorscheme },
}
