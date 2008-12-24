(require 'multiverse)

(defun my-save-buffer (arg)
  (interactive "P")
  (if arg
      (multiverse-store)
    (save-buffer)))

(global-set-key "\C-x\C-s" 'my-save-buffer)
