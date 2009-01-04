;; Update timestamp when saving
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=myfunc%20time-stamp
(defvar my-save-buffer-hook nil)
(defun save-buffer-wrapper ()
  (interactive)
  (let ((tostr (concat "$Lastupdate: " (format-time-string "%Y/%m/%d %k:%M:%S") " $")))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward
              "\\$Lastupdate\\([0-9/: ]*\\)?\\$" nil t)
        (replace-match tostr nil t)))
    (run-hooks 'my-save-buffer-hook)
    (save-buffer)))
