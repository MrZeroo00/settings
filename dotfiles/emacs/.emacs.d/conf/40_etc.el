;;;; pdicv-mode
;;;; http://pdicviewer.naochan.com/el/
;;;(my-require-and-when 'pdicv-search)
;;;(my-require-and-when 'pdicv-mode)
'(my-autoload-and-when 'pdicv "pdicviewer"
     (setq pdicv-dictionary-list
           '((eijiro "~/etc/dictionary/EIJIRO95.DIC" (nil nil sjis sjis))
             (waeijiro "~/etc/dictionary/WAEIJI52.DIC" (sjis nil sjis sjis) t)
;;;                                        (ej (eijiro waeijiro))
             ))
;;;     (global-set-key "\C-c\C-e" 'pdicv-eijiro-search-interactive)
;;;     (global-set-key "\C-c\C-r" 'pdicv-eijiro-search-region)
;;;     (global-set-key "\C-c\C-d" 'pdicv-set-current-dictionary)
;;;     (global-set-key "\C-c\C-i" 'pdicv-search-interactive)
;;;     (global-set-key "\C-c\C-j" 'pdicv-search-region)
;;;     (global-set-key "\C-c\C-p" 'pdicv-mode)
     )


;;;; cheat
;;;(install-elisp "http://sami.samhuri.net/assets/2007/8/10/cheat.el")
;;;(my-require-and-when 'cheat)


;;;; lacarte
;;;(install-elisp-from-emacswiki "lacarte.el")
(my-require-and-when 'lacarte)


;;;; autoarg
;;;(my-require-and-when 'autoarg)


;;;; thing-opt
(my-require-and-when 'thingatpt)
;;;(install-elisp-from-emacswiki "thing-opt.el")
(my-require-and-when 'thing-opt)


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


;;;; clwiki
;;;; http://pop-club.hp.infoseek.co.jp/emacs/changelog.html
;;;(install-elisp "http://www.rubyist.net/~rubikitch/computer/clwiki/clwiki.el")
;;;(my-autoload-and-when 'clwiki "clwiki"
;;;                      (define-key ctl-x-map "M" 'clwiki))
;;;(my-autoload-and-when 'clgrep "clgrep")
;;;(my-autoload-and-when 'clgrep-item "clgrep")
;;;(my-autoload-and-when 'clgrep-item-header "clgrep")
;;;(my-autoload-and-when 'clgrep-item-tag "clgrep")
;;;(my-autoload-and-when 'clgrep-item-notag "clgrep")
;;;(my-autoload-and-when 'clgrep-item-nourl "clgrep")
;;;(my-autoload-and-when 'clgrep-entry "clgrep")
;;;(my-autoload-and-when 'clgrep-entry-header "clgrep")
;;;(my-autoload-and-when 'clgrep-entry-no-entry-header "clgrep")
;;;(my-autoload-and-when 'clgrep-entry-tag "clgrep")
;;;(my-autoload-and-when 'clgrep-entry-notag "clgrep")
;;;(my-autoload-and-when 'clgrep-entry-nourl "clgrep")
;;;(add-hook 'clmemo-mode-hook
;;;          (lambda () (define-key clmemo-mode-map "\C-c\C-g" 'clgrep)))


;;;; postit
;;;(install-elisp "http://www.bookshelf.jp/elc/postit.el")
'(my-autoload-and-when 'postit "postit"
                      (setq postit-colorize 'dark)
                      (setq postit-compress-commands nil))


;;;; stripes
;;;(install-elisp-from-emacswiki "stripes.el")
'(my-require-and-when 'stripes
  (set-face-background 'stripes-face "gray"))


;;;; edit-list
;;;(install-elisp "http://mwolson.org/static/dist/elisp/edit-list.el")
;;;(my-require-and-when 'edit-list)


;;;; color-selection
;;;(install-elisp "http://www.bookshelf.jp/elc/color-selection.el")
(my-autoload-and-when 'list-hexadecimal-colors-display "color-selection")


;;;; izonmoji-mode
;;;; http://navi2ch.sourceforge.net/
'(my-require-and-when 'izonmoji-mode)


;;;; keisen-mule
;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=keisen
'(if window-system
    (my-autoload-and-when 'keisen-mode "keisen-mouse")
  (my-autoload-and-when 'keisen-mode "keisen-mule"))


;;;; enriched-mode
;;;(my-require-and-when 'enriched)


;;;; iimage
;;;(my-require-and-when 'iimage)


;;;; thumbs
;;;(setq thumbs-thumbsdir
;;;      (expand-file-name "~/.emacs-thumbs"))
;;;(setq thumbs-temp-dir (expand-file-name "~/tmp"))
;;;(setq image-file-name-extensions
;;;      '("xcf" "png" "jpeg" "jpg" "gif" "tiff" "tif" "xbm" "xpm" "pbm" "pgm" "ppm"))


;;;; screenshot
;;;(install-elisp-from-emacswiki "screenshot.el")
'(my-require-and-when 'screenshot
  (setq screenshot-schemes
        '(
          ;; To local image directory
          ("local"
           :dir "~/images/")
          ;; To current directory
          ("current-directory"
           :dir default-directory)
          ;; To remote ssh host
          ("remote-ssh"
           :dir "/tmp/"
           :ssh-dir "www.example.org:public_html/archive/"
           :url "http://www.example.org/archive/")
          ;; To EmacsWiki (need yaoddmuse.el)
          ("EmacsWiki"
           :dir "~/.yaoddmuse/EmacsWiki/"
           :yaoddmuse "EmacsWiki")
          ;; To local web server
          ("local-server"
           :dir "~/public_html/"
           :url "http://127.0.0.1/")))
  (setq screenshot-default-scheme "local"))


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


;;; share clipboard
(defvar prev-yanked-text nil "*previous yanked text")

(setq interprogram-cut-function
      (lambda (text &optional push)
        ;; use pipe
        (let ((process-connection-type nil))
          (let ((proc (start-process "cbcopy" nil "cbcopy")))
            (process-send-string proc string)
            (process-send-eof proc)
            ))))

(when run-darwin
  (setq interprogram-paste-function
        (lambda ()
          (let ((text (shell-command-to-string "pbpaste")))
            (if (string= prev-yanked-text text)
                nil
              (setq prev-yanked-text text))))))


;;;; macros
'(my-load-and-when "_window-line")
'(my-load-and-when "_copy-region-with-info")
'(my-load-and-when "_duplicate-line"
  (define-key esc-map "Y" 'duplicate-line))
'(when (not run-w32)
  (my-load-and-when "_scroll-speedup")) ; in windows, I use kbdacc.
'(my-load-and-when "_my-memo"
  (global-set-key "\C-c\C-w" 'my-memo))
(my-load-and-when "_byte-compile-directory")
(my-load-and-when "_screen-read-hardcopy")


;; -*-no-byte-compile: t; -*-
