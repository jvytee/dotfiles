-- Set general options
vim.opt.autochdir = true
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.cursorline = true
vim.opt.foldenable = false
vim.opt.linebreak = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.termguicolors = true

-- Configure indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 8
vim.cmd('autocmd filetype go setlocal noexpandtab tabstop=2')
vim.cmd('autocmd filetype python setlocal shiftwidth=4 softtabstop=4')

-- Set leader keys
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Specify plugins using packer
local packer = require('packer')
packer.startup(function()
  use 'LnL7/vim-nix'
  use 'Yggdroot/indentLine'
  use 'cespare/vim-toml'
  use 'ellisonleao/gruvbox.nvim'
  use 'freitass/todo.txt-vim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/nvim-cmp' 
  use 'hrsh7th/vim-vsnip'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'lervag/vimtex'
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'neovim/nvim-lspconfig'
  use 'wbthomason/packer.nvim'
end)

-- Set colorscheme
vim.cmd('colorscheme gruvbox')

-- Setup autocompletion
require('setup.cmp').setup()

-- Setup LSP client
local keymap_opts = { noremap = true, silent = true }
require('setup.lspconfig').setup(keymap_opts)

-- Setup treesitter
require('setup.nvim-treesitter').setup()

-- Setup lualine
require('setup.lualine').setup()

-- Setup indent blankline
require('setup.indent_blankline').setup()

-- Set keymaps
local function set_keymap(keys, cmd)
  vim.api.nvim_set_keymap('n', keys, '<cmd>' .. cmd .. '<cr>', keymap_opts)
end

set_keymap('<leader>b', 'Buffers')
set_keymap('<leader>f', 'FZF')
set_keymap('<leader>g', 'GitFiles')
set_keymap('<leader>r', 'Rg')
set_keymap('<leader>m', 'Maps')
