(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(quietly-read-abbrev-file)
(setq save-abbrevs t)
(add-hook 'pre-command-hook
          (lambda ()
            (setq abbrev-mode nil)))

; for coding
(setq dabbrev-case-fold-search nil)
(setq dabbrev-case-replace nil)


;; auto-complete
;(install-elisp-from-emacswiki "auto-complete.el")
(my-require-and-when 'auto-complete)
(global-auto-complete-mode t)
(setq ac-candidate-max 15)
(setq ac-sources '(ac-source-abbrev
                   ac-source-words-in-buffer
                   ac-source-files-in-current-dir))
(add-hook 'c-mode-common-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (add-to-list 'ac-sources 'ac-source-yasnippet)))
;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; http://d.hatena.ne.jp/kiwanami/20081124/1227543508
(defun ac-next-or-next-line (arg)
  (interactive "p")
  (if (= (length ac-candidates) 1)
      (progn (ac-abort)
             (next-line arg))
    (ac-next)))
(defun ac-previous-or-previous-line (arg)
  (interactive "p")
  (if (= (length ac-candidates) 1)
      (progn (ac-abort)
             (previous-line arg))
    (ac-previous)))
(define-key ac-complete-mode-map "\C-n" 'ac-next-or-next-line)
(define-key ac-complete-mode-map "\C-p" 'ac-previous-or-previous-line)


;; dabbrev-highlight
;(install-elisp "http://www.namazu.org/~tsuchiya/elisp/dabbrev-highlight.el")
(my-require-and-when 'dabbrev-highlight)


;; dabbrev-ja
;(install-elisp "http://namazu.org/%7Etsuchiya/elisp/dabbrev-ja.el")
;(load "dabbrev-ja")


;; abbrev-sort
;(install-elisp "http://www.eskimo.com/~seldon/abbrev-sort.el")
;(my-require-and-when 'abbrev-sort)


;; ac-mode
;(install-elisp "http://taiyaki.org/elisp/ac-mode/src/ac-mode.el")
;(autoload 'ac-mode "ac-mode" "Minor mode for advanced completion." t nil)


;; mcomplete
;(install-elisp "http://homepage1.nifty.com/bmonkey/emacs/elisp/mcomplete.el")
;(my-require-and-when 'mcomplete)
;(my-require-and-when 'cl)
;(install-elisp "http://www.bookshelf.jp/elc/mcomplete-history.el")
;(load "mcomplete-history")
;(turn-on-mcomplete-mode)


;; expand
;(my-require-and-when 'expand)
;(expand-add-abbrevs c-mode-abbrev-table
;                    expand-c-sample-expand-list)
;(expand-add-abbrevs lisp-interaction-mode-abbrev-table
;                    expand-sample-lisp-mode-expand-list)
;(expand-add-abbrevs emacs-lisp-mode-abbrev-table
;                    expand-sample-lisp-mode-expand-list)
;(expand-add-abbrevs lisp-mode-abbrev-table
;                    expand-sample-lisp-mode-expand-list)
;(expand-add-abbrevs cperl-mode-abbrev-table
;                    expand-sample-perl-mode-expand-list)


;; hippie-exp
;(my-require-and-when 'hippie-exp)


;; icicles
;(install-elisp-from-emacswiki "icicles.el")
;(my-require-and-when 'icicles)


;; macros
;(load "_maybe-capitalize-bos")
