local config_colorscheme = function()
    require("onedark").load()
end

return {
    "LnL7/vim-nix",
    "cespare/vim-toml",
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = config_colorscheme },
    "lervag/vimtex",
    "mfussenegger/nvim-ansible",
    { "navarasu/onedark.nvim", priority = 1000, config = config_colorscheme },
}
