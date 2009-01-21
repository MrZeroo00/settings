;; elisp-font-lock-top-quote
;; http://d.hatena.ne.jp/rubikitch/20080413/1208029110
(defun elisp-font-lock-top-quote (limit)
  (when (re-search-forward "^' *(" limit t)
    (forward-char -1)
    (set-match-data (list (point) (progn (forward-sexp 1) (point))))
    t))

(font-lock-add-keywords
 'emacs-lisp-mode
 '((elisp-font-lock-top-quote 0 font-lock-comment-face prepend)))
