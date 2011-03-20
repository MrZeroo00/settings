(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)


(defun open ()
  "Open current buffer for OSX command"
  (interactive)
  (shell-command (concat "open " (buffer-file-name))))
