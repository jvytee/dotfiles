(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(use-package all-the-icons)

(use-package auctex-latexmk
  :init (auctex-latexmk-setup))

(use-package better-defaults)

(use-package company
  :hook (after-init . global-company-mode))

(use-package counsel
  :bind ("C-c i" . swiper-isearch)
  :commands ivy-mode
  :config
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-use-virtual-buffers t))

(use-package direnv
  :config (direnv-mode))

(use-package display-line-numbers
  :hook ((conf-mode org-mode markdown-mode prog-mode vue-mode yaml-mode) . display-line-numbers-mode))

(use-package dockerfile-mode)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox 1)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(use-package evil
  :config (evil-mode 1))

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package go-mode
  :hook (go-mode . (lambda ()
                     (setq tab-width 2))))

(use-package haskell-mode)

(use-package highlight-indent-guides
  :config (highlight-indent-guides-auto-set-faces)
  :hook ((conf-mode prog-mode yaml-mode) . highlight-indent-guides-mode))

(use-package lsp-haskell
  :after lsp-mode)

(use-package lsp-ivy
  :bind ("C-c s" . lsp-ivy-workspace-symbol)
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook
  (((go-mode haskell-mode javascript-mode rust-mode typescript-mode vue-mode yaml-mode) . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

(use-package lsp-pyright
  :hook
  (python-mode . (lambda ()
                   (require 'lsp-pyright)
                   (lsp-deferred))))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package magit
  :bind ("C-c g" . magit-file-dispatch))

(use-package neotree
  :bind ("C-c t" . neotree-toggle))

(use-package nginx-mode)

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package projectile
  :bind ("C-c f" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config (projectile-mode +1))

(use-package pyvenv)

(use-package rainbow-mode)

(use-package rg
  :config (rg-enable-default-bindings))

(use-package rust-mode)

(use-package tex
  :ensure auctex)

(use-package tree-sitter
  :config (global-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs)

(use-package typescript-mode)

(use-package vue-mode)

(use-package which-key
  :config (which-key-mode 1))

(use-package yaml-mode)

(add-hook 'window-setup-hook 'raise-frame)
(add-hook 'server-after-make-frame-hook 'raise-frame)

(load custom-file)
