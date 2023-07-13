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
  (setq ivy-use-virtual-buffers t)
  :init (ivy-mode t))

(use-package direnv
  :config (direnv-mode))

(use-package display-line-numbers
  :hook ((conf-mode org-mode markdown-mode nxml-mode prog-mode tex-mode yaml-mode) . display-line-numbers-mode))

(use-package dockerfile-mode)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox 1)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  (setq doom-themes-neotree-file-icons t))

(use-package eglot
  :config
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "C-c h") 'eldoc-box-help-at-point)
  (define-key eglot-mode-map (kbd "C-c x d") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "C-c x r") 'xref-find-references)
  (define-key eglot-mode-map (kbd "C-c a") 'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c b") 'eglot-format-buffer)
  :hook ((go-mode python-mode rust-mode typescript-mode yaml-mode) . eglot-ensure))

(use-package eldoc-box)

(use-package evil
  :config (evil-mode 1))

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package geiser-guile)

(use-package go-mode
  :hook (go-mode . (lambda ()
                     (setq tab-width 2))))

(use-package groovy-mode)

(use-package haskell-mode)

(use-package highlight-indent-guides
  :config (highlight-indent-guides-auto-set-faces)
  :hook ((conf-mode nxml-mode prog-mode yaml-mode) . highlight-indent-guides-mode))

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("-|" "-~" "---" "-<<" "-<" "--" "->" "->>" "-->" "///" "/=" "/=="
                                      "/>" "//" "/*" "*>" "***" "*/" "<-" "<<-" "<=>" "<=" "<|" "<||"
                                      "<|||" "<|>" "<:" "<>" "<-<" "<<<" "<==" "<<=" "<=<" "<==>" "<-|"
                                      "<<" "<~>" "<=|" "<~~" "<~" "<$>" "<$" "<+>" "<+" "</>" "</" "<*"
                                      "<*>" "<->" "<!--" ":>" ":<" ":::" "::" ":?" ":?>" ":=" "::=" "=>>"
                                      "==>" "=/=" "=!=" "=>" "===" "=:=" "==" "!==" "!!" "!=" ">]" ">:"
                                      ">>-" ">>=" ">=>" ">>>" ">-" ">=" "&&&" "&&" "|||>" "||>" "|>" "|]"
                                      "|}" "|=>" "|->" "|=" "||-" "|-" "||=" "||" ".." ".?" ".=" ".-" "..<"
                                      "..." "+++" "+>" "++" "[||]" "[<" "[|" "{|" "??" "?." "?=" "?:" "##"
                                      "###" "####" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" ";;" "_|_"
                                      "__" "~~" "~~>" "~>" "~-" "~@" "$>" "^=" "]#"))
  (global-ligature-mode t))

(use-package magit
  :bind ("C-c g" . magit-file-dispatch))

(use-package markdown-mode)

(use-package meson-mode)

(use-package neotree
  :bind ("C-c t" . neotree-toggle)
  :hook (neotree-mode . (lambda () (doom-modeline-mode t))))

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

(use-package typescript-mode
  :config (setq typescript-indent-level 2))

(use-package web-mode)

(use-package which-key
  :config (which-key-mode 1))

(use-package yaml-mode)

(use-package yasnippet
  :config (yas-global-mode 1))

(defun set-gtk-theme-variant (variant)
  (let* ((ids (mapcar (lambda (frame) (frame-parameter frame 'outer-window-id)) (frame-list)))
         (cmds (mapcar (lambda (id) (format "xprop -f _GTK_THEME_VARIANT 8u -set _GTK_THEME_VARIANT \"%s\" -id %s" variant id)) ids)))
    (dolist (cmd cmds) (call-process-shell-command cmd))))

(defun gtk-dark () (interactive)
       (set-gtk-theme-variant "dark"))

(defun gtk-light () (interactive)
       (set-gtk-theme-variant "light"))

(add-hook 'server-after-make-frame-hook (lambda () (set-gtk-theme-variant "dark")))

(load custom-file)
