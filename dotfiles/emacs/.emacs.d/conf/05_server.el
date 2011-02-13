;;;; emacsclient
(server-start)

;;;; gnuserv
'(my-require-and-when 'gnuserv
  (gnuserv-start)
  (setq gnuserv-frame (selected-frame))

;;;   http://www.rubyist.net/~rubikitch/computer/myruby/gnuclient-wrapper/
  (setq screen-command "/usr/bin/screen")
  (setq gnuserv-winconf nil)
  (defun gnuserv-edit-finish ()
    (interactive)
    (and (buffer-modified-p)
         (y-or-n-p (concat "Save file " (buffer-file-name) "?" ))
         (save-buffer))
    (condition-case nil
        (gnuserv-edit)
      (error (if buffer-read-only
                 (kill-buffer (current-buffer)))
             (delete-frame)
             nil))
    (set-window-configuration gnuserv-winconf)
    (with-temp-buffer
      (insert-file-contents "~/.screen-gnuclient")
      (unless (zerop (buffer-size))
        (call-process screen-command nil nil nil "-X" "select" (buffer-string)))))

  (defun finish-buffer ()
    (interactive)
    (if (gnuserv-buffer-p (current-buffer))
        (gnuserv-edit-finish)
      (when (buffer-file-name)
        (and (buffer-modified-p)
             (y-or-n-p (concat "Save file " (buffer-file-name) "?" ))
             (save-buffer)))
      (kill-buffer (current-buffer))))

  (easy-mmode-define-minor-mode
   gnuserv-edit-mode "" nil ""
   '(("\C-c\C-c" . (lambda ()
                     (interactive)
                     (save-buffer)
                     (finish-buffer)))))

  (defun gnuserv-find-file (file)
    (interactive)
    (setq gnuserv-winconf (current-window-configuration))
    (find-file file)
    (gnuserv-edit-mode t))

  (setq gnuserv-find-file-function 'gnuserv-find-file)
  (define-key ctl-x-map "\C-c" 'gnuserv-edit-finish))


;; -*-no-byte-compile: t; -*-
