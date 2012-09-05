; org-mode
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c b") 'org-iswitchb)
(define-key global-map (kbd "C-.") 'org-cycle-agenda-files)
(define-key global-map (kbd "<f8>") 'org-agenda)

; archive method
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

; org-files
(setq org-agenda-files (list (concat dropbox-directory "/Org/bread-and-pepper.org")
                             (concat dropbox-directory "/Org/personal.org")
                             (concat dropbox-directory "/Org/books.org")
                             (concat dropbox-directory "/Org/inbox.org"))
      org-default-notes-file (concat dropbox-directory "/Org/inbox.org"))

; always use indent-mode
(setq org-startup-indented t)

; log the time
(setq org-log-done 'time)

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

; capture templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat dropbox-directory "/Org/inbox.org") "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree (concat dropbox-directory "/Org/journal.org"))
             "* %?\nEntered on %U\n  %i\n  %a")
        ("n" "Note" entry (file (concat dropbox-directory "/Org/notes.org"))
         "* NOTE %?\n  %i\n  %a")))

; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?h)
                            (:endgroup)
                            ("phone" . ?m)
                            ("waiting" . ?w)
                            ("hold" . ?p)
                            ("personal" . ?p)
                            ("work" . ?b)
                            ("tweak" . ?t)
                            ("note" . ?n)
                            ("cancelled" . ?c)
                            ("flagged" . ??))))

; allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)
