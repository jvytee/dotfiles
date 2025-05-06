(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(default-frame-alist '((horizontal-scroll-bars) (vertical-scroll-bars)))
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "en_GB")
 '(nxml-slash-auto-complete-flag t)
 '(org-agenda-files (find-agenda-files org-directory))
 '(org-babel-load-languages '((emacs-lisp . t) (python . t) (scheme . t)))
 '(org-directory "~/notes")
 '(package-selected-packages
   '(all-the-icons auctex auctex-latexmk better-defaults company counsel
                   direnv docker dockerfile-mode doom-modeline
                   doom-themes eglot eldoc-box evil evil-collection
                   flycheck flycheck-eglot gcmh gcmh-mode geiser-guile
                   go-mode groovy-mode haskell-mode helpful
                   highlight-indent-guides ligature lua-mode magit
                   markdown-mode meson-mode nginx-mode nix-mode
                   ob-mermaid paredit-evil pipenv projectile
                   python-mode rainbow-mode rg rust-mode sicp
                   sql-indent terraform-mode treemacs treemacs-evil
                   treemacs-magit treemacs-projectile typescript-mode
                   use-package vterm web-mode which-key yaml-mode
                   yasnippet))
 '(pixel-scroll-precision-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(vc-follow-symlinks nil)
 '(warning-minimum-level :error)
 '(xterm-mouse-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "Iosevka"))))
 '(variable-pitch ((t (:family "Inter")))))
