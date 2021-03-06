;;;; pos-tip
;;;(install-elisp-from-emacswiki "pos-tip.el")
;;;(install-elisp-from-emacswiki "popup-pos-tip.el")
;;;(install-elisp-from-emacswiki "sdic-inline.el")
;;;(install-elisp-from-emacswiki "sdic-inline-pos-tip.el")
(my-require-and-when 'pos-tip
  (my-require-and-when 'popup-pos-tip
    (defadvice popup-tip
      (around popup-pos-tip-wrapper (string &rest args) activate)
      (if (eq window-system 'x)
          (apply 'popup-pos-tip string args)
        ad-do-it))
    )
  '(my-require-and-when 'sdic-inline
    (sdic-inline-mode t)
    (setq sdic-inline-eiwa-dictionary "~/etc/dict/sdic/eijirou.sdic")
    (setq sdic-inline-waei-dictionary "~/etc/dict/sdic/waeijirou.sdic")
    (my-require-and-when 'sdic-inline-pos-tip
      (setq sdic-inline-display-func 'sdic-inline-pos-tip-show)
      (define-key sdic-inline-map "\C-c\C-p" 'sdic-inline-pos-tip-show)
      )
    )
  (when run-w32
    (pos-tip-w32-max-width-height t)
    )
  )


;;;; alpaca
;;;(install-elisp "http://www.mew.org/~kazu/proj/cipher/alpaca.el")
'(my-autoload-and-when 'alpaca-after-find-file "alpaca"
  (if (fboundp 'epa-file-disable) (epa-file-disable))
  (setq alpaca-cache-passphrase t))
'(add-hook 'find-file-hooks 'alpaca-after-find-file)


;;;; pit
(my-require-and-when 'pit)


;;;; edit-list
;;;(install-elisp "http://mwolson.org/static/dist/elisp/edit-list.el")
'(my-require-and-when 'edit-list)


;;;; lacarte
;;;(install-elisp-from-emacswiki "lacarte.el")
(my-require-and-when 'lacarte)


;;;; a-menu
;;;; http://homepage.mac.com/zenitani/comp-e.html
'(my-require-and-when 'a-menu)


;;;; color-selection
;;;(install-elisp "http://www.bookshelf.jp/elc/color-selection.el")
(my-autoload-and-when 'list-hexadecimal-colors-display "color-selection")


;;;; izonmoji-mode
;;;; http://navi2ch.sourceforge.net/
'(my-require-and-when 'izonmoji-mode)


;;;; japanese-holidays
'(my-require-and-when 'calendar
  (setq number-of-diary-entries 31)
  (define-key calendar-mode-map "f" 'calendar-forward-day)
  (define-key calendar-mode-map "n" 'calendar-forward-day)
  (define-key calendar-mode-map "b" 'calendar-backward-day)
  (setq mark-holidays-in-calendar t))
;;;(install-elisp "http://www.meadowy.org/meadow/netinstall/export/799/branches/3.00/pkginfo/japanese-holidays/japanese-holidays.el")
'(my-require-and-when 'japanese-holidays
  (setq calendar-holidays
        (append japanese-holidays local-holidays other-holidays))
  (setq calendar-weekend-marker 'diary)
  (add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
  (add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend))


;;;; macros
'(my-load-and-when "_window-line")
'(when (not run-w32)
  (my-load-and-when "_scroll-speedup")) ; in windows, I use kbdacc.
'(my-load-and-when "_my-memo"
  (global-set-key "\C-c\C-w" 'my-memo))
(my-load-and-when "_byte-compile-directory")
