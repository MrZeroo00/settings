;; find-file-hooks
;(add-hook 'find-file-hooks
;          (function (lambda ()
;                      (if (string-match "/foo/bar/baz" buffer-file-name)
;                          (setq foo baz))
;                      )))


(file-name-shadow-mode t)
(partial-completion-mode t)
(recentf-mode 1)
;(filesets-init)
(auto-compression-mode)
(setq completion-ignored-extensions
      (append completion-ignored-extensions
              '(".exe" ".com")))


;; dircolors (coloring file names)
;(install-elisp "http://lfs.irisa.fr/~pad/rawaccess.query/hacks/dircolors.el")
;(require 'dircolors)


;; filecache (open long filename easily)
(require 'filecache)
(file-cache-add-directory-list
 (list "~"))
(define-key minibuffer-local-completion-map
  "\C-c\C-i" 'file-cache-minibuffer-complete)


;; ffap (open cursor position file)
(ffap-bindings)
;(setq ffap-newfile-prompt t)


;; saveplace (save cursor position in last edit session)
(load "saveplace")
(setq-default save-place t)


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


;; reopen-file
;; http://namazu.org/~satoru/diary/?200203c&to=200203272#200203272
(defun reopen-file ()
  (interactive)
  (let ((file-name (buffer-file-name))
        (old-supersession-threat
         (symbol-function 'ask-user-about-supersession-threat))
        (point (point)))
    (when file-name
      (fset 'ask-user-about-supersession-threat (lambda (fn)))
      (unwind-protect
          (progn
            (erase-buffer)
            (insert-file file-name)
            (set-visited-file-modtime)
            (goto-char point))
        (fset 'ask-user-about-supersession-threat
              old-supersession-threat)))))
(define-key ctl-x-map "\C-r" 'reopen-file)


;; delete no content file
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=delete%20nocontents
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))

(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (= (point-min) (point-max)))
    (when (y-or-n-p "Delete file and kill buffer?")
      (delete-file
       (buffer-file-name (current-buffer)))
      (kill-buffer (current-buffer)))))


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
