(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(use-package all-the-icons)

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

(use-package evil
  :config (evil-mode 1))

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package go-mode)

(use-package highlight-indentation
  :hook ((python-mode yaml-mode) . highlight-indentation-mode))

(use-package lsp-ivy
  :bind ("C-c s" . lsp-ivy-workspace-symbol)
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-mode
  :commands lsp
  :hook
  (((go-mode javascript-mode python-mode rust-mode typescript-mode vue-mode yaml-mode) . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :init (setq lsp-keymap-prefix "C-SPC"))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package magit
  :bind ("C-c g" . magit-file-dispatch))

(use-package neotree
  :bind ("C-c t" . neotree-toggle)
  :config (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

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

(use-package simple-modeline
  :config (simple-modeline-mode))

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
