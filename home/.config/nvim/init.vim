set autochdir
set breakindent
set clipboard+=unnamedplus
set cmdheight=2
set cursorline
set linebreak
set mouse=a
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

if has('nvim')
    call plug#begin('~/.local/share/nvim/vim-plug')
        Plug 'romainl/flattened'
        Plug 'joshdick/onedark.vim'
        Plug 'scrooloose/nerdtree'
        Plug 'junegunn/fzf', {
                    \ 'dir': '~/.fzf',
                    \ 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'Shougo/deoplete.nvim', {
                    \ 'do': ':UpdateRemotePlugins'
                    \ }
        Plug 'Shougo/echodoc.vim'
        Plug 'w0rp/ale'
        Plug 'octol/vim-cpp-enhanced-highlight'
        Plug 'vim-pandoc/vim-pandoc'
        Plug 'vim-pandoc/vim-pandoc-syntax'
        Plug 'lervag/vimtex'
        Plug 'chrisbra/Colorizer'
    call plug#end()
    
    set termguicolors
    colorscheme onedark
    
    nnoremap <leader>f :FZF<CR>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>g :GitFiles<CR>
    
    nnoremap <leader>nn :NERDTreeFocus<cr>
    nnoremap <leader>nt :NERDTreeToggle<cr>

    let g:deoplete#enable_at_startup = 1
    autocmd CompleteDone * silent! pclose!

    let g:echodoc#enable_at_startup = 1

    let g:ale_cpp_clangd_executable = 'clangd'
    let g:ale_python_black_options = '--line-length 120'
    let g:ale_linters = {
                \ 'python': ['pyls'],
                \ 'cpp': ['clangd'],
                \ 'rust': ['rls']
                \ }
    let g:ale_fixers = {
                \ 'python': ['black'],
                \ 'cpp': ['clang-format']
                \ }

    nnoremap <leader>ad :ALEGoToDefinition<cr>
    nnoremap <leader>ar :ALEFindReferences<cr>
    nnoremap <leader>ah :ALEHover<cr>
    nnoremap <leader>as :ALESymbolSearch<cr>
    nnoremap <leader>af :ALEFix<cr>

    call deoplete#custom#var('omni', 'input_patterns', {
                \ 'tex': g:vimtex#re#deoplete
                \ })
else
    syntax on
endif
