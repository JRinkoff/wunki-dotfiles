;; themes and fonts
(if (>= emacs-major-version 24)
  (progn
    (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
    (load-theme 'sanityinc-tomorrow-night))t
  (progn
    (require 'color-theme)
    (color-theme-tomorrow-night)))

;; font
(set-frame-font "Ubuntu Mono-12")
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-12"))

;; need this because italic was also underlined, no idea why...
(custom-set-faces
 '(italic ((t (:slant italic)))))

(defun toggle-dark-light-theme ()
  "Switch between dark and light theme."
  (interactive)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'dark)
      (load-theme 'sanityinc-solarized-light)
    (load-theme 'sanityinc-tomorrow-night)))
