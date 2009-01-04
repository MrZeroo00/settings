;; yank region text with line number
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=copy-region-with-info
(defun copy-region-with-info (arg)
  "リージョンの各行に行番号とファイル名をつけてヤンクバッファにコピー
   C-u で数引数をつけると、ファイル名がフルパスで付与される"
  (interactive "p")
  (save-excursion
    (let ((e (max (region-end) (region-beginning)))
          (b (min (region-end) (region-beginning)))
          (str)
          (first t))
      (goto-char b)
      (while (<= (+ (point) 1) e)
        (beginning-of-line)
        (setq str
              (format
               "%s:%d:%s"
               (if (not (eq arg 1))
                   (buffer-file-name)
                 (buffer-name))
               (1+ (count-lines 1 (point)))
               (buffer-substring
                (point)
                (progn
                  (end-of-line)
                  (if (eobp)
                      (signal 'end-of-buffer nil))
                  (forward-char)
                  (point)))))
        (backward-char)
        (if (not first)
            (kill-append str nil)
          (setq kill-ring
                (cons str
                      kill-ring))
          (if (> (length kill-ring) kill-ring-max)
              (setcdr (nthcdr (1- kill-ring-max) kill-ring) nil))
          (setq kill-ring-yank-pointer kill-ring)
          (setq first nil))
        (forward-line 1)))))
