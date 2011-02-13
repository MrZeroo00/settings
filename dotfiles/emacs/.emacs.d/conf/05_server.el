;;;; emacsclient
(server-start)


;;;; screen
'(add-hook 'server-visit-hook
          (lambda ()
            (shell-command
             "screen -X select $WINDOW")
            (raise-frame)))


;; -*-no-byte-compile: t; -*-
