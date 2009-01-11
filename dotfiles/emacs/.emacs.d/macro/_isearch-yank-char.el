;; isearch-yank-char
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=isearch-yank-char
(defun isearch-yank-char ()
  "Pull next character from buffer into search string."
  (interactive)
  (isearch-yank-string
   (save-excursion
     (and (not isearch-forward) isearch-other-end
          (goto-char isearch-other-end))
     (buffer-substring (point) (1+ (point))))))
;(define-key isearch-mode-map "\C-d" 'isearch-yank-char)
