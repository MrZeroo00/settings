;;; utililty functions
;; insert date
;(defun my-insert-date ()
;(interactive)
;(insert (format-time-string "%Y-%m-%dT%R:%S+09:00" (current-time))))
;
;(global-set-key "\C-cd" 'my-insert-date)


;; instamp
;(install-elisp "http://www.gentei.org/~yuuji/software/euc/instamp.el")
(autoload 'instamp "instamp" "Insert TimeStamp on the point" t)
;(define-key global-map "\C-cs" 'instamp)


;; macros
(load "_which")
