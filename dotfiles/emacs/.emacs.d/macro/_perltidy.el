;; perltidy
;; http://svn.coderepos.org/share/dotfiles/emacs/typester/.emacs.d/conf/50_perl.el
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))

;(global-set-key "\C-ct" 'perltidy-region)
;(global-set-key "\C-c\C-t" 'perltidy-defun)
