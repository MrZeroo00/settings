;;;; session
;;;; http://emacs-session.sourceforge.net/
(my-require-and-when 'session
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  (setq session-globals-max-string 100000000)
  (setq session-undo-check -1)

  ;; exclude some files
  ;; http://www.callcc.net/diary/20101106.html
  (setq session-set-file-name-exclude-regexp "/\\.overview\\|.session\\|News/\\|COMMIT_EDITMSG")
  (setq session-file-alist-exclude-regexp session-set-file-name-exclude-regexp)
  (defadvice session-store-buffer-places (around apply-session-file-alist-exclude-regexp activate)
    (let ((file-name (session-buffer-file-name)))
      (when (and file-name
                 (not (string-match session-file-alist-exclude-regexp file-name)))
        ad-do-it)))
  (add-hook 'after-init-hook 'session-initialize))
