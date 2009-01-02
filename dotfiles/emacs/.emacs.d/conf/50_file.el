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


;; auto-save-buffers (save buffers automatically)
;(load "auto-save-buffers")


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
;(add-hook 'after-save-hook
;          (function (lambda ()
;                      (if (string= (expand-file-name "~/.emacs.el")
;                                   (buffer-file-name))
;                          (save-excursion
;                            (byte-compile-file "~/.emacs.el"))))))