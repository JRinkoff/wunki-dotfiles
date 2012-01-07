; org-mode
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-,") 'org-cycle-agenda-files)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

; Path to save my files
(setq org-directory (expand-file-name "~/Documents/Org"))

; Org-mobile
(setq org-mobile-inbox-for-pull (concat org-directory "/inbox.org"))
(setq org-mobile-directory "~/Dropbox/MobileOrg")

(setq org-agenda-files (list (concat org-directory "/personal.org")
                             (concat org-directory "/bread-and-pepper.org")
                             (concat org-directory "/books.org")
                             (concat org-directory "/inbox.org")))
(setq org-log-done 'time)
(setq org-default-notes-file (concat org-directory "/inbox.org"))

; Stop using paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path nil)

; refile items two levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))

; targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)

; org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (C . t)
   (sh . t)
   (ruby . t)
   (python . t)
   (js . t)
   (haskell . t)
   (clojure . t)))

(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)