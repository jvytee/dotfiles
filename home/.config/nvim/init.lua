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

-- Configure vim-plug
local Plug = vim.fn['plug#']
vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')
  Plug 'LnL7/vim-nix'
  Plug 'cespare/vim-toml'
  Plug 'dracula/vim'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/nvim-cmp' 
  Plug 'hrsh7th/vim-vsnip'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'lervag/vimtex'
  Plug 'neovim/nvim-lspconfig'
  Plug('nvim-treesitter/nvim-treesitter', {
    ['branch'] = '0.5-compat',
    ['do'] = vim.fn.TSUpdate,
  })
  Plug 'romainl/flattened'
  Plug 'vim-python/python-syntax'
vim.call('plug#end')

-- Set colorscheme
vim.cmd('colorscheme dracula')

-- Setup autocompletion
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.call('vsnip#anonymous', args.body)
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
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
  gopls = { 'gopls' },
  pyright = { 'pyright-langserver', '--stdio' },
  rnix = { 'rnix-lsp' },
  rust_analyzer = { 'rust-analyzer' },
  tailwindcss = { 'npx', 'tailwindcss-language-server', '--stdio' },
  tsserver = { 'npx', 'typescript-language-server', '--stdio' },
  vuels = { 'npx', 'vls' },
}

for server, cmd in pairs(servers) do
  options.cmd = cmd
  nvim_lsp[server].setup(options)
end

-- Setup treesitter
local nvim_ts = require('nvim-treesitter.configs')
nvim_ts.setup {
  ensure_installed = { 'html', 'javascript', 'lua', 'nix', 'python', 'rust', 'typescript', 'vue' },
  highlight = { enable = true },
  indent = { enable = true },
}

-- Set keymaps
local function set_keymap(keys, cmd)
  vim.api.nvim_set_keymap('n', keys, '<cmd>' .. cmd .. '<cr>', keymap_opts)
end

set_keymap('<leader>b', 'Buffers')
set_keymap('<leader>f', 'FZF')
set_keymap('<leader>g', 'GitFiles')
