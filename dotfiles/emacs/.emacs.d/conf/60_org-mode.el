;; http://orgmode.org/
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(require 'org)

; association setting
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-agenda-files (list "~/memo/todo.org"))


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
