;;;; isearch-all
;;;(install-elisp "http://www.bookshelf.jp/elc/isearch-all.el")
;;;(my-require-and-when 'isearch-all)


;;;; qsearch
;;;(install-elisp-from-emacswiki "qsearch.el")
;;;(my-require-and-when 'qsearch)


;;;; isearch-exit
;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=isearch-exit
;;;(define-key isearch-mode-map "\M-m" 'isearch-exit)
;;;(add-hook 'isearch-mode-end-hook
;;;          (lambda ()
;;;            (cond
;;;             ((eq last-input-char ?\C-m)
;;;              (goto-char (match-end 0)))
;;;             ((eq last-input-char ?\M-m)
;;;              (goto-char (match-beginning 0))))))
