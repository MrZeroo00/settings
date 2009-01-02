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
(setq ffap-newfile-prompt t)


;; saveplace (save cursor position in last edit session)
(load "saveplace")
(setq-default save-place t)


;; auto-save-buffers (save buffers automatically)
(load "auto-save-buffers")


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