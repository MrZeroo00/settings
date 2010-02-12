(setq migemo-command
      (or (my-which "cmigemo")
          (my-which "migemo")))
(setq migemo-options '("-q" "--emacs"))

;; dictionary
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)

;; cache
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1024)

(my-require-and-when 'migemo)
(migemo-init)


;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=migemo%20onlyjapanese
;; buffer-file-coding-system �������Ƚ��
;; unicode �����줿���������Τ��⡣
(defun my-language-check (lang)
  (let ((coding
         (coding-system-base buffer-file-coding-system)))
    (memq
     coding
     (cdr (assoc 'coding-system
                 (assoc lang language-info-alist))))))

;; ���ܸ줸��ʤ��Ȥ��� migemo ��Ȥ�ʤ�
(eval-after-load "migemo"
  '(progn
     (defadvice isearch-mode
       (before my-migemo-off activate)
       (unless (my-language-check "Japanese")
         (make-local-variable 'migemo-isearch-enable-p)
         (setq migemo-isearch-enable-p nil)))
     (add-hook 'isearch-mode-end-hook
               (lambda ()
                 (unless (my-language-check "Japanese")
                   (setq migemo-isearch-enable-p t))))))


;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=auto%20renmigemo
;;;(defun my-ren-cap (str) ; ��ñ�����Ƭ����ʸ����
;;;  (string-match
;;;   ".*[aiueo]\\(?:nn\\)*\\(.+\\)" str) ; �Ǹ���첻 OR nn ľ��
;;;  (let ((start (match-beginning 1)))
;;;    (cond
;;;     ((string-match "n\\([^aiueon]\\)" str start); n �θ�λҲ�
;;;      (replace-match (upcase (match-string 1 str)) nil nil str 1))
;;;     ((string-match "[ ,.]*\\(.\\)" str start); �첻 OR nn ��ľ��
;;;      (replace-match (upcase (match-string 1 str)) nil nil str 1))
;;;     (t str))))
;;;
;;;(defadvice isearch-update (after my-migemo-auto-cap activate)
;;;  (when (and (featurep 'migemo)
;;;             migemo-isearch-enable-p ; migemo �� on �ǡ�
;;;             (not isearch-success) ; isearch �˼��Ԥ���
;;;             ;; ����ʸ������ʸ���ʾ���첻����ꡤ
;;;             (string-match ".[aiueo]$" isearch-string)
;;;             (eq this-command
;;;                 'isearch-printing-char) ; ����ʸ����򿭤Ф���
;;;             (save-excursion
;;;               ;; �Ĥ�ΥХåե��򸡺����Ƥ⸡��ʸ���󤬤ʤ����
;;;               (goto-char (point-min))
;;;               (not (funcall
;;;                     (if isearch-forward
;;;                         're-search-forward 're-search-backward)
;;;                     (migemo-get-pattern isearch-string) nil t))))
;;;    ;; migemo �� isearch �˼��Ԥ����餽�����鼡ñ��Ȥ���
;;;    (dolist (var (list 'isearch-string 'isearch-message))
;;;      (let ((str (symbol-value var)))
;;;        (set var (my-ren-cap str))));; (length str)))))
;;;    ;; �Ƹ��� -- isearch-barrier ����Ǥ����Τ��ʡ�
;;;    (goto-char isearch-opoint)
;;;    (isearch-search)))


;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=no%20migemo
;; ʸ����Хåե����饳�ԡ�����Ȥ��ˤ�
;; migemo �򥪥դˤ���
;;;(defadvice isearch-yank-string
;;;  (before migemo-off activate)
;;;  (setq migemo-isearch-enable-p nil))
;;;
;;; isearch �Ǹ���������ˤ�
;;; migemo �򥪥�ˤ���
;;;(defadvice isearch-mode
;;;  (before migemo-on activate)
;;;  (setq migemo-isearch-enable-p t))
