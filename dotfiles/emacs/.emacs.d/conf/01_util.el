;;; utililty functions
;;;; insert date
'(defun my-insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%dT%R:%S+09:00" (current-time))))
;;;(global-set-key "\C-cd" 'my-insert-date)


;;;; instamp
;;;(install-elisp "http://www.gentei.org/~yuuji/software/euc/instamp.el")
(my-autoload-and-when 'instamp "instamp"
  (define-key global-map "\C-cs" 'instamp))


;;;; copy current file name
(defun copy-current-filename ()
  (interactive)
  (kill-new (buffer-file-name)))


;;;; macros
(my-load-and-when "_which")
