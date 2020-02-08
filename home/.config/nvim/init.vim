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

set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let mapleader = "\<space>"
let maplocalleader = "\<space>"

call plug#begin('~/.local/share/nvim/vim-plug')
Plug 'romainl/flattened'
Plug 'morhetz/gruvbox'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', {
            \ 'dir': '~/.fzf',
            \ 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
Plug 'chrisbra/Colorizer'
call plug#end()

set termguicolors
colorscheme gruvbox

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

nnoremap <leader>ad :ALEGoToDefinition<cr>
nnoremap <leader>ar :ALEFindReferences<cr>
nnoremap <leader>ah :ALEHover<cr>
nnoremap <leader>as :ALESymbolSearch<cr>
nnoremap <leader>af :ALEFix<cr>

nnoremap <leader>f :FZF<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :GitFiles<CR>

nnoremap <leader>nn :NERDTreeFocus<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
