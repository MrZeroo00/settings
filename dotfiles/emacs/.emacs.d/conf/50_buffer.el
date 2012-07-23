'(setq special-display-buffer-names '("*Help*" "*compilation*" "*interpretation*" "*Occur*"))


;;;; uniquify (add directory name)
(my-require-and-when 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))
'(setq uwpn-project-root-alist
      '(("/opt/t/prj1" . "Project A")
        ("/opt/t/prj2" . "Project B")
        ;;("" . "")
        ))
(my-require-and-when 'uniquify_with_project_name)


;;;; midnight
(my-require-and-when 'midnight)


;;;; auto-revert-mode
'(global-auto-revert-mode)
(setq auto-revert-check-vc-info t)
;(setq auto-revert-interval 1)
(defun my-auto-revert-mode-when-using-vcs ()
  (when
      (and buffer-file-name
           (vc-backend buffer-file-name))
    (auto-revert-mode)))
(add-hook 'find-file-hook 'my-auto-revert-mode-when-using-vcs)


;;;; tail
;;;; http://d.hatena.ne.jp/kitokitoki/20101211/p1
(defvar auto-revert-tail-mode nil)
(defun my-auto-revert-tail-mode-on ()
  (interactive)
  (when (string-match "^/var/log/" default-directory)
    (auto-revert-tail-mode t)))

(add-hook 'find-file-hook 'my-auto-revert-tail-mode-on)
(defun my-auto-revert-tail-mode-goto-tail ()
  (when auto-revert-tail-mode
	(end-of-buffer)))
(add-hook 'after-revert-hook 'my-auto-revert-tail-mode-goto-tail)


;;;; tempbuf
;;;(install-elisp-from-emacswiki "tempbuf.el")
'(my-require-and-when 'tempbuf
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'Man-mode-hook 'turn-on-tempbuf-mode))


;;;; contentswitch
;;;(install-elisp-from-emacswiki "contentswitch.el")
'(my-require-and-when 'contentswitch)


;;;; macros
(my-load-and-when "_my-kill-buffers")
(my-load-and-when "_my-save-and-kill-buffer")
'(my-load-and-when "_my-make-scratch"
  (defun my-make-scratch-renew ()
	;; when save *scratch* buffer, create new *scratch* buffer
	(unless (member "*scratch*" (my-buffer-name-list))
	  (my-make-scratch t)))
  (add-hook 'after-save-hook 'my-make-scratch-renew))
