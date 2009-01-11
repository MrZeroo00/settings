;; isearch-real-delete-char
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=isearch%20delete
(defun isearch-real-delete-char ()
  (interactive)
  (setq isearch-string
        (if (= (length isearch-string) 1)
            isearch-string
          (substring isearch-string 0 (- (length isearch-string) 1)))
        isearch-message isearch-string
        isearch-yank-flag t)
  (isearch-search-and-update))

;(define-key isearch-mode-map "\C-o" 'isearch-real-delete-char)
