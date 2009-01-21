;; dired-make-symbolic-link
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=link%20dired
(setq w32-symlinks-make-using 'wsh)
(setq w32-symlinks-ln-script
      (expand-file-name "~/w32-symlinks-ln-s.js"))

(defadvice w32-symlinks-make-using-wsh
  (around make-shortcut activate)
  (w32-symlinks-check-ln-script)
  (if (not (string= (substring newname -4) ".lnk"))
      (setq newname (concat newname ".lnk")))
  (start-process "makelink" "makelink" w32-symlinks-ln-script
                 (unix-to-dos-filename (expand-file-name file))
                 (unix-to-dos-filename (expand-file-name newname)))
  )

(defun dired-make-symbolic-link (newname)
  (interactive "\FName for link to : \n")
  (if (string= "" (file-name-nondirectory newname))
      (error "Input filename for link"))
  (if (not (string= (substring newname -4) ".lnk"))
      (setq newname (concat newname ".lnk")))
  (let ((file (dired-get-filename)))
    (make-symbolic-link file newname)))

;(add-hook 'dired-mode-hook
;          '(lambda ()
;             (define-key dired-mode-map "S" (function dired-make-symbolic-link))
;             ))
