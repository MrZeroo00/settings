;; find-file-hooks
;(add-hook 'find-file-hooks
;          (function (lambda ()
;                      (if (string-match "/foo/bar/baz" buffer-file-name)
;                          (setq foo baz))
;                      )))

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)