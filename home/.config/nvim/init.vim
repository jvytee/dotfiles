set autochdir
set breakindent
set clipboard+=unnamedplus
set completeopt=menu,menuone,noselect
set cursorline
set linebreak
set mouse=a
set nofoldenable
set number
set signcolumn=yes
set smartcase
set termguicolors

set tabstop=8 expandtab
set softtabstop=2 shiftwidth=2
autocmd filetype python setlocal shiftwidth=4 softtabstop=4

call plug#begin(stdpath('data') . '/plugged')
  Plug 'romainl/flattened'
  Plug 'dracula/vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp' 
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'vim-python/python-syntax'
  Plug 'cespare/vim-toml'
  Plug 'LnL7/vim-nix'
  Plug 'lervag/vimtex'
call plug#end()

colorscheme dracula

lua << EOF
-- Import stuff
local nvim_lsp = require('lspconfig')
local cmp = require('cmp')

-- Setup LSP client
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local options = {
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
}

local servers = {
  gopls = { 'gopls' },
  pyright = { 'pyright-langserver', '--stdio' },
  rust_analyzer = { 'rust-analyzer' },
  tsserver = { 'npx', 'typescript-language-server', '--stdio' },
}

for server, cmd in pairs(servers) do
  options.cmd = cmd
  nvim_lsp[server].setup(options)
end

-- Setup autocompletion
cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
}
EOF

let mapleader = "\<space>"
let maplocalleader = "\<space>"

nnoremap <leader>f :FZF<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>g :GitFiles<cr>

