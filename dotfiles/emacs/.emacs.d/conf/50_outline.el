;; http://orgmode.org/
(require 'org)

; association setting
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)


;; freemind
;(install-elisp-from-emacswiki "freemind.el")
(require 'freemind)
