;;;; session
;;;; http://emacs-session.sourceforge.net/
(my-require-and-when 'session
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  (setq session-globals-max-string 100000000)
  (setq session-undo-check -1)
  (add-hook 'after-init-hook 'session-initialize))
