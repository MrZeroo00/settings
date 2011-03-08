'(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              ))
  (when (and (file-exists-p dir) (not (member dir exec-path)))
	(setenv "PATH" (concat dir ":" (getenv "PATH")))
	(setq exec-path (append (list dir) exec-path))))


;;;; ns-platform-support
;;;(install-elisp-from-emacswiki "ns-platform-support.el")
(my-require-and-when 'ns-platform-support
  ;;(ns-extended-platform-support-mode 1)
  )
