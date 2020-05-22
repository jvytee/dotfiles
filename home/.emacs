(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(eval-when-compile (require 'use-package))

(push (cons "\\*shell\\*" display-buffer--same-window-action) display-buffer-alist)
(global-unset-key (kbd "M-SPC"))

(use-package auctex
  :defer t
  :ensure t)

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  :custom
  (evil-want-C-u-scroll t))

(use-package evil-magit
  :ensure t)

(use-package ivy
  :ensure t
  :config
  (ivy-mode t))

(use-package lsp-mode
  :ensure t
  :bind-keymap ("M-SPC l" . lsp-command-map)
  :custom
  (lsp-rust-server 'rust-analyzer)
  :hook (c++-mode java-mode python-mode rust-mode (lsp-mode . lsp-enable-which-key-integration)))

(use-package lsp-ivy
  :ensure t)

(use-package lsp-java
  :ensure t)

(use-package lsp-ui
  :ensure t)

(use-package magit
  :ensure t
  :bind (("M-SPC g" . magit-status)
	 ("M-SPC M-g" . magit-dispatch)))

(use-package projectile
  :ensure t
  :bind ("M-SPC f" . projectile-find-file)
  :bind-keymap ("M-SPC p" . projectile-command-map)
  :config
  (projectile-mode t)
  :custom
  (projectile-completion-system 'ivy)
  (projectile-indexing-method 'hybrid))

(use-package pyvenv
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package shell-pop
  :ensure t
  :custom
  (shell-pop-universal-key "M-SPC s"))

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

(use-package yaml-mode
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode t))

(add-hook 'text-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(global-set-key (kbd "M-SPC c") (lambda () (interactive)
				  (find-file user-init-file)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(erc-nick "jvytee")
 '(global-display-line-numbers-mode t)
 '(initial-buffer-choice "~/Dokumente/notes/misc.org")
 '(python-shell-interpreter "ipython")
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-follow-symlinks t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 90 :width normal)))))
