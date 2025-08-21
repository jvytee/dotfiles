local config_colorscheme = function()
    vim.cmd "colorscheme tokyonight"
end

return {
    "LnL7/vim-nix",
    "cespare/vim-toml",
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    { "folke/tokyonight.nvim", priority = 1000, config = config_colorscheme },
    "lervag/vimtex",
    "mfussenegger/nvim-ansible",
    { "navarasu/onedark.nvim", priority = 1000 },
}
