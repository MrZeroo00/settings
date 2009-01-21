;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=occur%20keepline
;;;Occur - Kin Cho <kin@dynarc.com>
(define-key occur-mode-map "F"
  (lambda (str) (interactive "sflush: ")
    (let ((buffer-read-only))
      (save-excursion
        (beginning-of-buffer)
        (forward-line 1)
        (beginning-of-line)
        (flush-lines str)))))
(define-key occur-mode-map "K"
  (lambda (str) (interactive "skeep: ")
    (let ((buffer-read-only))
      (save-excursion
        (beginning-of-buffer)
        (forward-line 1)
        (beginning-of-line)
        (keep-lines str)))))
