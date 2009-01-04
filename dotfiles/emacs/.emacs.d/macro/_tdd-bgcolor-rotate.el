;; assist TDD
;; http://d.hatena.ne.jp/xcezx/20080305/1204698047
;; http://coderepos.org/share/browser/dotfiles/emacs/typester/.emacs.d/conf/60_tdd.el
(defvar tdd-bgcolor-alist
  '(("Think"       . "while")
    ("Red"         . "#ff4444")
    ("Green"       . "#44dd44")
    ("Refactoring" . "#ffaa44")))

(defvar tdd-bgcolor-mode 3)
(defvar tdd-bgcolor-mode-name "")
(let (
      (cell (or (memq 'mode-line-position mode-line-format)
                (memq 'mode-line-buffer-identification mode-line-format)))
      (newcdr 'tdd-bgcolor-mode-name))
  (unless (member newcdr mode-line-format)
    (setcdr cell (cons newcdr (cdr cell)))))

(defun tdd-bgcolor-rotate ()
  (interactive)
  (let (pair)
    (if (>= tdd-bgcolor-mode 3)
        (setq tdd-bgcolor-mode 0)
      (setq tdd-bgcolor-mode
            (+ tdd-bgcolor-mode 1)))
    (setq pair
          (nth tdd-bgcolor-mode tdd-bgcolor-alist))
    (setq tdd-bgcolor-mode-name (format "[%s]" (car pair)))
    (message tdd-bgcolor-mode-name)
    (set-face-foreground 'mode-line (cdr pair))
    (set-face-bold-p 'mode-line t)
    ))
