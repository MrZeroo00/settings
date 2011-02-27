;;;; http://orgmode.org/
(my-require-and-when 'org
;;;  (my-require-and-when 'org-install)
  (my-require-and-when 'org-mouse)
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)

  ;; association setting
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)

  (setq org-directory "~/memo/")
  (setq org-default-notes-file (concat org-directory "agenda.org"))
  (setq org-agenda-files (list "~/memo/todo.org"))
  (setq org-archive-location "::* Archived")
  (setq org-log-done t)
  ;;(setq org-startup-folded t)
  (setq org-hide-leading-stars t)
  (setq org-deadline-warning-days 7)


  (setq org-todo-keywords
  '((sequence "TODO(t)" "NEXT(n)" "WAITING(w@/!)" "PROJECT(p)" "MAYBE(m@)" "REFERENCE(r)" "|" "DONE(d!)" "DELEGATED")
    (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")
    (sequence "|" "CANCELED")))
  (setq org-todo-keyword-faces
  '(("TODO"       . (:foreground "pink"))
    ("NEXT"       . (:foreground "yellow" :weight bold))
    ("WAITING"    . (:foreground "red" :weight bold))
    ("PROJECT"    . (:foreground "purple"))
    ("MAYBE"      . shadow)
    ("REFERENCE"  . shadow)
    ("DONE"       . shadow)
    ("DELEGATED"  . shadow)
    ("REPORT"     . (:foreground "pink"))
    ("BUG"        . (:foreground "yellow" :weight bold))
    ("KNOWNCAUSE" . shadow)
    ("FIXED"      . shadow)
    ("CANCELED"   . shadow)
    ))

  (setq org-tag-alist
  '(("@office" . ?o)
    ("@home" . ?h)
    ("@computer" . ?c)
    ("mail" . ?m)
    ("errands" . ?e)
    ))

  (setq org-stuck-projects
  '("+PROJECT/-MAYBE-DONE-REFERENCE" ("NEXT" "TODO") ("mail errands")))

  (setq org-agenda-custom-commands
  '(
    ;; Weekly Review
    ("W" "Weekly Review"
     ((agenda "" ((org-agenda-ndays 7)))
      (stuck "")
      (todo "PROJECT")
      (todo "WAITING")
      (todo "MAYBE")
      ))
    ;; Today's Action
    ("D" "Today's Action"
     ((agenda "" ((org-agenda-ndays 1)))
      (stuck "")
      (todo "NEXT")
      (todo "TODO")
      ))
    ;; GTD contexts
    ("g" . "GTD contexts")
    ("go" "Office" tags-todo "@office")
    ("gh" "Home" tags-todo "@home")
    ("gc" "Computer" tags-todo "@computer")
    ("gm" "Mail" tags-todo "mail")
    ("ge" "Errands" tags-todo "errands")
    ("G" "GTD Block Agenda"
     ((tags-todo "@office")
      (tags-todo "@home")
      (tags-todo "@computer")
      (tags-todo "mail")
      (tags-todo "errands"))
     nil
     ("~/memo/next-actions.html"))
    ;; Upcoming deadlines
    ("d" "Upcoming deadlines" agenda ""
     ((org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))
      (org-agenda-ndays 1)
      (org-deadline-warning-days 60)
      (org-agenda-time-grid nil)))
    ;; Printed agenda
    ("P" "Printed agenda"
     ((agenda "" ((org-agenda-ndays 7)
  		(org-agenda-start-on-weekday nil)
  		(org-agenda-repeating-timestamp-show-all t)
  		(org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
      (agenda "" ((org-agenda-ndays 1)
  		(org-deadline-warning-days 7)
  		(org-agenda-todo-keyword-format "[ ]")
  		(org-agenda-scheduled-leaders '("" ""))
  		(org-agenda-prefix-format "%t%s")))
      (todo "NEXT"
  	  ((org-agenda-prefix-format "[ ] %T: ")
  	   (org-agenda-sorting-strategy '(tag-up priority-down))
  	   (org-agenda-todo-keyword-format "")
  	   (org-agenda-overriding-header "\nTasks by Context\n------------------\n"))))
     ((org-agenda-with-colors nil)
      (org-agenda-compact-blocks t)
      (org-agenda-remove-tags t)
      (ps-number-of-columns 2)
      (ps-landscape-mode t))
     ("~/memo/agenda.ps"))
    ;; Custom queries
    ("Q" . "Custom queries")
    ("Qa" "Archive search" search ""
     ((org-agenda-files (file-expand-wildcards "~/memo/archive/*.org"))))
    ("Qb" "Projects and Archive" search ""
     ((org-agenda-text-search-extra-files (file-expand-wildcards "~/memo/archive/*.org"))))
    ("QA" "Archive tags search" org-tags-view ""
     ((org-agenda-files (file-expand-wildcards "~/memo/archive/*.org"))))
    ))

  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline nil "Inbox")
           "** TODO %?\n   %i\n   %a\n   %t")
          ("b" "Bug" entry
           (file+headline nil "Inbox")
           "** TODO %?   :bug:\n   %i\n   %a\n   %t")
          ("i" "Idea" entry
           (file+headline nil "New Ideas")
           "** %?\n   %i\n   %a\n   %t")
          ("c" "Code" entry
           (file+headline "~/memo/code-reading.org" "Code Reading")
           "** CODE %?\n   %i\n   %a\n   %t")))
  (global-set-key (kbd "C-c c") 'org-capture)

  ;; anything
  (when (featurep 'anything)
    (add-to-list 'anything-mode-specific-alist
                 '(org-mode . (
                               anything-c-source-org-todo-state
                               anything-c-source-org-headline
                               )))
    )

  ;; imenu
  (add-hook 'org-mode-hook
            (lambda () (imenu-add-to-menubar "Imenu")))

  ;; auto-insert
  (when (featurep 'autoinsert)
    (add-to-list 'auto-insert-alist '("bug.*\\.org$" . ["template_bug.org" my-template]))
    )
  )


;;;; remember
;;;; https://gna.org/p/remember-el
'(org-remember-insinuate)
'(my-require-and-when 'remember
  (setq remember-annotation-functions '(org-remember-annotation))
  (setq remember-handler-functions '(org-remember-handler))
  (add-hook 'remember-mode-hook 'org-remember-apply-template)

  (setq org-remember-templates
        '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
          ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
          ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")
          )))


;;;; freemind
;;;(install-elisp-from-emacswiki "freemind.el")
'(my-require-and-when 'freemind)


;;;; macros
;;;(my-load-and-when "_org-remember-code-reading")
(my-load-and-when "_org-next-prev-visible-link"
  (define-key org-mode-map "\M-n" 'org-next-visible-link)
  (define-key org-mode-map "\M-p" 'org-previous-visible-link))
(my-load-and-when "_wicked_org-update-checkbox-count"
  (defadvice org-update-checkbox-count (around wicked activate)
    "Fix the built-in checkbox count to understand headlines."
    (setq ad-return-value
          (wicked/org-update-checkbox-count (ad-get-arg 1)))))
(my-load-and-when "_org-summary-todo")
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
