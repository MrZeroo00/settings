;; bf-mode
(require 'bf-mode)

;; find-dired-lisp
(autoload 'find-dired-lisp
  "find-dired-lisp" "findr" t nil)
(autoload 'find-grep-dired-lisp
  "find-dired-lisp" "findr" t nil)

;; sorter
(add-hook 'dired-load-hook
          (lambda ()
            (require 'sorter)))

;; wdired
(require 'wdired)
;(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)