(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'evil)
(require 'lsp-mode)
(require 'magit)
(require 'evil-magit)

(defun disable-line-numbers ()
  (setq-local display-line-numbers-type nil))

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'term-mode-hook 'disable-line-numbers)

(add-hook 'c++-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp)

(global-unset-key (kbd "M-SPC"))
(global-set-key (kbd "M-SPC g") 'magit-status)
(global-set-key (kbd "M-SPC M-g") 'magit-dispatch)
(global-set-key (kbd "M-SPC p") 'projectile-command-map)
(global-set-key (kbd "M-SPC f") 'projectile-find-file)
(global-set-key (kbd "M-SPC c") (lambda () (interactive)
				  (find-file user-init-file)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (monokai-pro)))
 '(custom-safe-themes
   (quote
    ("588b1c5d24ab8ddeffe6e7ae93ac642f71149bbb67b13e54edbef4ef761ad13c" default)))
 '(evil-mode 1)
 '(global-display-line-numbers-mode t)
 '(initial-buffer-choice "~/Dokumente/notes/misc.org")
 '(ivy-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (lsp-ivy auctex monokai-pro-theme evil-magit rust-mode which-key yaml-mode projectile ivy magit lsp-ui pyvenv company lsp-mode evil)))
 '(projectile-completion-system (quote ivy))
 '(projectile-indexing-method (quote hybrid))
 '(projectile-mode t nil (projectile))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-follow-symlinks t)
 '(which-key-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 90 :width normal)))))
