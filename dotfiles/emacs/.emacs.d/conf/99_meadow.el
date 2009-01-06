(load "gnuserv")
(gnuserv-start)
(setq gnuserv-frame (selected-frame))


;; buffer-fiber-exe
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=fiberfile
(defun buffer-fiber-exe ()
  (interactive)
  (let ((file (buffer-file-name)))
    (cond
     ((string= major-mode 'dired-mode)
      (if (string-match "^\\([a-z]:\\)/$" default-directory)
          (start-process "explorer" "diredfiber" "explorer.exe"
                         (match-string 1 default-directory))
        (start-process "explorer" "diredfiber" "explorer.exe"
                       (unix-to-dos-filename
                        (directory-file-name
                         default-directory)))))
     ((and mmemo-buffer-file-name
           (file-exists-p mmemo-buffer-file-name))
      (start-process "fiber" "diredfiber" "fiber.exe"
                     mmemo-buffer-file-name))
     ((not file)
      (error
       "現在のバッファはファイルではありません"))
     ((file-directory-p file)
      (start-process
       "explorer" "diredfiber" "explorer.exe"
       (unix-to-dos-filename file)))
     ((file-exists-p file)
      (start-process
       "fiber" "diredfiber" "fiber.exe" file))
     ((not (file-exists-p file))
      (error "ファイルが存在しません")))))
