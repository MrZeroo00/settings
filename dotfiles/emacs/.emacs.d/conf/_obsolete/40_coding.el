;;;; mode-info
;;;; http://www.namazu.org/~tsuchiya/elisp/mode-info.html
'(my-require-and-when 'mi-config
;;;  (define-key global-map "\C-hf" 'mode-info-describe-function)
;;;  (define-key global-map "\C-hv" 'mode-info-describe-variable)
;;;  (define-key global-map "\M-." 'mode-info-find-tag)
  (my-require-and-when 'mi-fontify)
  (setq mode-info-index-directory "~/.emacs.d")
  (setq mode-info-class-alist
  '((elisp  emacs-lisp-mode lisp-interaction-mode)
    (libc   c-mode c++-mode)
    (make   makefile-mode)
    (perl   perl-mode cperl-mode eperl-mode)
    (ruby   ruby-mode)
    (gauche scheme-mode scheme-interaction-mode inferior-scheme-mode))))
