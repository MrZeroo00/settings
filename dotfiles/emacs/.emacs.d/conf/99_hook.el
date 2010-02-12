;; dirvars (set directory local variables)
;;;(install-elisp "http://www.bookshelf.jp/elc/dirvars.el")
(my-require-and-when 'dirvars)

;; diminish
;;;(install-elisp "http://www.eskimo.com/~seldon/diminish.el")
(my-require-and-when 'diminish
  (diminish 'widen-window-mode " WW")
  (diminish 'auto-complete-mode)
  (diminish 'doxymacs-mode)
  (diminish 'egg-minor-mode)
  (diminish 'eldoc-mode)
  (diminish 'font-lock-mode)
  (diminish 'hs-minor-mode)
  (diminish 'my-keyjack-mode)
;;;  (diminish 'typing-outputz-mode)
  (diminish 'yas/minor-mode)
;;;  (diminish 'emacs-lisp-mode "Elisp")
;;;  (eval-after-load "cwarn" '(diminish 'cwarn-mode))
;;;  (eval-after-load "flymake" '(diminish 'flymake-mode))
;;;  (eval-after-load "gtags" '(diminish 'gtags-mode))
  )
