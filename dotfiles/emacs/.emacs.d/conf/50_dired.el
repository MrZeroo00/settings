;; find-dired-lisp (filter file list)
;(install-elisp "http://www.bookshelf.jp/elc/find-dired-lisp.el")
(autoload 'find-dired-lisp
  "find-dired-lisp" "findr" t nil)
(autoload 'find-grep-dired-lisp
  "find-dired-lisp" "findr" t nil)


;; sorter (sort file list)
;(install-elisp "http://www.bookshelf.jp/elc/sorter.el")
(add-hook 'dired-load-hook
          (lambda ()
            (require 'sorter)))


;; wdired (rename file name from dired buffer)
;(install-elisp-from-emacswiki "wdired.el")
(require 'wdired)
;(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;; bf-mode (show file content)
;(install-elisp "http://www.bookshelf.jp/elc/bf-mode.el")
(require 'bf-mode)
