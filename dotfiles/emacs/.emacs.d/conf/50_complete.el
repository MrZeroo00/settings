(setq abbrev-file-name "~/.emacs.d/data/abbrev_defs")
(quietly-read-abbrev-file)
(setq save-abbrevs t)
(add-hook 'pre-command-hook
          (lambda ()
            (setq abbrev-mode nil)))

;;;; for coding
(setq dabbrev-case-fold-search nil)
(setq dabbrev-case-replace nil)


;;;; yasnippet
'(setq yas/trigger-key "TAB")
'(my-require-and-when 'yasnippet-config
  (yas/setup "~/.emacs.d/elisp/yasnippet"))
(my-eval-after-load "yasnippet"
  ;; http://d.hatena.ne.jp/rubikitch/20101204/yasnippet
  (defun yas/expand-link (key)
    "Hyperlink function for yasnippet expansion."
    (delete-region (point-at-bol) (1+ (point-at-eol)))
    (insert key)
    (yas/expand))
  (defun yas/expand-link-choice (&rest keys)
    "Hyperlink to select yasnippet template."
    (yas/expand-link (completing-read "Select template: " keys nil t)))
  ;; (yas/expand-link-choice "defgp" "defcm")
  )


;;;; auto-complete
;;;; http://github.com/m2ym/auto-complete
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/auto-complete.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/auto-complete-config.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/popup.el")
;;;(install-elisp "http://github.com/m2ym/auto-complete/raw/master/fuzzy.el")
(my-require-and-when 'yasnippet		; loading from auto-complete is something wrong
		     (setq yas/root-directory "~/.emacs.d/elisp/yasnippet/snippets/text-mode/")
		     (yas/load-directory yas/root-directory))
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
         (setq ac-comphist-file "~/.emacs.d/data/ac-comphist.dat")
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
						;;ac-source-files-in-current-dir
						ac-source-dictionary
						;;ac-source-abbrev
						ac-source-words-in-buffer
						;;ac-source-words-in-same-mode-buffers
						;;ac-source-words-in-all-buffer
						))

  ;; http://d.hatena.ne.jp/kiwanami/20081124/1227543508
  '(progn
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
    (define-key ac-complete-mode-map "\C-p" 'ac-previous-or-previous-line))
  )


;;;; ac-company
;;;(install-elisp "http://github.com/buzztaiki/auto-complete/raw/master/ac-company.el")


;;;; macros
'(my-load-and-when "_maybe-capitalize-bos")
