;; hide all the things
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; load theme and don't ask if it's save.
(load-theme 'sanityinc-tomorrow-blue t)

;; font face
(add-to-list 'default-frame-alist '(font . "Fira Mono"))
(set-frame-font "Fira Mono")
(setq-default line-spacing 3)

;; font size
(set-face-attribute 'default nil :height 140)
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

(provide 'wunki-theme)
