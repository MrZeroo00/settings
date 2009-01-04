(require 'lisp-mode)

; association setting
(add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (define-key emacs-lisp-mode-map "\C-m" 'newline-and-indent)))


;; anything
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (make-local-variable 'anything-sources)
            (add-to-list 'anything-sources
                         'anything-c-source-lisp-complete-symbol
                         'anything-c-source-linkd-tag)))


;; eldoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)


;; checkdoc
;(require 'checkdoc)
