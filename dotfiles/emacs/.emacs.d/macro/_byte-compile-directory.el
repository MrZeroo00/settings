;; byte-compile-directory
;; http://d.hatena.ne.jp/risutaka/20081226/1230301315
(defun _byte-compile-directory (dir)
  (interactive "DDirectory: ")
  (dolist (files (directory-files dir t "[^\\.]+"))
    (cond
     ((file-directory-p files) (_byte-compile-directory files))
     ((string-match "\\.el$" (file-name-nondirectory files)) (byte-compile-file files))
     (t nil))))
