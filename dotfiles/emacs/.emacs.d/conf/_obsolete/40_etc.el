;;;;;;;; 40_etc
;;;; Outputz
;;;(install-elisp "http://svn.coderepos.org/share/lang/elisp/outputz/outputz.el")
'(my-require-and-when 'outputz
   (setq outputz-key "Your Private Key")      ;; 復活の呪文
   (setq outputz-uri "http://example.com/%s") ;; 適当なURL。%sにmajor-modeの名前が入るので、major-modeごとのURLで投稿できます。
   (global-outputz-mode t)

   (defun outputz-buffers ()
     (dolist (buf (buffer-list))
       (with-current-buffer buf
         (outputz))))

   (run-with-idle-timer 3 t 'outputz-buffers)
   (remove-hook 'after-save-hook 'outputz))


;;;; typing-outputz
;;;; http://github.com/hayamiz/typing-outputz/tree/master
'(my-require-and-when 'typing-outputz
   (global-typing-outputz-mode t)
   (setq typing-outputz-key "bWAROb-quUbf"))


;; -*-no-byte-compile: t; -*-
