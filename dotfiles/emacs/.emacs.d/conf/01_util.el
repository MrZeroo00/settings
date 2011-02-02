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


;;;; copy current location
(defun copy-current-location ()
  (interactive)
  (let ((location (cond ((symbol-value 'dired-directory))
                        ((symbol-value 'buffer-file-name)))))
    (unless (null location)
      (kill-new location))))