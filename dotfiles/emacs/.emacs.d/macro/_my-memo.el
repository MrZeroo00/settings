;; my-memo
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=my%20memo
(setq my-memo-list
      '("emacs.txt" "url.txt"))
(setq my-memo-dir "~/memo/puti")

(defvar my-memo-window-conf nil)

(require 'newcomment)
(defun my-memo-insert (category memo-text str)
  (let ((coding-system-for-read 'euc-jp-unix)
        (coding-system-for-write 'euc-jp-unix)
        memo-buf (cbuf (current-buffer))
        )

    (if (get-file-buffer
         (expand-file-name category my-memo-dir))
        (setq memo-buf
              (get-file-buffer
               (expand-file-name category my-memo-dir)))
      (setq memo-buf
            (find-file-noselect
             (expand-file-name  category my-memo-dir))))

    (set-buffer memo-buf)
    (goto-char (point-min))
    (insert
     (concat
      (format-time-string "[%Y/%m/%d %k:%M:%S] ")
      memo-text))
    (if (and comment-add
             (= comment-add 0))
        ()
      (comment-region
       (save-excursion (goto-char (point-min))
                       (push-mark nil nil t) (point))
       (save-excursion (end-of-line) (point))))

    (insert (concat
             "\n"
             str
             "\n\n"))

    (insert
     (concat
      "------------------------------------------------------------"
      "\n"))
    (forward-line -1)
    (if (and comment-add
             (= comment-add 0))
        ()
      (comment-region
       (save-excursion
         (beginning-of-line) (push-mark nil nil t) (point))
       (save-excursion
         (forward-line 1) (beginning-of-line) (point))))
    (save-buffer)
    (set-buffer cbuf)
    (kill-buffer memo-buf)
    ))

(defun my-memo-initialize ()
  (if (and (file-exists-p my-memo-dir)
           (file-directory-p my-memo-dir))
      ()
    (make-directory my-memo-dir))
  )

(defun my-memo-read-category ()
  (let ((file-list nil) category)
    ;; directory list
    (setq file-list (mapcar '(lambda (file)
                               (if (and (string-match ".+$" file)
                                        (not (file-directory-p file)))
                                   file))
                            (directory-files my-memo-dir)))

    (setq file-list (delq nil file-list))
    (setq file-list (append my-memo-list file-list))
    (setq category (completing-read
                    "memo category : "
                    (mapcar 'list file-list)
                    nil nil))
    (if (file-name-extension category)
        ()
      (setq category (concat category ".txt")))
    category
    ))

(defun my-memo-new ()
  (interactive)
  (let (category memo-text str)
    (setq str (buffer-substring (point-min) (point-max)))
    (my-memo-initialize)
    (setq category (my-memo-read-category))
    (setq memo-text (read-from-minibuffer "input memo : "))
    (my-memo-insert category memo-text str)
    (kill-buffer (current-buffer))
    (set-window-configuration my-memo-window-conf)
    ))

(defun my-memo (&optional arg)
  (interactive "P")
  (let (category memo-text str
                 (cbuf (current-buffer))
                 )
    (setq my-memo-window-conf (current-window-configuration)))

  (cond
   (arg
    (let ((moccur-use-migemo nil)
          (dmoccur-mask-internal '(".*"))
          (moccur-split-word nil))
      (dmoccur my-memo-dir "\\[[/0-9]+ [/:0-9]+\\]" nil)))

   (mark-active
    (setq str (buffer-substring (region-beginning) (region-end)))
    (my-memo-initialize)
    (setq category (my-memo-read-category))
    (setq memo-text (read-from-minibuffer "input memo : "))
    (my-memo-insert category memo-text str)
    )
   (t
    (with-output-to-temp-buffer "*my-memo*"
      (switch-to-buffer "*my-memo*")
      (kill-all-local-variables)

      (local-set-key "\C-c\C-c" 'my-memo-new)))

   ))

;; 必要に応じてキーバインドを追加
;(global-set-key "\C-c\C-w" 'my-memo)
