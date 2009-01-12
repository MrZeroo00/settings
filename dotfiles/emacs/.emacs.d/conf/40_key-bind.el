(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-s" 'search-forward-regexp)
;(global-set-key "\M-m" 'blink-matching-open)
(global-set-key [mouse-3] 'yank)


;; my-keyjack-mode
;; http://www.pqrs.org/tekezo/emacs/doc/keyjack-mode/index.html
(setq my-keyjack-mode-map (make-sparse-keymap))

(mapcar (lambda (x)
          (define-key my-keyjack-mode-map (car x) (cdr x))
          (global-set-key (car x) (cdr x)))
        '(("\M-SPC" . just-one-space)
          ("\C-\M-k" . windmove-up)
          ("\C-\M-j" . windmove-down)
          ("\C-\M-h" . windmove-left)
          ("\C-\M-l" . windmove-right)
          ([(home)] . beginning-of-buffer)
          ([(end)] . end-of-buffer)
          ))

(easy-mmode-define-minor-mode my-keyjack-mode "Grab keys"
                              t " Keyjack" my-keyjack-mode-map)
