(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

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
  (setq ivy-use-virtual-buffers t)
  :init (ivy-mode t))

(use-package direnv
  :config (direnv-mode))

(use-package display-line-numbers
  :hook ((conf-mode LaTeX-mode org-mode markdown-mode nxml-mode prog-mode yaml-mode) . display-line-numbers-mode))

(use-package docker
  :bind ("C-c d" . docker)
  :config (setq docker-compose-command "docker compose"))

(use-package dockerfile-mode)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(defun dark-theme-p ()
  (let* ((gtk-theme (getenv "GTK_THEME"))
         (color-scheme (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme"))
         (dark-gtk-theme-p (and
                            gtk-theme
                            (string-match-p "dark" gtk-theme)))
         (dark-color-scheme-p (and
                               color-scheme
                               (string-match-p "prefer-dark" color-scheme)))
         (terminal-p (not (display-graphic-p))))
    (or
     dark-gtk-theme-p
     dark-color-scheme-p
     terminal-p)))

(use-package doom-themes
  :config
  (let ((dark-theme 'doom-gruvbox)
        (light-theme 'leuven))
    (load-theme (if (dark-theme-p)
                    dark-theme
                  light-theme)
                1))
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package eglot
  :config
  (setq eglot-events-buffer-size 0)
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) .
                                        ("rust-analyzer" :initializationOptions (:check (:command "clippy")))))
  (add-to-list 'eglot-server-programs '((yaml-ts-mode yaml-mode) . ("/usr/bin/ansible-language-server" "--stdio")))
  (setq-default eglot-workspace-configuration '(:gopls (:hints (:assignVariableTypes t
                                                                :compositeLiteralFields t
                                                                :compositeLiteralTypes t
                                                                :constantValues t
                                                                :functionTypeParameters t
                                                                :parameterName t
                                                                :rangeVariableTypes t))))
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> r") 'eglot-rename)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> o") 'eglot-code-action-organize-imports)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> h") 'eldoc-box-help-at-point)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> q") 'eldoc-box-quit-frame)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> x d") 'xref-find-definitions)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> x r") 'xref-find-references)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> a") 'eglot-code-actions)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> f") 'eglot-format-buffer)
  :hook ((haskell-mode go-mode java-mode javascript-mode nix-mode python-mode rust-mode terraform-mode typescript-mode web-mode yaml-mode) . eglot-ensure))

(use-package eldoc-box
  :config
  (setq eldoc-echo-area-prefer-doc-buffer t)
  (setq eldoc-echo-area-use-multiline-p nil))

(use-package evil
  :config
  (evil-mode 1)
  (evil-set-leader nil (kbd "C-SPC"))
  (evil-set-leader 'normal (kbd "SPC"))
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t))

(use-package evil-collection
  :after evil
  :config (evil-collection-init '(flycheck info magit xref)))

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package flycheck-eglot
  :after (flycheck eglot)
  :config (global-flycheck-eglot-mode 1))

(use-package gcmh
  :config (gcmh-mode 1))

(use-package geiser-guile)

(use-package go-mode
  :hook (before-save . eglot-format-buffer))

(use-package groovy-mode)

(use-package haskell-mode)

(use-package helpful
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  :bind
  ("C-h f" . helpful-callable)
  ("C-h v" . helpful-variable)
  ("C-h k" . helpful-key)
  ("C-h x" . helpful-command)
  ("C-c C-d" . helpful-at-point)
  ("C-h F" . helpful-function))

(use-package highlight-indent-guides
  :config
  (highlight-indent-guides-auto-set-faces)
  (setq highlight-indent-guides-method (if (display-graphic-p) 'bitmap 'character))
  (setq highlight-indent-guides-responsive 'top)
  :hook ((conf-mode nxml-mode prog-mode yaml-mode) . highlight-indent-guides-mode))

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                                       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  (global-ligature-mode t))

(use-package lua-mode)

(use-package magit
  :bind ("C-c g" . magit-file-dispatch))

(use-package markdown-mode
  :hook (markdown-mode . flyspell-mode))

(use-package meson-mode)

(use-package nginx-mode)

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package ob-mermaid
  :config (setq ob-mermaid-cli-path "/usr/bin/mmdc"))

(use-package pipenv
  :config (setq pipenv-executable "~/.local/bin/pipenv")
  :hook (python-mode . pipenv-mode))

(use-package projectile
  :bind ("C-c f" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config (projectile-mode +1))

(use-package python-mode
  :config (setq flycheck-eglot-exclusive nil))

(use-package rainbow-mode)

(use-package rg
  :config (rg-enable-default-bindings))

(use-package rust-mode
  :init (setq rust-mode-treesitter-derive t)
  :config (setq indent-tabs-mode nil))

(use-package sicp)

(use-package sql-indent)

(use-package terraform-mode)

(use-package tex
  :ensure auctex)

(use-package treemacs
  :defer t
  :bind ("C-c t" . treemacs)
  :config (setq treemacs-indent-guide-mode 1))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :config (treemacs-project-follow-mode))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package typescript-mode
  :config (setq typescript-indent-level 2))

(use-package vterm)

(use-package web-mode
  :config (setq web-mode-engines-alist '(("django" . "\\.html\\'")))
  :mode (("\\.html?\\'" . web-mode)))

(use-package which-key
  :config (which-key-mode 1))

(use-package yaml-mode)

(use-package yasnippet
  :config (yas-global-mode 1))

(defun find-agenda-files (root)
  (let ((subdirs '("00 Daily" "01 Projects" "02 Areas" "03 Resources")))
    (mapcan (lambda (subdir) (directory-files-recursively (concat root "/" subdir) ".org$")) subdirs)))

(load custom-file)
