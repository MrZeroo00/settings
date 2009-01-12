;; minibuffer-delete-duplicate
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=delete%20history
;; history から重複したのを消す
(require 'cl)
(defun minibuffer-delete-duplicate ()
  (let (list)
    (dolist (elt (symbol-value minibuffer-history-variable))
      (unless (member elt list)
        (push elt list)))
    (set minibuffer-history-variable (nreverse list))))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)
