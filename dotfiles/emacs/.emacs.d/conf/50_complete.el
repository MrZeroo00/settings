(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(quietly-read-abbrev-file)
(setq save-abbrevs t)
(add-hook 'pre-command-hook
          (lambda ()
            (setq abbrev-mode nil)))

;;;; for coding
(setq dabbrev-case-fold-search nil)
(setq dabbrev-case-replace nil)


;;;; ac-company
;;;(install-elisp "http://github.com/buzztaiki/auto-complete/raw/master/ac-company.el")


;;;; auto-complete
;;;; http://github.com/m2ym/auto-complete
;;;(install-elisp-from-emacswiki "auto-complete.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/auto-complete.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/auto-complete-config.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/popup.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/fuzzy.el")
(my-require-and-when 'auto-complete-config
  (global-auto-complete-mode t)
  (set-face-background 'ac-candidate-face "lightgray")
  (set-face-underline 'ac-candidate-face "darkgray")
  (set-face-background 'ac-selection-face "steelblue")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (define-key ac-completing-map "\C-n" 'ac-next)
  (define-key ac-completing-map "\C-p" 'ac-previous)
  (ac-set-trigger-key "TAB")
  (setq ac-auto-start 2)
  (setq ac-candidate-max 15)
  (setq ac-dwim t)
  (setq-default ac-sources '(ac-source-words-in-buffer
;;;                             ac-source-words-in-same-mode-buffers
                             ac-source-abbrev
;;;                             ac-source-files-in-current-dir
                             ))
  (add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))
  (add-hook 'c-mode-common-hook
            (lambda ()
              (make-local-variable 'ac-sources)
              (add-to-list 'ac-sources 'ac-source-yasnippet)))

  ;; http://d.hatena.ne.jp/kiwanami/20081124/1227543508
;;;  (defun ac-next-or-next-line (arg)
;;;    (interactive "p")
;;;    (if (= (length ac-candidates) 1)
;;;        (progn (ac-abort)
;;;               (next-line arg))
;;;      (ac-next)))
;;;  (defun ac-previous-or-previous-line (arg)
;;;    (interactive "p")
;;;    (if (= (length ac-candidates) 1)
;;;        (progn (ac-abort)
;;;               (previous-line arg))
;;;      (ac-previous)))
;;;  (define-key ac-complete-mode-map "\C-n" 'ac-next-or-next-line)
;;;  (define-key ac-complete-mode-map "\C-p" 'ac-previous-or-previous-line)
  )


;;;; dabbrev-highlight
;;;(install-elisp "http://www.namazu.org/~tsuchiya/elisp/dabbrev-highlight.el")
(my-require-and-when 'dabbrev-highlight)


;;;; dabbrev-ja
;;;(install-elisp "http://namazu.org/%7Etsuchiya/elisp/dabbrev-ja.el")
;;;(my-load-and-when "dabbrev-ja")


;;;; abbrev-sort
;;;(install-elisp "http://www.eskimo.com/~seldon/abbrev-sort.el")
;;;(my-require-and-when 'abbrev-sort)


;;;; ac-mode
;;;(install-elisp "http://taiyaki.org/elisp/ac-mode/src/ac-mode.el")
;;;(my-autoload-and-when 'ac-mode "ac-mode")


;;;; mcomplete
;;;(install-elisp "http://homepage1.nifty.com/bmonkey/emacs/elisp/mcomplete.el")
;;;(my-require-and-when 'mcomplete)
;;;(my-require-and-when 'cl)
;;;(install-elisp "http://www.bookshelf.jp/elc/mcomplete-history.el")
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
;;;(my-require-and-when 'hippie-exp)


;;;; icicles
;;;(install-elisp-from-emacswiki "icicles.el")
;;;(my-require-and-when 'icicles)


;;;; macros
;;;(my-load-and-when "_maybe-capitalize-bos")
