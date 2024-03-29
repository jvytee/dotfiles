local config_colorscheme = function()
  vim.cmd "colorscheme onedark"
end

return {
  "LnL7/vim-nix",
  "cespare/vim-toml",
  { "ellisonleao/gruvbox.nvim", priority = 60, config = config_colorscheme },
  "freitass/todo.txt-vim",
  "hrsh7th/vim-vsnip",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "lervag/vimtex",
  "lewis6991/gitsigns.nvim",
  { "navarasu/onedark.nvim", priority = 60, config = config_colorscheme },
}
