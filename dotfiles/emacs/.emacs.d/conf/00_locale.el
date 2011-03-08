;;;; language setting
'(my-require-and-when 'un-define)
'(set-language-environment "Japanese")
'(set-language-environment 'utf-8)
'(prefer-coding-system 'utf-8)

(cond
  (run-darwin
   (set-language-environment 'utf-8)
   (prefer-coding-system 'utf-8)
   (my-require-and-when 'ucs-normalize
     (setq file-name-coding-system 'utf-8-hfs)
     (setq locale-coding-system 'utf-8-hfs))
   )
  ((or run-w32 run-cygwin)
   (setq file-name-coding-system 'utf-8)
   (setq locale-coding-system 'utf-8)
   ;; if use command prompt
   ;;(setq file-name-coding-system 'sjis)
   ;;(setq locale-coding-system 'sjis)
   ;; if use old Cygwin
   ;;(setq file-name-coding-system 'euc-jp)
   ;;(setq locale-coding-system 'euc-jp)
   )
  (t
   (setq file-name-coding-system 'utf-8)
   (setq locale-coding-system 'utf-8)
   ))

;;; same as prefer-coding-system
'(set-default-coding-systems 'utf-8)
'(set-terminal-coding-system 'utf-8)
'(set-keyboard-coding-system 'utf-8)
'(set-buffer-file-coding-system 'utf-8)
'(setq default-buffer-file-coding-system 'utf-8)
'(set-file-name-coding-system 'utf-8)
'(setq default-process-coding-system
       '(utf-8 . utf-8))

'(set-buffer-process-coding-system 'utf-8 'utf-8)
'(set-clipboard-coding-system 'utf-8)
'(add-hook 'find-file-hooks
           (lambda ()
             (setq coding-system-for-read 'utf-8)
             (setq coding-system-for-write 'utf-8)))


;;;; locale setting
(setenv "LC_TIME" "C")
