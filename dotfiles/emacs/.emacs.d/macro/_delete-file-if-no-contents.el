;; delete no content file
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=delete%20nocontents
;(if (not (memq 'delete-file-if-no-contents after-save-hook))
;    (setq after-save-hook
;          (cons 'delete-file-if-no-contents after-save-hook)))

(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (= (point-min) (point-max)))
    (when (y-or-n-p "Delete file and kill buffer?")
      (delete-file
       (buffer-file-name (current-buffer)))
      (kill-buffer (current-buffer)))))
