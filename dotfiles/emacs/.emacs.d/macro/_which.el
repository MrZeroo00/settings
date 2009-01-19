;; my-which (original is w3m-which-command)
(defun my-which (command)
  (when (stringp command)
    (if (and (file-name-absolute-p command)
             (file-executable-p command))
        command
      (setq command (file-name-nondirectory command))
      (catch 'found-command
        (let (bin)
          (dolist (dir exec-path)
            (when (or (file-executable-p
                       (setq bin (expand-file-name command dir)))
                      (file-executable-p
                       (setq bin (expand-file-name (concat command ".exe") dir))
                       ))
              (throw 'found-command bin))))))))
