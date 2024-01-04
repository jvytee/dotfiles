(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
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
  (setq ivy-use-virtual-buffers t)
  :init (ivy-mode t))

(use-package direnv
  :config (direnv-mode))

(use-package display-line-numbers
  :hook ((conf-mode org-mode markdown-mode nxml-mode prog-mode tex-mode yaml-mode) . display-line-numbers-mode))

(use-package docker
  :bind ("C-c d" . docker)
  :config (setq docker-compose-command "docker compose"))

(use-package dockerfile-mode)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox 1)
  (doom-themes-org-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(java-mode . ("~/.local/bin/jdtls")))
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) .
                                        ("rust-analyzer" :initializationOptions (:check (:command "clippy")))))
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> r") 'eglot-rename)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> o") 'eglot-code-action-organize-imports)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> h") 'eldoc-box-help-at-point)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> x d") 'xref-find-definitions)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> x r") 'xref-find-references)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> a") 'eglot-code-actions)
  (evil-define-key 'normal eglot-mode-map (kbd "<leader> f") 'eglot-format-buffer)
  :hook ((haskell-mode go-mode java-mode python-mode rust-mode typescript-mode yaml-mode) . eglot-ensure))

(use-package eldoc-box)

(use-package evil
  :config
  (evil-mode 1)
  (evil-set-leader nil (kbd "C-SPC"))
  (evil-set-leader 'normal (kbd "SPC")))

(use-package evil-collection
  :config (evil-collection-init 'magit))

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package go-mode
  :config
  (let* ((user-home (getenv "HOME"))
         (go-version "1.21.5")
         (go-root (concat user-home "/sdk/go" go-version))
         (sdk-bin (concat go-root "/bin")))
    (when (file-directory-p go-root)
      (setenv "GOROOT" go-root)
      (setq exec-path (append (list "~/go/bin" sdk-bin) exec-path))))
  :hook (go-mode . (lambda ()
                     (setq tab-width 2))))

(use-package groovy-mode)

(use-package haskell-mode)

(use-package highlight-indent-guides
  :config (highlight-indent-guides-auto-set-faces)
  :hook ((conf-mode nxml-mode prog-mode yaml-mode) . highlight-indent-guides-mode))

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("-<<" "-<" "-<-" "<--" "<---" "<<-" "<-" "->" "->>" "-->" "--->" "->-" ">-" ">>-"
                                       "=<<" "=<" "=<=" "<==" "<===" "<<=" "<=" "=>" "=>>" "==>" "===>" "=>=" ">=" ">>="
                                       "<->" "<-->" "<--->" "<---->" "<=>" "<==>" "<===>" "<====>" "::" ":::" "__"
                                       "<~~" "</" "</>" "/>" "~~>" "==" "!=" "/=" "~=" "<>" "===" "!==" "!===" "=/=" "=!="
                                       "<:" ":=" "*=" "*+" "<*" "<*>" "*>" "<|" "<|>" "|>" "<." "<.>" ".>" "+*" "=*" "=:" ":>"
                                       "(*" "*)" "/*" "*/" "[|" "|]" "{|" "|}" "++" "+++" "\\/" "/\\" "|-" "-|" "<!--" "<!---"))
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

(use-package pipenv
  :config (setq pipenv-executable "~/.local/bin/pipenv")
  :hook (python-mode . pipenv-mode))

(use-package projectile
  :bind ("C-c f" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config (projectile-mode +1))

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

(use-package treemacs
  :defer t
  :bind ("C-c t" . treemacs))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :config (treemacs-project-follow-mode))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package typescript-mode
  :config (setq typescript-indent-level 2))

(use-package web-mode)

(use-package which-key
  :config (which-key-mode 1))

(use-package yaml-mode)

(use-package yasnippet
  :config (yas-global-mode 1))

(load custom-file)
