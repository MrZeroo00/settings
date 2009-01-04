;; dabbrev-highlight
;(install-elisp "http://www.namazu.org/~tsuchiya/elisp/dabbrev-highlight.el")
(require 'dabbrev-highlight)


;; ac-mode
;(install-elisp "http://taiyaki.org/elisp/ac-mode/src/ac-mode.el")
(autoload 'ac-mode "ac-mode" "Minor mode for advanced completion." t nil)


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


;; mcomplete
;(install-elisp "http://homepage1.nifty.com/bmonkey/emacs/elisp/mcomplete.el")
(require 'mcomplete)
(require 'cl)
;(install-elisp "http://www.bookshelf.jp/elc/mcomplete-history.el")
(load "mcomplete-history")
(turn-on-mcomplete-mode)


;; icicles
;(require 'icicles)
