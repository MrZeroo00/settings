;;;; dabbrev-highlight
;;;(install-elisp "http://www.namazu.org/~tsuchiya/elisp/dabbrev-highlight.el")
'(my-require-and-when 'dabbrev-highlight)


;;;; dabbrev-ja
;;;(install-elisp "http://namazu.org/%7Etsuchiya/elisp/dabbrev-ja.el")
'(my-load-and-when "dabbrev-ja")


;;;; abbrev-sort
;;;(install-elisp "http://www.eskimo.com/~seldon/abbrev-sort.el")
'(my-require-and-when 'abbrev-sort)


;;;; ac-mode
;;;(install-elisp "http://taiyaki.org/elisp/ac-mode/src/ac-mode.el")
'(my-autoload-and-when 'ac-mode "ac-mode")


;;;; mcomplete
;;;(install-elisp "http://homepage1.nifty.com/bmonkey/emacs/elisp/mcomplete.el")
;;;(install-elisp "http://www.bookshelf.jp/elc/mcomplete-history.el")
'(my-require-and-when 'mcomplete)
'(my-require-and-when 'cl)
'(my-load-and-when "mcomplete-history"
   (turn-on-mcomplete-mode))


;;;; expand
'(my-require-and-when 'expand
   (expand-add-abbrevs c-mode-abbrev-table
                       expand-c-sample-expand-list)
   (expand-add-abbrevs lisp-interaction-mode-abbrev-table
                       expand-sample-lisp-mode-expand-list)
   (expand-add-abbrevs emacs-lisp-mode-abbrev-table
                       expand-sample-lisp-mode-expand-list)
   (expand-add-abbrevs lisp-mode-abbrev-table
                       expand-sample-lisp-mode-expand-list)
   (expand-add-abbrevs cperl-mode-abbrev-table
                       expand-sample-perl-mode-expand-list))


;;;; hippie-exp
'(my-require-and-when 'hippie-exp)


;;;; icicles
;;;(install-elisp-from-emacswiki "icicles.el")
'(my-require-and-when 'icicles)
