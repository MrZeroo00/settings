;; find-file-hooks
;(add-hook 'find-file-hooks
;          (function (lambda ()
;                      (if (string-match "/foo/bar/baz" buffer-file-name)
;                          (setq foo baz))
;                      )))


(auto-compression-mode t)
(setq completion-ignored-extensions
      (append completion-ignored-extensions
              '(".exe" ".com")))
(auto-image-file-mode t)
(recentf-mode t)
;(filesets-init)
;(file-name-shadow-mode t)
; complete
;(partial-completion-mode t)
(setq read-file-name-completion-ignore-case t)


;; dircolors (coloring file names)
;(install-elisp "http://lfs.irisa.fr/~pad/rawaccess.query/hacks/dircolors.el")
;(require 'dircolors)


;; filecache (open long filename easily)
(require 'filecache)
;(file-cache-add-directory-list
; (list "~"))
(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
     (file-cache-add-directory-using-find "~/.emacs.d/")
     ))
(defun file-cache-add-this-file ()
  (and buffer-file-name
       (file-exists-p buffer-file-name)
       (file-cache-add-file buffer-file-name)))
(add-hook 'kill-buffer-hook 'file-cache-add-this-file)
(define-key minibuffer-local-completion-map
  "\C-c\C-i" 'file-cache-minibuffer-complete)


;; ffap (open cursor position file)
(ffap-bindings)
;(setq ffap-newfile-prompt t)
(setq ffap-rfc-path "http://www.ring.gr.jp/archives/doc/RFC/rfc%s.txt")
(setq ffap-dired-wildcards "*")
(setq ffap-machine-p-known 'accept)
(setq ffap-kpathsea-depth 5)


;; highlight-completion
;(install-elisp "http://www.math.washington.edu/~palmieri/Emacs/Hlc/highlight-completion.el")
;(setq hc-ctrl-x-c-is-completion t)
;(require 'highlight-completion)
;(highlight-completion-mode t)
;(global-set-key "\C-\\" 'toggle-input-method)


;; saveplace (save cursor position in last edit session)
;(load "saveplace")
;(setq-default save-place t)


;; multiverse
;; http://d.hatena.ne.jp/rubikitch/20081218/multiverse
;(install-elisp-from-emacswiki "multiverse.el")
(require 'multiverse)

(defun my-save-buffer (arg)
  (interactive "P")
  (if arg
      (multiverse-store)
    (save-buffer)))

(global-set-key "\C-x\C-s" 'my-save-buffer)


;; auto-save-buffers-enhanced
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/auto-save-buffers-enhanced/trunk/auto-save-buffers-enhanced.el")
;(require 'auto-save-buffers-enhanced)
;(auto-save-buffers-enhanced-include-only-checkout-path t)
;(auto-save-buffers-enhanced t)
;(global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)
;;(setq auto-save-buffers-enhanced-include-regexps '(".+"))
;;(setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$"))


;; auto-save-buffers (save buffers automatically)
;(install-elisp "http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el")
;(load "auto-save-buffers")
;(run-with-idle-timer 0.5 t 'auto-save-buffers)


;; make executable if script file
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)


;; auto byte-compile when saving ".emacs"
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=byte-compile%20after%20save
;(add-hook 'after-save-hook
;          (function (lambda ()
;                      (if (string= (expand-file-name "~/.emacs.el")
;                                   (buffer-file-name))
;                          (save-excursion
;                            (byte-compile-file "~/.emacs.el"))))))


(when (and run-w32 run-meadow)
  '(progn
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
             (insert (ls-lisp-parse-symlink file))))))))


;; macros
(load "_reopen-file")
(define-key ctl-x-map "\C-r" 'reopen-file)
;(load "_save-buffer-wrapper")
;(global-set-key "\C-x\C-s" 'save-buffer-wrapper)
(load "_delete-file-if-no-contents")
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (add-hook 'after-save-hook 'delete-file-if-no-contents))
;(load "_file-cache-read-save-cache")
;(file-cache-read-cache-from-file "~/.emacs.d/.file_cache")
;(load "_Yama-binary-file-view")
