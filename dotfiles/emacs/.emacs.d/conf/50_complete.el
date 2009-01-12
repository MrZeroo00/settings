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
(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-sources '(ac-source-abbrev
                   ac-source-words-in-buffer
                   ac-source-files-in-current-dir))
(add-hook 'c-mode-common-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (add-to-list 'ac-sources 'ac-source-yasnippet)))
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)


;; dabbrev-highlight
;(install-elisp "http://www.namazu.org/~tsuchiya/elisp/dabbrev-highlight.el")
(require 'dabbrev-highlight)


;; dabbrev-ja
;(install-elisp "http://namazu.org/%7Etsuchiya/elisp/dabbrev-ja.el")
;(load "dabbrev-ja")


;; abbrev-sort
;(install-elisp "http://www.eskimo.com/~seldon/abbrev-sort.el")
;(require 'abbrev-sort)


;; ac-mode
;(install-elisp "http://taiyaki.org/elisp/ac-mode/src/ac-mode.el")
;(autoload 'ac-mode "ac-mode" "Minor mode for advanced completion." t nil)


;; mcomplete
;(install-elisp "http://homepage1.nifty.com/bmonkey/emacs/elisp/mcomplete.el")
;(require 'mcomplete)
;(require 'cl)
;(install-elisp "http://www.bookshelf.jp/elc/mcomplete-history.el")
;(load "mcomplete-history")
;(turn-on-mcomplete-mode)


;; icicles
;(install-elisp-from-emacswiki "icicles.el")
;(require 'icicles)


;; macros
;(load "_maybe-capitalize-bos")
