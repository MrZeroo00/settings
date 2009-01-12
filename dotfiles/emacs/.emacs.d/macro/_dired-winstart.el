;; uenox-dired-winstart
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=dired%20fiber
;;--------------------------------------------------------
;;; Dired �� Windows �˴�Ϣ�դ���줿�ե������ư���롣
;;;http://uenox.infoseek.livedoor.com/meadow/
;;--------------------------------------------------------
(defun uenox-dired-winstart ()
  "Type '\\[uenox-dired-winstart]': win-start the current line's file."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename)))
        (w32-shell-execute "open" fname)
        (message "win-started %s" fname))))
;;; dired �Υ�����������ɲ�
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "z" 'uenox-dired-winstart))) ;;; ��Ϣ�դ�
