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
Plug 'morhetz/gruvbox'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', {
            \ 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', {
            \ 'dir': '~/.fzf',
            \ 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'chrisbra/Colorizer'
Plug 'octol/vim-cpp-enhanced-highlight'
call plug#end()

set termguicolors
colorscheme gruvbox

autocmd CompleteDone * silent! pclose!
let g:deoplete#enable_at_startup = 1

let g:ale_python_black_options = '--line-length 120'
let g:ale_linters = {
            \ 'python': ['pyls'],
            \ 'cpp': ['clangd'],
            \ 'rust': ['rls']
            \ }
let g:ale_fixers = {
            \ 'python': ['black'],
            \ 'cpp': ['clang-format'],
            \ 'rust': ['rustfmt']
            \ }

nnoremap <leader>aR :ALERename<cr>
nnoremap <leader>aD :ALEDetail<cr>
nnoremap <leader>ad :ALEGoToDefinition<cr>
nnoremap <leader>af :ALEFix<cr>
nnoremap <leader>ah :ALEHover<cr>
nnoremap <leader>ar :ALEFindReferences<cr>
nnoremap <leader>as :ALESymbolSearch<cr>

nnoremap <leader>f :FZF<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>g :GitFiles<cr>

nnoremap <leader>nn :NERDTreeFocus<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
