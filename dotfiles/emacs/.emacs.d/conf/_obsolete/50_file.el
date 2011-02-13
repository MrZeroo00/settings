;;;; disk
;;;(install-elisp-from-emacswiki "disk.el")
(my-autoload-and-when 'disk "disk")


;;;; highlight-completion
;;;(install-elisp "http://www.math.washington.edu/~palmieri/Emacs/Hlc/highlight-completion.el")
;;;(setq hc-ctrl-x-c-is-completion t)
'(my-require-and-when 'highlight-completion
  (highlight-completion-mode t)
  (global-set-key "\C-\\" 'toggle-input-method))
