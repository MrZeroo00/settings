;; find-file-hooks
;(add-hook 'find-file-hooks
;          (function (lambda ()
;                      (if (string-match "/foo/bar/baz" buffer-file-name)
;                          (setq foo baz))
;                      )))

;; dirvars (set directory local variables)
(require 'dirvars)

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

; auto byte-compile when saving ".emacs"
;(add-hook 'after-save-hook
;          (function (lambda ()
;                      (if (string= (expand-file-name "~/.emacs.el")
;                                   (buffer-file-name))
;                          (save-excursion
;                            (byte-compile-file "~/.emacs.el"))))))