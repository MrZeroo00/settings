(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-s" 'search-forward-regexp)
'(global-set-key "\M-m" 'blink-matching-open)
(define-key ctl-x-map "\C-z"
  (if window-system 'iconify-or-deiconify-frame 'suspend-emacs))
(global-set-key [mouse-3] 'yank)


;;;; my-keyjack-mode
;;;; http://www.pqrs.org/tekezo/emacs/doc/keyjack-mode/index.html
(setq my-keyjack-mode-map (make-sparse-keymap))

(mapcar (lambda (x)
          (define-key my-keyjack-mode-map (car x) (cdr x))
          (global-set-key (car x) (cdr x)))
        '(("\M-SPC" . just-one-space)
          ("\C-\M-k" . windmove-up)
          ("\C-\M-j" . windmove-down)
          ("\C-\M-h" . windmove-left)
          ("\C-\M-l" . windmove-right)
          ([S-up] . windmove-up)
          ([S-down] . windmove-down)
          ([S-left] . windmove-left)
          ([S-right] . windmove-right)
          ([(home)] . beginning-of-buffer)
          ([(end)] . end-of-buffer)
          ))

(easy-mmode-define-minor-mode my-keyjack-mode "Grab keys"
                              t " Keyjack" my-keyjack-mode-map)


;;;; sequential-command
;;;(install-elisp-from-emacswiki "sequential-command.el")
;;;(install-elisp-from-emacswiki "sequential-command-config.el")
(my-require-and-when 'sequential-command-config
  (global-set-key "\C-a" 'seq-home)
  (global-set-key "\C-e" 'seq-end)
  (define-key esc-map "u" 'seq-upcase-backward-word)
  (define-key esc-map "c" 'seq-capitalize-backward-word)
  (define-key esc-map "l" 'seq-downcase-backward-word))


;;;; autoarg
'(my-require-and-when 'autoarg)


;;;; viper
'(my-require-and-when 'viper)


;;;; unbound
'(install-elisp-from-emacswiki "unbound.el")
'(my-require-and-when 'unbound)
