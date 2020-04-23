(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'company-lsp)
(require 'evil)
(require 'evil-magit)
(require 'lsp-mode)
(require 'magit)

(push 'company-lsp company-backends)

(defun disable-line-numbers ()
  (setq-local display-line-numbers-type nil))

(add-hook 'term-mode-hook 'disable-line-numbers)
(add-hook 'rcirc-mode 'disable-line-numbers)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'prog-mode-hook #'lsp)

(global-unset-key (kbd "M-SPC"))
(global-set-key (kbd "M-SPC g") 'magit-status)
(global-set-key (kbd "M-SPC M-g") 'magit-dispatch)
(global-set-key (kbd "M-SPC p") 'projectile-command-map)
(global-set-key (kbd "M-SPC f") 'projectile-find-file)
(global-set-key (kbd "M-SPC l") lsp-command-map)
(global-set-key (kbd "M-SPC c") (lambda () (interactive)
				  (find-file user-init-file)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox)))
 '(custom-safe-themes
   (quote
    ("b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" default)))
 '(evil-mode 1)
 '(global-display-line-numbers-mode t)
 '(initial-buffer-choice "~/Dokumente/notes/misc.org")
 '(ivy-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (which-key yaml-mode projectile ivy company-lsp evil-magit magit lsp-ui pyvenv company lsp-mode gruvbox-theme evil)))
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
