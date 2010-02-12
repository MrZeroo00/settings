;; assuming confluence.el and xml-rpc.el are in your load path
;; http://code.google.com/p/confluence-el/
(my-require-and-when 'confluence)

;; note, all customization must be in *one* custom-set-variables block
;(custom-set-variables
; ;; ... other custimization
;
; ;; confluence customization
; '(confluence-url "http://intranet/confluence/rpc/xmlrpc")
; '(confluence-default-space-alist (list (cons confluence-url "your-default-space-name"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; confluence editing support (with longlines mode)

(my-autoload-and-when 'confluence-get-page "confluence")

(my-eval-after-load "confluence"
  (my-require-and-when 'longlines)
  (add-hook 'confluence-mode-hook 'longlines-mode)
  (add-hook 'confluence-before-save-hook 'longlines-before-revert-hook)
  (add-hook 'confluence-before-revert-hook 'longlines-before-revert-hook)
  (add-hook 'confluence-mode-hook '(lambda () (local-set-key "\C-j" 'confluence-newline-and-indent)))
  (global-set-key "\C-xwf" 'confluence-get-page))

;; LongLines mode: http://www.emacswiki.org/emacs-en/LongLines
(my-autoload-and-when 'longlines-mode "longlines")

(my-eval-after-load "longlines"
  (defvar longlines-mode-was-active nil)
  (make-variable-buffer-local 'longlines-mode-was-active)

  (defun longlines-suspend ()
    (if longlines-mode
        (progn
          (setq longlines-mode-was-active t)
          (longlines-mode 0))))

  (defun longlines-restore ()
    (if longlines-mode-was-active
        (progn
          (setq longlines-mode-was-active nil)
          (longlines-mode 1))))

  ;; longlines doesn't play well with ediff, so suspend it during diffs
  (defadvice ediff-make-temp-file (before make-temp-file-suspend-ll
                                          activate compile preactivate)
    "Suspend longlines when running ediff."
    (with-current-buffer (ad-get-arg 0)
      (longlines-suspend)))


  (add-hook 'ediff-cleanup-hook
            '(lambda ()
               (dolist (tmp-buf (list ediff-buffer-A
                                      ediff-buffer-B
                                      ediff-buffer-C))
                 (if (buffer-live-p tmp-buf)
                     (with-current-buffer tmp-buf
                       (longlines-restore)))))))

;; setup confluence mode
(add-hook 'confluence-mode-hook
          '(lambda ()
             (local-set-key "\C-xw" confluence-prefix-map)))

(add-hook 'confluence-mode-hook
          (lambda ()
            (setq truncate-lines nil)
            (setq truncate-partial-width-windows nil)
            (auto-show-mode)))

(add-hook 'confluence-mode-hook
          (lambda ()
            (setq outline-regexp "^h[1-5]\\.")
            (setq outline-heading-end-regexp "\n")
            (setq outline-level
                  (function (lambda ()
                              (save-excursion
                                (looking-at outline-regexp)
                                (char-after (1- (match-end 0)))))))
;;;            (outline-minor-mode t)
            (turn-on-orgstruct)))
