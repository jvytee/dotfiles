;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'evil)
(require 'helm-config)

(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp)

(require 'company-lsp)
(push 'company-lsp company-backends)
(add-hook 'after-init-hook 'global-company-mode)

(require 'magit)
(require 'evil-magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

(defun disable-line-numbers ()
  (setq-local display-line-numbers-type nil))

(add-hook 'term-mode-hook 'disable-line-numbers)
(add-hook 'rcirc-mode 'disable-line-numbers)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox-dark-medium)))
 '(custom-safe-themes
   (quote
    ("aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" default)))
 '(evil-mode 1)
 '(global-display-line-numbers-mode t)
 '(helm-mode 1)
 '(lsp-keymap-prefix "M-l")
 '(package-selected-packages
   (quote
    (company-lsp evil-magit magit lsp-ui pyvenv company lsp-mode gruvbox-theme evil)))
 '(rcirc-server-alist
   '(("irc.freenode.net"
      :nick "jvytee"
      :port 6697
      :channels ("#stratum0")
      :encryption tls)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 90 :width normal)))))
