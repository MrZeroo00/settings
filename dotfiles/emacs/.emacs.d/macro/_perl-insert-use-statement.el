;; perl-insert-use-statement
;; http://subtech.g.hatena.ne.jp/antipop/20070917/1189962499
;; キーバインドは、とりあえずC-c C-mで。
;(add-hook 'cperl-mode-hook
;          (lambda ()
;            (local-set-key (kbd "\C-c \C-m") 'perl-insert-use-statement)))

(defun perl-insert-use-statement (current-point)
  "use statement auto-insertion."
  (interactive "d")
  (insert-use-statement
   (detect-module-name current-point)
   (detect-insert-point)))

(defun insert-use-statement (module-name insert-point)
  (save-excursion
    (goto-char insert-point)
    (insert (concat "\nuse " module-name ";\n"))))

(defun detect-insert-point ()
  (save-excursion
    (if (re-search-backward "use .+;" 1 t)
        (match-end 0)
      (progn
        (string-match "^$" (buffer-string))
        (match-end 0)))))

(defun detect-module-name (current-point)
  (let ((str (save-excursion
               (buffer-substring
                current-point
                (progn (beginning-of-line) (point))))))
    (if (string-match "\\([[:alnum:]-_:]+\\)$" str)
        (match-string 1 str)
      (error "Module name not found"))))
