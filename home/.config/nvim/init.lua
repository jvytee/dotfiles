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
vim.opt.updatetime = 1000

-- Configure indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 8

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 2
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end
})

-- Set leader keys
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Specify plugins using packer
local packer = require('packer')
packer.startup(function()
  use 'LnL7/vim-nix'
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
  use 'lewis6991/gitsigns.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'Mofiqul/vscode.nvim'
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use 'nvim-tree/nvim-tree.lua'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'wbthomason/packer.nvim'
end)

-- Set colorscheme
vim.cmd [[colorscheme gruvbox]]

-- Setup autocompletion
require('setup.cmp').setup()

-- Setup gitsigns
require('gitsigns').setup()

-- Setup indent blankline
require('setup.indent_blankline').setup()

-- Setup lualine
require('setup.lualine').setup()

-- Setup LSP client
require('setup.lspconfig').setup()

-- Setup tree
require('setup.tree').setup()

-- Setup treesitter
require('setup.treesitter').setup()

-- Set keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>b', '<cmd>Buffers<cr>', opts)
vim.keymap.set('n', '<leader>f', '<cmd>FZF<cr>', opts)
vim.keymap.set('n', '<leader>g', '<cmd>GitFiles<cr>', opts)
vim.keymap.set('n', '<leader>r', '<cmd>Rg<cr>', opts)
vim.keymap.set('n', '<leader>m', '<cmd>Maps<cr>', opts)
vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeFocus<cr>', opts)

vim.keymap.set('n', '<localleader>b', '<cmd>!black %<cr>', opts)
