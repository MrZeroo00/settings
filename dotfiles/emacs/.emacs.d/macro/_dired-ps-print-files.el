;; dired-ps-print-files
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=dired%20print
(defun dired-ps-print-files ()
  (interactive)
  (let ((files-to-print (dired-get-marked-files)))
    (while (setq file (car files-to-print))
      (setq files-to-print (cdr files-to-print))
      (find-file file)
      (ps-print-buffer-with-faces)
      (kill-buffer nil))))
