;;; utililty functions
;; insert date
(defun my-insert-date ()
(interactive)
(insert (format-time-string "%Y-%m-%dT%R:%S+09:00" (current-time))))

(global-set-key "\C-cd" 'my-insert-date)


;; macros
(load "_which")
