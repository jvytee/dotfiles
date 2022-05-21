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
  use 'navarasu/onedark.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = '0.5-compat',
    run = ':TSUpdate',
  }
  use 'neovim/nvim-lspconfig'
  use 'wbthomason/packer.nvim'
end)

-- Set colorscheme
require('onedark').load()

-- Setup autocompletion
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.call('vsnip#anonymous', args.body)
    end
  },
  mapping = cmp.mapping.preset.insert {
    ['<cr>'] = cmp.mapping.confirm { select = true }
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

-- Setup LSP client
local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local keymap_opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
  local function buf_set_keymap(keys, cmd)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', keys, '<cmd>' .. cmd .. '<cr>', keymap_opts)
  end

  buf_set_keymap('gD', 'lua vim.lsp.buf.declaration()')
  buf_set_keymap('gd', 'lua vim.lsp.buf.definition()')
  buf_set_keymap('K', 'lua vim.lsp.buf.hover()')
  buf_set_keymap('gi', 'lua vim.lsp.buf.implementation()')
  buf_set_keymap('<C-k>', 'lua vim.lsp.buf.signature_help()')
  buf_set_keymap('<localleader>wa', 'lua vim.lsp.buf.add_workspace_folder()')
  buf_set_keymap('<localleader>wr', 'lua vim.lsp.buf.remove_workspace_folder()')
  buf_set_keymap('<localleader>wl', 'lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))')
  buf_set_keymap('<localleader>D', 'lua vim.lsp.buf.type_definition()')
  buf_set_keymap('<localleader>rn', 'lua vim.lsp.buf.rename()')
  buf_set_keymap('<localleader>ca', 'lua vim.lsp.buf.code_action()')
  buf_set_keymap('gr', 'lua vim.lsp.buf.references()')
  buf_set_keymap('<localleader>e', 'lua vim.lsp.diagnostic.show_line_diagnostics()')
  buf_set_keymap('[d', 'lua vim.lsp.diagnostic.goto_prev()')
  buf_set_keymap(']d', 'lua vim.lsp.diagnostic.goto_next()')
  buf_set_keymap('<localleader>q', 'lua vim.lsp.diagnostic.set_loclist()')
  buf_set_keymap('<localleader>f', 'lua vim.lsp.buf.formatting()')
end

local options = {
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
  on_attach = on_attach,
}

local servers = {
  'ansiblels',
  'gopls',
  'hls',
  'pyright',
  'rust_analyzer',
  'tailwindcss',
  'tsserver',
  'volar',
  'yamlls',
}

for _, server in ipairs(servers) do
  nvim_lsp[server].setup(options)
end

-- Setup treesitter
local nvim_ts = require('nvim-treesitter.configs')
nvim_ts.setup {
  ensure_installed = {
    'haskell',
    'html',
    'javascript',
    'lua',
    'nix',
    'python',
    'rust',
    'typescript',
    'vue',
    'yaml',
  },
  highlight = { enable = true },
  indent = { enable = true },
}

-- Setup lualine
local lualine = require('lualine')
lualine.setup {
  extensions = {
    'fzf',
    'quickfix',
  },
  options = {
    icons_enabled = false,
    theme = 'gruvbox'
  }
}

-- Setup indent blankline
local indent_blankline = require('indent_blankline')
indent_blankline.setup {
  show_current_context = true,
  show_current_context_start = true,
}

-- Set keymaps
local function set_keymap(keys, cmd)
  vim.api.nvim_set_keymap('n', keys, '<cmd>' .. cmd .. '<cr>', keymap_opts)
end

set_keymap('<leader>b', 'Buffers')
set_keymap('<leader>f', 'FZF')
set_keymap('<leader>g', 'GitFiles')
set_keymap('<leader>r', 'Rg')
set_keymap('<leader>m', 'Maps')
