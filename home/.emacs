(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'evil)
(require 'magit)
(require 'evil-magit)
(require 'lsp-mode)
(require 'lsp-java)

(push (cons "\\*shell\\*" display-buffer--same-window-action) display-buffer-alist)

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(add-hook 'c++-mode-hook #'lsp)
(add-hook 'java-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp)

(global-unset-key (kbd "M-SPC"))
(global-set-key (kbd "M-SPC g") 'magit-status)
(global-set-key (kbd "M-SPC M-g") 'magit-dispatch)
(global-set-key (kbd "M-SPC p") 'projectile-command-map)
(global-set-key (kbd "M-SPC f") 'projectile-find-file)
(global-set-key (kbd "M-SPC s") 'shell-pop)
(global-set-key (kbd "M-SPC l") lsp-command-map)
(global-set-key (kbd "M-SPC c") (lambda () (interactive)
				  (find-file user-init-file)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default)))
 '(erc-nick "jvytee")
 '(evil-mode 1)
 '(global-display-line-numbers-mode t)
 '(initial-buffer-choice "~/Dokumente/notes/misc.org")
 '(ivy-mode t)
 '(lsp-rust-server (quote rust-analyzer))
 '(package-selected-packages
   (quote
    (solarized-theme lsp-java shell-pop lsp-ivy auctex evil-magit rust-mode which-key yaml-mode projectile ivy magit lsp-ui pyvenv company lsp-mode evil)))
 '(projectile-completion-system (quote ivy))
 '(projectile-indexing-method (quote hybrid))
 '(projectile-mode t nil (projectile))
 '(python-shell-interpreter "ipython")
 '(scroll-bar-mode nil)
 '(shell-pop-universal-key "M-SPC s")
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
