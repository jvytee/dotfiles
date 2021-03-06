(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(eval-when-compile (require 'use-package))

(use-package better-defaults)

(use-package evil
  :config
  (evil-mode 1))

(use-package ivy
  :config
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-use-virtual-buffers t)
  (ivy-mode 1))

(use-package lsp-ivy
  :bind ("C-c s" . lsp-ivy-workspace-symbol)
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-SPC")
  :hook
  ((javascript-mode . lsp)
   (python-mode . lsp)
   (rust-mode . lsp)
   (yaml-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package projectile
  :bind-keymap ("C-c p" . projectile-command-map)
  :bind ("C-c f" . projectile-find-file)
  :config
  (projectile-mode +1))

(use-package simple-modeline
  :config
  (simple-modeline-mode))

(use-package which-key
  :config
  (which-key-mode 1))

(require 'use-package-ensure)

(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'conf-mode-hook 'display-line-numbers-mode)
(add-hook 'org-mode-hook 'display-line-numbers-mode)
(add-hook 'markdown-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'yaml-mode-hook 'display-line-numbers-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(solarized-dark))
 '(custom-safe-themes
   '("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default))
 '(package-selected-packages
   '(better-defaults simple-modeline lsp-ivy jinja2-mode use-package virtualenvwrapper yaml-mode projectile magit ivy which-key nix-mode flycheck rust-mode solarized-theme company lsp-ui lsp-mode evil))
 '(use-package-always-ensure t)
 '(vc-follow-symlinks nil)
 '(x-underline-at-descent-line t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 90 :width normal)))))
