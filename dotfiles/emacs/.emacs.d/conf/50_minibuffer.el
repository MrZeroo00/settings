(minibuffer-electric-default-mode t)


;; minibuf-isearch
;;;(install-elisp "http://svn.coderepos.org/share/lang/elisp/minibuf-isearch/minibuf-isearch.el")
(my-require-and-when 'minibuf-isearch)


;; cycle-mini
;;;(install-elisp "http://joereiss.net/misc/cycle-mini.el")
;;;(my-require-and-when 'cycle-mini)


;; completing-help
;;;(install-elisp "http://homepage1.nifty.com/bmonkey/emacs/elisp/completing-help.el")
'(my-require-and-when 'completing-help
  (turn-on-completing-help-mode))


;; advice
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))


;; macros
;;;(my-load-and-when "_minibuffer-delete-duplicate")
;;;(my-load-and-when "_minibuf-shrink")
