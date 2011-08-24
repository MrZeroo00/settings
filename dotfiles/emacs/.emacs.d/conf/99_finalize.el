(setq debug-on-error nil)

;;;; diminish
;;;(install-elisp "http://www.eskimo.com/~seldon/diminish.el")
(my-require-and-when 'diminish
  (when (featurep 'auto-complete) (diminish 'auto-complete-mode))
  (when (featurep 'cwarn) '(diminish 'cwarn-mode))
  (when (featurep 'doxymacs) (diminish 'doxymacs-mode))
  (when (featurep 'eldoc) (diminish 'eldoc-mode))
  (when (featurep 'flymake) '(diminish 'flymake-mode))
  (when (featurep 'font-lock) (diminish 'font-lock-mode))
  (when (featurep 'gtags) '(diminish 'gtags-mode))
  (when (featurep 'hideshow) (diminish 'hs-minor-mode))
  ;;(when (featurep 'lisp-mode) (diminish 'emacs-lisp-mode "Elisp"))
  (when (featurep 'outputz) (diminish 'typing-outputz-mode))
  (when (featurep 'widen-window) (diminish 'widen-window-mode " WW"))
  (when (featurep 'yasnippet) (diminish 'yas/minor-mode))
  (diminish 'my-keyjack-mode)
  )


;; -*-no-byte-compile: t; -*-
