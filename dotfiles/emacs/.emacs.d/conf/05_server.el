;;;; emacsclient
(unless (server-running-p)
  (server-start))


;;;; screen
(defun my-server-visit-hook ()
  (shell-command
   "screen -X select $WINDOW")
  (raise-frame))
(add-hook 'server-visit-hook 'my-server-visit-hook)
