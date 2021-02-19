;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

(ivy-mode 1)
(which-key-mode 1)

(require 'lsp-mode)
(define-key lsp-mode-map (kbd "C-SPC") lsp-command-map)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))
(add-hook 'python-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp)
(add-hook 'javascript-mode-hook #'lsp)

(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(global-set-key (kbd "C-c f") 'projectile-find-file)

(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)
(add-hook 'org-mode-hook 'display-line-numbers-mode)
(add-hook 'yaml-mode-hook 'display-line-numbers-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(column-number-mode t)
 '(custom-enabled-themes '(solarized-dark))
 '(custom-safe-themes
   '("2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default))
 '(ivy-count-format "(%d/%d) ")
 '(ivy-use-virtual-buffers t)
 '(lsp-keymap-prefix "C-SPC")
 '(package-selected-packages
   '(virtualenvwrapper yaml-mode projectile magit ivy which-key nix-mode flycheck rust-mode solarized-theme company lsp-ui lsp-mode evil))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(x-underline-at-descent-line t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :foundry "BE5N" :slant normal :weight normal :height 90 :width normal)))))
