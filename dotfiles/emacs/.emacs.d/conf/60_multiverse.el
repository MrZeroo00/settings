(require 'multiverse)

(defun my-save-buffer (arg)
  (interactive "P")
  (if arg
      (multiverse-store)
    (save-buffer)))

(global-set-key "\C-x\C-s" 'my-save-buffer)

(setq anything-kyr-functions
      `((lambda ()
          (when (assoc (current-buffer) multiverse-stored-versions)
            (list "multiverse-restore"
                  "multiverse-diff-current" "multiverse-diff-other"
                  "multiverse-forget")))
