;; minibuf-shrink
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=minibuffer%20shrink
(defvar minibuf-shrink-type0-chars '((w3m-input-url-history . (?/ ?+ ?:))
                                     (read-expression-history . (?\) ))
                                     (t . (?/ ?+ ?~ ?:)))
  "*minibuffer-history-variable �ȥ��ѥ졼���ȸ��ʤ� character �� alist ��
type0 �ϥ��ѥ졼����Ĥ���Ρ�")

(defvar minibuf-shrink-type1-chars '((file-name-history . (?.))
                                     (w3m-input-url-history . (?# ?? ?& ?.))
                                     (t . (?- ?_ ?. ? )))
  "*minibuffer-history-variable �ȥ��ѥ졼���ȸ��ʤ� character �� alist ��
type1 �ϥ��ѥ졼����õ���Ρ�")

(defun minibuf-shrink-get-chars (types)
  (or (cdr (assq minibuffer-history-variable types))
      (cdr (assq t types))))

(defun minibuf-shrink (&optional args)
  "point �� buffer �κǸ�ʤ� 1 word �õ�롣����¾�ξ��� delete-char ��ư���롣
ñ��Υ��ѥ졼���� minibuf-shrink-type[01]-chars ��"
  (interactive "p")
  (if (/= (if (fboundp 'field-end) (field-end) (point-max)) (point))
      (delete-char args)
    (let ((type0 (minibuf-shrink-get-chars minibuf-shrink-type0-chars))
          (type1 (minibuf-shrink-get-chars minibuf-shrink-type1-chars))
          (count (if (<= args 0) 1 args))
          char)
      (while (not (zerop count))
        (when (memq (setq char (char-before)) type0)
          (delete-char -1)
          (while (eq char (char-before))
            (delete-char -1)))
        (setq count (catch 'detect
                      (while (/= (if (fboundp 'field-beginning)
                                     (field-beginning) (point-min))
                                 (point))
                        (setq char (char-before))
                        (cond
                         ((memq char type0)
                          (throw 'detect (1- count)))
                         ((memq char type1)
                          (delete-char -1)
                          (while (eq char (char-before))
                            (delete-char -1))
                          (throw 'detect (1- count)))
                         (t (delete-char -1))))
                      ;; exit
                      0))))))

(defvar minibuf-expand-filename-original nil)
(defvar minibuf-expand-filename-begin nil)

(defun minibuf-expand-filename (&optional args)
  "file-name-history ���ä��� minibuffer �����Ƥ� expand-file-name ���롣
Ϣ³���Ƶ�ư����ȸ����᤹�� C-u �դ����� link ��Ÿ�����롣"
  (interactive "P")
  (when (eq minibuffer-history-variable 'file-name-history)
    (let* ((try-again (eq last-command this-command))
           (beg (cond
                 ;; Emacs21.3.50 + ange-ftp ���� 2 ���ܤ��Ѥˤʤ�
                 ((and try-again minibuf-expand-filename-begin)
                  minibuf-expand-filename-begin)
                 ((fboundp 'field-beginning) (field-beginning))
                 (t (point-min))))
           (end (if (fboundp 'field-end) (field-end) (point-max)))
           (file (buffer-substring-no-properties beg end))
           (remote (when (string-match "^\\(/[^:/]+:\\)/" file)
                     (match-string 1 file)))
           (home (if (string-match "^\\(/[^:/]+:\\)/" file)
                     (expand-file-name (format "%s~" (match-string 1 file)))
                   (expand-file-name "~"))))
      (unless try-again
        (setq minibuf-expand-filename-begin beg))
      (cond
       ((and args try-again minibuf-expand-filename-original)
        (setq file (file-chase-links (expand-file-name file))))
       (args
        (setq minibuf-expand-filename-original file)
        (setq file (file-chase-links (expand-file-name file))))
       ((and try-again minibuf-expand-filename-original)
        (setq file minibuf-expand-filename-original)
        (setq minibuf-expand-filename-original nil))
       (t
        (setq minibuf-expand-filename-original file)
        (if (string-match (concat "^" (regexp-quote home)) file)
            (if remote
                (setq file (concat remote "~" (substring file (match-end 0))))
              (setq file (concat "~" (substring file (match-end 0)))))
          (setq file (expand-file-name file)))))
      (delete-region beg end)
      (insert file))))

(mapcar (lambda (map)
          (define-key map "\C-d" 'minibuf-shrink)
          (define-key map "\M-\C-d" 'minibuf-expand-filename))
        (delq nil (list (and (boundp 'minibuffer-local-map)
                             minibuffer-local-map)
                        (and (boundp 'minibuffer-local-ns-map)
                             minibuffer-local-ns-map)
                        (and (boundp 'minibuffer-local-completion-map)
                             minibuffer-local-completion-map)
                        (and (boundp 'minibuffer-local-must-match-map)
                             minibuffer-local-must-match-map))))
