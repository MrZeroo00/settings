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


;;;; yasnippet
;;;(setq yas/trigger-key "TAB")
;;;(my-require-and-when 'yasnippet-config
;;;  (yas/setup "~/.emacs.d/elisp/yasnippet"))


;;;; auto-complete
;;;; http://github.com/m2ym/auto-complete
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/auto-complete.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/auto-complete-config.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/popup.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/fuzzy.el")
(my-require-and-when 'auto-complete-config
		     ;;(ac-config-default)
		     (global-auto-complete-mode t)
		     ;;(setq ac-auto-start 4)
		     (setq ac-auto-start nil)
		     (setq ac-auto-show-menu 0.8)
		     (setq ac-use-menu-map t)
		     (setq ac-dwim t)
		     (setq ac-menu-height 20)
		     (setq ac-candidate-limit 50)
		     (setq ac-ignore-case 'smart)
		     (setq ac-use-fuzzy t)
		     (setq ac-stop-flymake-on-completing t)
		     (ac-flyspell-workaround)
		     (setq ac-trigger-key "TAB")
		     (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
		     (define-key ac-completing-map "\M-/" 'ac-stop)
		     (define-key ac-menu-map "\C-n" 'ac-next)
		     (define-key ac-menu-map "\C-p" 'ac-previous)
		     ;;(setq ac-use-overriding-local-map t)
		     (set-face-background 'ac-candidate-face "lightgray")
		     (set-face-underline 'ac-candidate-face "darkgray")
		     (set-face-background 'ac-selection-face "steelblue")
		     ;;(add-to-list 'ac-modes 'brandnew-mode)
		     (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/dict")
         (add-to-list 'ac-user-dictionary-files "~/.emacs.d/conf/auto-complete/dict")
		     (setq-default ac-sources '(
						ac-source-filename
;;						ac-source-files-in-current-dir
						ac-source-dictionary
;;						ac-source-abbrev
						ac-source-words-in-buffer
;;						ac-source-words-in-same-mode-buffers
;;						ac-source-words-in-all-buffer
						))

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
'(my-require-and-when 'dabbrev-highlight)


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
