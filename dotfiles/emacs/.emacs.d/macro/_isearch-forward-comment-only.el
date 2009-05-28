;; isearch-forward-comment-only
;; http://www-tsujii.is.s.u-tokyo.ac.jp/~yoshinag/tips/elisp_tips.html#cskip

;; 文字列探索し、コメント行かどうかをチェックする関数
(defun my-search-comment (point str flag)
  (and (integerp point)
       (not (string= str "")) ;; ↓トリック的なコード
       (if (nth 4 (parse-partial-sexp (point-min) point)) flag (not flag))))

;; コメント行を無視する (re-)search-forward(-regexp)
(defadvice search-forward (around my-comment-skip disable)
  (while (my-search-comment ad-do-it (ad-get-arg 0) t)))
(defadvice search-forward-regexp (around my-comment-skip disable)
  (while (my-search-comment ad-do-it (ad-get-arg 0) t)))
(defadvice re-search-forward (around my-comment-skip disable)
  (while (my-search-comment ad-do-it (ad-get-arg 0) t)))

;; コメント行以外を無視する (re-)search-forward(-regexp)
(defadvice search-forward (around my-comment-only disable)
  (while (my-search-comment ad-do-it (ad-get-arg 0) nil)))
(defadvice search-forward-regexp (around my-comment-only disable)
  (while (my-search-comment ad-do-it (ad-get-arg 0) nil)))
(defadvice re-search-forward (around my-comment-only disable)
  (while (my-search-comment ad-do-it (ad-get-arg 0) nil)))

(fset 'isearch-forward-comment-only 'isearch-forward)
(fset 'isearch-forward-comment-skip 'isearch-forward)

;; isearch-forward (migemo-forward) が内部で使っている search-forward
;; (search-forward-regexp, re-search-forward) を
;; isearch-forward-comment-skip ではコメント行を無視するように
;; isearch-forward-comment-only ではコメント行以外を無視するように変更
(defadvice isearch-forward-comment-skip (before my-ad-activate activate)
  (mapcar
   (lambda (x) (ad-enable-advice x 'around 'my-comment-skip) (ad-activate x))
   (list 'search-forward 'search-forward-regexp 're-search-forward)))

(defadvice isearch-forward-comment-only (before my-ad-activate activate)
  (mapcar
   (lambda (x) (ad-enable-advice x 'around 'my-comment-only) (ad-activate x))
   (list 'search-forward 'search-forward-regexp 're-search-forward)))

(add-hook 'isearch-mode-end-hook
          (lambda ()
            (mapcar
             (lambda (x)
               (ad-deactivate x)
               (ad-disable-advice x 'around 'my-comment-skip)
               (ad-disable-advice x 'around 'my-comment-only)
               (ad-activate x))
             (list 'search-forward 'search-forward-regexp 're-search-forward))))
