(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(use-package better-defaults)

(use-package company
  :hook (after-init . global-company-mode))

(use-package counsel
  :bind ("C-c i" . swiper-isearch)
  :commands ivy-mode
  :config
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-use-virtual-buffers t))

(use-package evil
  :config (evil-mode 1))

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package go-mode)

(use-package lsp-ivy
  :bind ("C-c s" . lsp-ivy-workspace-symbol)
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-mode
  :commands lsp
  :hook
  (((go-mode javascript-mode python-mode rust-mode yaml-mode) . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :init (setq lsp-keymap-prefix "C-SPC"))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package magit
  :bind ("C-c g" . magit-file-dispatch))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package projectile
  :bind ("C-c f" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config (projectile-mode +1))

(use-package simple-modeline
  :config (simple-modeline-mode))

(use-package solarized-theme)

(use-package virtualenvwrapper
  :config
  (venv-initialize-eshell)
  (venv-initialize-interactive-shells)
  (setq venv-location "~/.local/share/virtualenvs"))

(use-package which-key
  :config (which-key-mode 1))

(use-package yaml-mode)

(add-hook 'conf-mode-hook 'display-line-numbers-mode)
(add-hook 'org-mode-hook 'display-line-numbers-mode)
(add-hook 'markdown-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'yaml-mode-hook 'display-line-numbers-mode)

(load custom-file)
