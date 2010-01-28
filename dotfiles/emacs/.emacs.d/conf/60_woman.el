(my-autoload-and-when 'woman "woman")
(my-autoload-and-when 'woman-find-file "woman")

(my-eval-after-load "woman"
  (setq woman-cache-filename (expand-file-name "~/.womancache"))
  (setq woman-cache-level 3)
  (setq woman-use-own-frame nil)

  ;; woman-at-point
  ;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=occur-at-point
  (defun woman-at-point()
    "point のある位置の単語を woman にかける"
    (interactive)
    (if (thing-at-point 'word)
        (woman (thing-at-point 'word))
      (call-interactively 'woman)))
  )
