(setq woman-cache-filename (expand-file-name "~/.womancache"))
(setq woman-cache-level 3)
(setq woman-use-own-frame nil)

(autoload 'woman "woman"
  "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman"
  "Find, decode and browse a specific UN*X man-page file." t)

;; woman-at-point
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=occur-at-point
(defun woman-at-point()
  "point のある位置の単語を woman にかける"
  (interactive)
  (if (thing-at-point 'word)
      (woman (thing-at-point 'word))
    (call-interactively 'woman)))
