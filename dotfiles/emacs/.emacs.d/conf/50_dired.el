;; find-dired-lisp (filter file list)
(autoload 'find-dired-lisp
  "find-dired-lisp" "findr" t nil)
(autoload 'find-grep-dired-lisp
  "find-dired-lisp" "findr" t nil)


;; sorter (sort file list)
(add-hook 'dired-load-hook
          (lambda ()
            (require 'sorter)))


;; wdired (rename file name from dired buffer)
(require 'wdired)
;(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;; bf-mode (show file content)
(require 'bf-mode)