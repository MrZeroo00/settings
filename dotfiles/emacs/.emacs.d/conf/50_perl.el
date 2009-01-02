(add-to-list 'auto-mode-alist '("\\.pl$" . perl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . perl-mode))

(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
