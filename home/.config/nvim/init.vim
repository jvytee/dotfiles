set autochdir
set breakindent
set clipboard+=unnamedplus
set cmdheight=2
set cursorline
set hidden
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
        Plug 'junegunn/fzf', {
                    \ 'dir': '~/.fzf',
                    \ 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'Shougo/deoplete.nvim', {
                    \ 'branch': '4.1',
                    \ 'do': ':UpdateRemotePlugins'
                    \ }
        Plug 'Shougo/echodoc.vim'
        Plug 'autozimu/LanguageClient-neovim', {
                    \ 'branch': 'next',
                    \ 'do': 'bash install.sh'
                    \ }
        Plug 'vim-pandoc/vim-pandoc'
        Plug 'vim-pandoc/vim-pandoc-syntax'
        Plug 'lervag/vimtex'
    call plug#end()
    
    set termguicolors
    colorscheme flattened_dark
    
    nnoremap <leader>f :FZF<CR>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>g :GitFiles<CR>

    let g:deoplete#enable_at_startup = 1
    autocmd CompleteDone * silent! pclose!

    let g:echodoc#enable_at_startup = 1

    let g:LanguageClient_useVirtualText = 0
    let g:LanguageClient_serverCommands = {
                \ 'cpp': ['clangd-6.0'],
                \ 'python': ['pyls'],
                \ 'rust': ['rls']
                \ }
    
    function! SetLSPShortcuts()
        nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
        nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
        nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
        nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
        nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
        nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
        nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
        nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
        nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
        nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
    endfunction()
    
    augroup LSP
        autocmd!
        autocmd FileType c,cpp,python,rust call SetLSPShortcuts()
    augroup END

    call deoplete#custom#var('omni', 'input_patterns', {
                \ 'tex': g:vimtex#re#deoplete
                \ })
else
    syntax on
endif
