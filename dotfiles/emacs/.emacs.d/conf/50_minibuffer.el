(minibuffer-electric-default-mode t)
;;;(setq enable-recursive-minibuffers t)


;;;; minibuf-isearch
;;;(install-elisp "http://svn.coderepos.org/share/lang/elisp/minibuf-isearch/minibuf-isearch.el")
(my-require-and-when 'minibuf-isearch)


;;;; advice
'(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))


;;;; macros
;;;(my-load-and-when "_minibuffer-delete-duplicate")
;;;(my-load-and-when "_minibuf-shrink")


;; -*-no-byte-compile: t; -*-
