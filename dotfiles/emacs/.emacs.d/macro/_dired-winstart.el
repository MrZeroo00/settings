;; uenox-dired-winstart
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=dired%20fiber
;;--------------------------------------------------------
;;; Dired で Windows に関連付けられたファイルを起動する。
;;;http://uenox.infoseek.livedoor.com/meadow/
;;--------------------------------------------------------
(defun uenox-dired-winstart ()
  "Type '\\[uenox-dired-winstart]': win-start the current line's file."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename)))
        (w32-shell-execute "open" fname)
        (message "win-started %s" fname))))
;;; dired のキー割り当て追加
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "z" 'uenox-dired-winstart))) ;;; 関連付け
