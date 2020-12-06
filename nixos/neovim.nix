with import <nixpkgs> {};


neovim.override {
  configure = {
    customRC = ''
      set autochdir
      set breakindent
      set clipboard+=unnamedplus
      set cursorline
      set linebreak
      set mouse=a
      set nofoldenable
      set number
      set signcolumn=yes
      set smartcase

      set tabstop=8 expandtab
      set softtabstop=4 shiftwidth=4

      set termguicolors
      colorscheme NeoSolarized

      autocmd filetype html,css,javascript,xml,json,yaml,conf setlocal shiftwidth=2 softtabstop=2

      let g:deoplete#enable_at_startup = 1
      let g:LanguageClient_serverCommands = {
                  \ 'python': ['pyls'],
                  \ 'cpp': ['clangd'],
                  \ 'rust': ['rust-analyzer'],
                  \ 'javascript': ['typescript-language-server', '--stdio'] }

      let mapleader = "\<space>"
      let maplocalleader = "\<space>"

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
    '';

    packages.neovim-custom = with pkgs.vimPlugins; {
      start = [
        LanguageClient-neovim
        NeoSolarized
        deoplete-nvim
        fzf-vim
        nerdtree
        todo-txt-vim
        vim-cpp-enhanced-highlight
        vim-nix
        #vimtex
      ];
    };
  };
}
