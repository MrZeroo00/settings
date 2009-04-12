;; http://orgmode.org/
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(require 'org)
(require 'org-mouse)

; association setting
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-agenda-files (list "~/memo/todo.org"))
(setq org-archive-location "::* Archived")
(setq org-log-done t)
;(setq org-startup-folded t)
(setq org-hide-leading-stars t)
(setq org-deadline-warning-days 7)


(setq org-todo-keywords '("TODO" "NEXT" "WAITING" "PROJECT" "MAYBE" "DONE" "REFERENCE")
      org-todo-interpretation 'sequence)

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
          (todo "TODO"
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


;; remember
(org-remember-insinuate)

(setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
        ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
        ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")
        ))


;; freemind
;(install-elisp-from-emacswiki "freemind.el")
(require 'freemind)


;; macros
(load "_org-remember-code-reading")
(load "_org-next-prev-visible-link")
(define-key org-mode-map "\M-n" 'org-next-visible-link)
(define-key org-mode-map "\M-p" 'org-previous-visible-link)
(load "wicked_org-update-checkbox-count")
(defadvice org-update-checkbox-count (around wicked activate)
  "Fix the built-in checkbox count to understand headlines."
  (setq ad-return-value
	(wicked/org-update-checkbox-count (ad-get-arg 1))))
