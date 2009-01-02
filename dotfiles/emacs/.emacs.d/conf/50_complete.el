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


;; mcomplete
;(install-elisp "http://homepage1.nifty.com/bmonkey/emacs/elisp/mcomplete.el")
(require 'mcomplete)
(require 'cl)
;(install-elisp "http://www.bookshelf.jp/elc/mcomplete-history.el")
(load "mcomplete-history")
(turn-on-mcomplete-mode)
