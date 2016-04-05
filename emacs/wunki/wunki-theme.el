;; hide all the things
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; load theme and don't ask if it's save.
(if (display-graphic-p)
    (load-theme 'sanityinc-tomorrow-blue t)
  (load-theme 'zenburn t))

;; font face
(add-to-list 'default-frame-alist '(font . "Fira Mono-16"))
(set-frame-font "Fira Mono 16" nil t)
(setq-default line-spacing 2)

;; font size
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

(provide 'wunki-theme)
