(setq migemo-command
      (or (my-which "cmigemo")
          (my-which "migemo")))
(setq migemo-options '("-q" "--emacs"))

;;;; dictionary
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)

;;;; cache
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1024)

(my-require-and-when 'migemo
  (migemo-init))


;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=migemo%20onlyjapanese
;;;; buffer-file-coding-system から言語判別
;;;; unicode も入れた方がいいのかも。
(defun my-language-check (lang)
  (let ((coding
         (coding-system-base buffer-file-coding-system)))
    (memq
     coding
     (cdr (assoc 'coding-system
                 (assoc lang language-info-alist))))))

;;;; 日本語じゃないときは migemo を使わない
(my-eval-after-load "migemo"
  '(progn
     (defadvice isearch-mode
       (before my-migemo-off activate)
       (unless (my-language-check "Japanese")
         (make-local-variable 'migemo-isearch-enable-p)
         (setq migemo-isearch-enable-p nil)))
     (my-add-hook 'isearch-mode-end-hook
               (lambda ()
                 (unless (my-language-check "Japanese")
                   (setq migemo-isearch-enable-p t))))))


;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=auto%20renmigemo
;;;(defun my-ren-cap (str) ; 次単語の先頭を大文字化
;;;  (string-match
;;;   ".*[aiueo]\\(?:nn\\)*\\(.+\\)" str) ; 最後の母音 OR nn 直後
;;;  (let ((start (match-beginning 1)))
;;;    (cond
;;;     ((string-match "n\\([^aiueon]\\)" str start); n の後の子音
;;;      (replace-match (upcase (match-string 1 str)) nil nil str 1))
;;;     ((string-match "[ ,.]*\\(.\\)" str start); 母音 OR nn の直後
;;;      (replace-match (upcase (match-string 1 str)) nil nil str 1))
;;;     (t str))))
;;;
;;;(defadvice isearch-update (after my-migemo-auto-cap activate)
;;;  (when (and (featurep 'migemo)
;;;             migemo-isearch-enable-p ; migemo が on で，
;;;             (not isearch-success) ; isearch に失敗し，
;;;             ;; 検索文字列が二文字以上で母音終わり，
;;;             (string-match ".[aiueo]$" isearch-string)
;;;             (eq this-command
;;;                 'isearch-printing-char) ; 検索文字列を伸ばした
;;;             (save-excursion
;;;               ;; 残りのバッファを検索しても検索文字列がない場合
;;;               (goto-char (point-min))
;;;               (not (funcall
;;;                     (if isearch-forward
;;;                         're-search-forward 're-search-backward)
;;;                     (migemo-get-pattern isearch-string) nil t))))
;;;    ;; migemo で isearch に失敗したらそこから次単語とする
;;;    (dolist (var (list 'isearch-string 'isearch-message))
;;;      (let ((str (symbol-value var)))
;;;        (set var (my-ren-cap str))));; (length str)))))
;;;    ;; 再検索 -- isearch-barrier からでいいのかな？
;;;    (goto-char isearch-opoint)
;;;    (isearch-search)))


;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=no%20migemo
;;;; 文字をバッファからコピーするときには
;;;; migemo をオフにする
;;;(defadvice isearch-yank-string
;;;  (before migemo-off activate)
;;;  (setq migemo-isearch-enable-p nil))
;;;
;;; isearch で検索する時には
;;; migemo をオンにする
;;;(defadvice isearch-mode
;;;  (before migemo-on activate)
;;;  (setq migemo-isearch-enable-p t))
