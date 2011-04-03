;;;; find-file-hooks
'(defun my-find-file-hooks ()
  (if (string-match "/foo/bar/baz" buffer-file-name)
	  (setq foo baz))
  )
'(add-hook 'find-file-hooks 'my-find-file-hooks)

;;;; before-save-hook
(add-hook 'before-save-hook 'delete-trailing-whitespace)


(auto-compression-mode t)
(setq completion-ignored-extensions
      (append completion-ignored-extensions
              '(".exe" ".com")))
(auto-image-file-mode t)
;;;(filesets-init)
;;;(file-name-shadow-mode t)
;;;; complete
;;;(partial-completion-mode t)
(setq read-file-name-completion-ignore-case t)


;;;; dircolors (coloring file names)
;;;(install-elisp "http://lfs.irisa.fr/~pad/rawaccess.query/hacks/dircolors.el")
;;;(my-require-and-when 'dircolors)


;;;; recentf
(my-require-and-when 'recentf
  (setq recentf-max-saved-items 2000)
  (setq recentf-save-file "~/.emacs.d/data/recentf")
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode t)
  )


;;;; recentf-ext
;;;(install-elisp-from-emacswiki "recentf-ext.el")
(my-require-and-when 'recentf-ext)


;;;; filecache (open long filename easily)
(my-require-and-when 'filecache
;;;  (file-cache-add-directory-list
  ;; (list "~"))
  (message "Loading file cache...")
  (file-cache-add-directory-using-find "~/.emacs.d/")
  (defvar my-file-cache-directories nil)
  (if (listp my-file-cache-directories)
      (dolist (dir my-file-cache-directories)
        (file-cache-add-directory-using-find dir)))
;;;  (defun file-cache-add-this-file ()
;;;    (and buffer-file-name
;;;         (file-exists-p buffer-file-name)
;;;         (file-cache-add-file buffer-file-name)))
;;;  (add-hook 'kill-buffer-hook 'file-cache-add-this-file)
  (define-key minibuffer-local-completion-map
    "\C-c\C-i" 'file-cache-minibuffer-complete))


;;;; ffap (open cursor position file)
;;;(ffap-bindings)
;;;(setq ffap-newfile-prompt t)
;;;(setq ffap-rfc-path "http://www.ring.gr.jp/archives/doc/RFC/rfc%s.txt")
;;;(setq ffap-dired-wildcards "*")
;;;(setq ffap-machine-p-known 'accept)
;;;(setq ffap-kpathsea-depth 5)


;;;; auto-save-buffers-enhanced
;;;(install-elisp "http://svn.coderepos.org/share/lang/elisp/auto-save-buffers-enhanced/trunk/auto-save-buffers-enhanced.el")
'(my-require-and-when 'auto-save-buffers-enhanced
  (auto-save-buffers-enhanced-include-only-checkout-path t)
  (auto-save-buffers-enhanced t)
  (global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)
;;;  (setq auto-save-buffers-enhanced-include-regexps '(".+"))
;;;  (setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$"))
  )


;;;; auto-save-buffers (save buffers automatically)
;;;(install-elisp "http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el")
'(my-require-and-when 'auto-save-buffers
  (run-with-idle-timer 0.5 t 'auto-save-buffers))


;;;; dirvars (set directory local variables)
;;;(install-elisp "http://www.bookshelf.jp/elc/dirvars.el")
(my-require-and-when 'dirvars)


;;;; make executable if script file
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)


(when (and run-w32 run-meadow)
  ;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=findfile%20symlink
  (defadvice minibuffer-complete
    (before expand-symlinks activate)
    (let ((file (expand-file-name
                 (buffer-substring-no-properties
                  (line-beginning-position)
                  (line-end-position)))))
      (when (string-match ".lnk$" file)
        (delete-region
         (line-beginning-position)
         (line-end-position))
        (if (file-directory-p
             (ls-lisp-parse-symlink file))
            (insert
             (concat
              (ls-lisp-parse-symlink file) "/"))
          (insert (ls-lisp-parse-symlink file)))))))


;;;; macros
'(my-load-and-when "_reopen-file"
  (define-key ctl-x-map "\C-r" 'reopen-file))
'(my-load-and-when "_save-buffer-wrapper"
  (global-set-key "\C-x\C-s" 'save-buffer-wrapper))
'(my-load-and-when "_delete-file-if-no-contents"
  (if (not (memq 'delete-file-if-no-contents after-save-hook))
      (add-hook 'after-save-hook 'delete-file-if-no-contents)))
'(my-load-and-when "_file-cache-read-save-cache"
  (file-cache-read-cache-from-file "~/.emacs.d/data/file_cache"))
;;;(my-load-and-when "_Yama-binary-file-view")


;; -*-no-byte-compile: t; -*-
