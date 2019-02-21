set autochdir
set breakindent
set clipboard+=unnamedplus
set cursorline
set ignorecase
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

if has('nvim')
    call plug#begin('~/.local/share/nvim/vim-plug')
        Plug 'jvytee/flattened'
        Plug 'junegunn/fzf', {
                    \ 'dir': '~/.fzf',
                    \ 'do': './install --all'
                    \ }
        Plug 'Shougo/deoplete.nvim', {
                    \ 'do': ':UpdateRemotePlugins'
                    \ }
        Plug 'autozimu/LanguageClient-neovim', {
                    \ 'branch': 'next',
                    \ 'do': 'bash install.sh'
                    \ }
        Plug 'octol/vim-cpp-enhanced-highlight'
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'vim-pandoc/vim-pandoc'
        Plug 'vim-pandoc/vim-pandoc-syntax'
        Plug 'lervag/vimtex'
        Plug 'jceb/vim-orgmode'
    call plug#end()
    
    set termguicolors
    colorscheme flattened_dark
    
    nnoremap <leader>f :FZF<CR>

    let g:deoplete#enable_at_startup = 1
    let g:LanguageClient_serverCommands = {
                \ 'cpp': ['clangd-6.0'],
                \ 'go': ['golsp'],
                \ 'python': ['pyls']
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
        autocmd FileType cpp,c,python call SetLSPShortcuts()
    augroup END

    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
else
    syntax on
endif
