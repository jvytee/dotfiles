(defun find-agenda-files (root)
  (let ((subdirs '("00 Daily" "01 Projects" "02 Areas" "03 Resources")))
    (mapcan (lambda (subdir) (directory-files-recursively (concat root "/" subdir) ".org$")) subdirs)))

(use-package emacs
  :custom
  (column-number-mode t)
  (context-menu-mode t)
  (css-indent-offset 2)
  (default-frame-alist '((horizontal-scroll-bars) (vertical-scroll-bars)))
  (enable-recursive-minibuffers t)
  (font-use-system-font t)
  (gc-cons-threshold 32000000)
  (inhibit-startup-screen t)
  (ispell-dictionary "en_GB")
  (js-indent-level 2)
  (nxml-slash-auto-complete-flag t)
  (org-directory "~/notes")
  (org-agenda-files (find-agenda-files org-directory))
  (org-babel-load-languages '((emacs-lisp . t) (python . t)))
  (pixel-scroll-precision-mode t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (tab-width 4)
  (tool-bar-mode nil)
  (vc-follow-symlinks nil)
  (warning-minimum-level :error)
  (window-sides-vertical t)
  (xterm-mouse-mode t))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(require 'use-package-ensure)
(setopt use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(use-package all-the-icons)

(use-package auctex-latexmk
  :init (auctex-latexmk-setup))

(use-package better-defaults)

(use-package centaur-tabs
  :config
  (setopt centaur-tabs-height 32
          centaur-tabs-set-modified-marker t)
  (centaur-tabs-change-fonts
   (face-attribute 'variable-pitch :family)
   (face-attribute 'variable-pitch :height))
  (centaur-tabs-group-by-projectile-project)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  :hook (after-init . centaur-tabs-mode))

(use-package vertico
  :custom
  (vertico-cycle t)
  (vertico-resize t)
  :init (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

(use-package marginalia
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

(use-package consult
  :bind ("C-x b" . consult-buffer)
  :config (setopt completion-in-region-function #'consult-completion-in-region))

(use-package corfu
  :init
  (setopt global-corfu-minibuffer nil)
  (global-corfu-mode)
  :config
  (setopt corfu-auto t
          corfu-auto-dealy 0.5
          corfu-auto-trigger "."
          corfu-quit-no-match t))

(use-package dape
  :preface (setopt dape-key-prefix "\M-d")
  :custom
  (dape-breakpoint-global-mode +1)
  (dape-cwd-function 'projectile-project-root))

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
  (let ((dark-theme 'doom-tokyo-night)
        (light-theme 'doom-one-light))
    (load-theme (if (dark-theme-p)
                    dark-theme
                  light-theme)
                1))
  (setopt doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package eglot
  :after evil
  :config
  (setopt eglot-events-buffer-config '(:size 0))
  (add-to-list 'eglot-server-programs
               '((python-ts-mode python-mode) . ,(eglot-alternatives
                                                  '(("ty" "server")
                                                    ("ruff" "server")))))
  (add-to-list 'eglot-server-programs
               `((yaml-ts-mode yaml-mode) . ,(eglot-alternatives
                                              '(("yaml-language-server" "--stdio")
                                                ("ansible-language-server" "--stdio")))))
  (setq-default eglot-workspace-configuration '(:gopls
                                                (:hints
                                                 (:assignVariableTypes t
                                                  :compositeLiteralFields t
                                                  :compositeLiteralTypes t
                                                  :constantValues t
                                                  :functionTypeParameters t
                                                  :parameterName t
                                                  :rangeVariableTypes t))
                                                :rust-analyzer
                                                (:initializationOptions
                                                 (:check
                                                  (:command "clippy")))))
  (evil-define-key 'normal eglot-mode-map (kbd "g d") 'xref-find-definitions)
  (evil-define-key 'normal eglot-mode-map (kbd "g r") 'xref-find-references)
  (evil-define-key 'normal eglot-mode-map (kbd "g D") 'eglot-find-declaration)
  (evil-define-key 'normal eglot-mode-map (kbd "g I") 'eglot-find-implementation)
  (evil-define-key 'normal eglot-mode-map (kbd "g T") 'eglot-find-typeDefinition)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> a") 'eglot-code-actions)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> r") 'eglot-rename)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> f") 'eglot-format-buffer)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> o") 'eglot-code-action-organize-imports)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> h") 'eldoc-box-help-at-point)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> q") 'eldoc-box-quit-frame)
  (evil-define-key 'normal eglot-mode-map (kbd "g q") 'flymake-show-project-diagnostics)
  :hook
  ((go-mode
    haskell-mode
    java-mode
    javascript-mode
    nix-mode
    python-mode
    rust-mode
    terraform-mode
    typescript-ts-mode
    web-mode
    yaml-mode) . eglot-ensure))

(use-package eldoc-box
  :config
  (setq eldoc-echo-area-prefer-doc-buffer t)
  (setq eldoc-echo-area-use-multiline-p nil))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (evil-set-leader 'normal (kbd "SPC")))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package geiser-guile)

(use-package go-mode)

(use-package groovy-mode)

(use-package haskell-mode)

(use-package helpful
  :config
  (setopt counsel-describe-function-function #'helpful-callable
          counsel-describe-variable-function #'helpful-variable)
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
  (setopt highlight-indent-guides-method (if (display-graphic-p) 'bitmap 'character)
          highlight-indent-guides-responsive 'top)
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
  :config (setopt markdown-hide-urls t)
  :hook (markdown-mode . flyspell-mode))

(use-package meson-mode)

(use-package nginx-mode)

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package ob-mermaid
  :config (setopt ob-mermaid-cli-path "/usr/bin/mmdc"))

(use-package obsidian
  :config
  (obsidian-backlinks-mode t)
  :custom
  (obsidian-directory "~/notes")
  (obsidian-inbox-directory "00 Daily")
  (markdown-enable-wiki-links t)
  :bind (:map obsidian-mode-map
              ("C-c C-n" . obsidian-capture)
              ("C-c C-l" . obsidian-insert-wikilink)
              ("C-c C-o" . obsidian-follow-link-at-point)
              ("C-c C-p" . obsidian-jump)
              ("C-c C-b" . obsidian-backlink-jump)))

(use-package pipenv
  :config (setopt pipenv-executable "~/.local/bin/pipenv")
  :hook (python-mode . pipenv-mode))

(use-package projectile
  :after (vertico)
  :bind ("C-c f" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :custom (projectile-completion-system 'default)
  :config
  (projectile-mode +1))

(use-package rainbow-mode)

(use-package repeat
  :custom (repeat-mode +1))

(use-package rg
  :config (rg-enable-default-bindings))

(use-package rust-mode
  :init (setq rust-mode-treesitter-derive t)
  :config (setopt indent-tabs-mode nil))

(use-package sicp)

(use-package sops
  :hook ((yaml-mode js-json-mode) . sops-mode))

(use-package sql-indent)

(use-package terraform-mode)

(use-package tex
  :ensure auctex
  :config
  (setopt TeX-auto-save t
          TeX-PDF-mode t))

(use-package treemacs
  :defer t
  :bind ("C-c t" . treemacs)
  :config (setopt treemacs-indent-guide-mode 1))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :config (treemacs-project-follow-mode))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package vterm)

(use-package web-mode
  :config
  (setopt web-mode-engines-alist '(("django" . "\\.html\\'"))
          web-mode-markup-indent-offset 2)
  :mode (("\\.html?\\'" . web-mode)))

(use-package which-key
  :config (which-key-mode 1))

(use-package yaml-mode)

(use-package yasnippet
  :config (yas-global-mode 1))
