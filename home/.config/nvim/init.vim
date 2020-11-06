filetype indent plugin on
syntax on

set autochdir
set breakindent
set clipboard+=unnamedplus
set cmdheight=2
set cursorline
set linebreak
set mouse=a
set nocompatible
set nofoldenable
set number
set signcolumn=yes
set smartcase

set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

let mapleader = "\<space>"
let maplocalleader = "\<space>"

call plug#begin('~/.local/share/nvim/vim-plug')
Plug 'romainl/flattened'
Plug 'junegunn/seoul256.vim'
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh' }
Plug 'Shougo/deoplete.nvim', {
            \ 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', {
            \ 'dir': '~/.fzf',
            \ 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'freitass/todo.txt-vim'
Plug 'chrisbra/Colorizer'
call plug#end()

set termguicolors
let g:seoul256_background = 235
colorscheme seoul256

autocmd filetype javascript,json,yaml setlocal shiftwidth=2 softtabstop=2
let g:deoplete#enable_at_startup = 1

let g:LanguageClient_serverCommands = {
            \ 'python': ['pyls'],
            \ 'cpp': ['clangd'],
            \ 'rust': ['rust-analyzer'] }

nmap <leader>cc <Plug>(lcn-menu)
nmap <leader>ch <Plug>(lcn-hover)
nmap <leader>cR <Plug>(lcn-rename)
nmap <leader>cd <Plug>(lcn-definition)
nmap <leader>cr <Plug>(lcn-references)
nmap <leader>ci <Plug>(lcn-implementation)
nmap <leader>cF <Plug>(lcn-format)
nmap <leader>cn <Plug>(cln-diagnostics-next)
nmap <leader>cp <Plug>(cln-diagnostics-prev)

nnoremap <leader>f :FZF<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>g :GitFiles<cr>

nnoremap <leader>nn :NERDTreeFocus<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
