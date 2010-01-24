;; Outputz
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/outputz/outputz.el")
;(when (require 'outputz nil t)
;  (setq outputz-key "Your Private Key") ;; 復活の呪文
;  (setq outputz-uri "http://example.com/%s") ;; 適当なURL。%sにmajor-modeの名前が入るので、major-modeごとのURLで投稿できます。
;  (global-outputz-mode t)
;
;  (defun outputz-buffers ()
;    (dolist (buf (buffer-list))
;      (with-current-buffer buf
;        (outputz))))
;
;  (run-with-idle-timer 3 t 'outputz-buffers)
;  (remove-hook 'after-save-hook 'outputz))


;; typing-outputz
;; http://github.com/hayamiz/typing-outputz/tree/master
(when (require 'typing-outputz nil t)
  (global-typing-outputz-mode t)
  (setq typing-outputz-key "bWAROb-quUbf"))


;; pdicv-mode
;; http://pdicviewer.naochan.com/el/
;(require 'pdicv-search nil t)
;(require 'pdicv-mode nil t)
(autoload 'pdicv "pdicviewer" "PDIC辞書検索" t)
(eval-after-load 'pdic
  '(progn
     (setq pdicv-dictionary-list
           '((eijiro "~/etc/dictionary/EIJIRO95.DIC" (nil nil sjis sjis))
             (waeijiro "~/etc/dictionary/WAEIJI52.DIC" (sjis nil sjis sjis) t)
                                        ;(ej (eijiro waeijiro))
        ))))
;(global-set-key "\C-c\C-e" 'pdicv-eijiro-search-interactive)
;(global-set-key "\C-c\C-r" 'pdicv-eijiro-search-region)
;(global-set-key "\C-c\C-d" 'pdicv-set-current-dictionary)
;(global-set-key "\C-c\C-i" 'pdicv-search-interactive)
;(global-set-key "\C-c\C-j" 'pdicv-search-region)
;(global-set-key "\C-c\C-p" 'pdicv-mode)


;; cheat
;(install-elisp "http://sami.samhuri.net/assets/2007/8/10/cheat.el")
;(when (require 'cheat nil t))


;; bm
;; http://www.nongnu.org/bm/
(when (require 'bm nil t)
  (global-set-key (kbd "<C-f2>") 'bm-toggle)
  (global-set-key (kbd "<f2>")   'bm-next)
  (global-set-key (kbd "<S-f2>") 'bm-previous))


;; session
;; http://emacs-session.sourceforge.net/
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  (setq session-globals-max-string 100000000)
  (setq session-undo-check -1)
  (add-hook 'after-init-hook 'session-initialize))


;; desktop
;(autoload 'desktop-save "desktop" nil t)
;(autoload 'desktop-clear "desktop" nil t)
;(autoload 'desktop-load-default "desktop" nil t)
;(autoload 'desktop-remove "desktop" nil t)


;; remember
(when (require 'remember nil t))


;; autoarg
;(when (require 'autoarg nil t))


;; viper
;(when (require 'viper nil t))


;; thing-opt
(when (require 'thingatpt nil t))
;(install-elisp-from-emacswiki "thing-opt.el")
(when (require 'thing-opt nil t))


;; sense-region
;(install-elisp "http://taiyaki.org/elisp/sense-region/src/sense-region.el")
(autoload 'sense-region-on "sense-region"
  "System to toggle region and rectangle." t nil)


;; alpaca
;(install-elisp "http://www.mew.org/~kazu/proj/cipher/alpaca.el")
(autoload 'alpaca-after-find-file "alpaca" nil t)
(add-hook 'find-file-hooks 'alpaca-after-find-file)
(setq alpaca-cache-passphrase t)


;; clwiki
;; http://pop-club.hp.infoseek.co.jp/emacs/changelog.html
;(install-elisp "http://www.rubyist.net/~rubikitch/computer/clwiki/clwiki.el")
;(autoload 'clwiki "clwiki" "ChangeLog wiki-modoki." t)
;(define-key ctl-x-map "M" 'clwiki)
;(autoload 'clgrep "clgrep" "ChangeLog grep." t)
;(autoload 'clgrep-item "clgrep" "ChangeLog grep." t)
;(autoload 'clgrep-item-header "clgrep" "ChangeLog grep for item header" t)
;(autoload 'clgrep-item-tag "clgrep" "ChangeLog grep for tag" t)
;(autoload 'clgrep-item-notag "clgrep" "ChangeLog grep for item except for tag" t)
;(autoload 'clgrep-item-nourl "clgrep" "ChangeLog grep item except for url" t)
;(autoload 'clgrep-entry "clgrep" "ChangeLog grep for entry" t)
;(autoload 'clgrep-entry-header "clgrep" "ChangeLog grep for entry header" t)
;(autoload 'clgrep-entry-no-entry-header "clgrep" "ChangeLog grep for entry except entry header" t)
;(autoload 'clgrep-entry-tag "clgrep" "ChangeLog grep for tag" t)
;(autoload 'clgrep-entry-notag "clgrep" "ChangeLog grep for tag" t)
;(autoload 'clgrep-entry-nourl "clgrep" "ChangeLog grep entry except for url" t)
;(add-hook 'clmemo-mode-hook
;          '(lambda () (define-key clmemo-mode-map "\C-c\C-g" 'clgrep)))


;; postit
;(install-elisp "http://www.bookshelf.jp/elc/postit.el")
;(autoload 'postit "postit" nil t)
;(setq postit-colorize 'dark)
;(setq postit-compress-commands nil)


;; stripes
;(install-elisp-from-emacswiki "stripes.el")
;(when (require 'stripes nil t)
;  (set-face-background 'stripes-face "yellow"))


;; edit-list
;(install-elisp "http://mwolson.org/static/dist/elisp/edit-list.el")
;(when (require 'edit-list nil t))


;; color-selection
;(install-elisp "http://www.bookshelf.jp/elc/color-selection.el")
(autoload 'list-hexadecimal-colors-display "color-selection"
  "Display hexadecimal color codes, and show what they look like." t)


;; keisen-mule
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=keisen
(if window-system
    (autoload 'keisen-mode "keisen-mouse" "MULE 版罫線モード + マウス" t)
  (autoload 'keisen-mode "keisen-mule" "MULE 版罫線モード" t))


;; enriched-mode
;(when (require 'enriched nil t))


;; iimage
;(when (require 'iimage nil t))


;; thumbs
(setq thumbs-thumbsdir
      (expand-file-name "~/.emacs-thumbs"))
(setq thumbs-temp-dir (expand-file-name "~/tmp"))
(setq image-file-name-extensions
      '("xcf" "png" "jpeg" "jpg" "gif" "tiff" "tif" "xbm" "xpm" "pbm" "pgm" "ppm"))


;; screenshot
;(install-elisp-from-emacswiki "screenshot.el")
;(when (require 'screenshot nil t)
;  (setq screenshot-schemes
;        '(
;          ;; To local image directory
;          ("local"
;           :dir "~/images/")
;          ;; To current directory
;          ("current-directory"
;           :dir default-directory)
;          ;; To remote ssh host
;          ("remote-ssh"
;           :dir "/tmp/"
;           :ssh-dir "www.example.org:public_html/archive/"
;           :url "http://www.example.org/archive/")
;          ;; To EmacsWiki (need yaoddmuse.el)
;          ("EmacsWiki"
;           :dir "~/.yaoddmuse/EmacsWiki/"
;           :yaoddmuse "EmacsWiki")
;          ;; To local web server
;          ("local-server"
;           :dir "~/public_html/"
;           :url "http://127.0.0.1/")))
;  (setq screenshot-default-scheme "local"))


;; japanese-holidays
;(when (require 'calendar nil t)
;  (setq number-of-diary-entries 31)
;  (define-key calendar-mode-map "f" 'calendar-forward-day)
;  (define-key calendar-mode-map "n" 'calendar-forward-day)
;  (define-key calendar-mode-map "b" 'calendar-backward-day)
;  (setq mark-holidays-in-calendar t))
;(install-elisp "http://www.meadowy.org/meadow/netinstall/export/799/branches/3.00/pkginfo/japanese-holidays/japanese-holidays.el")
;(when (require 'japanese-holidays nil t)
;  (setq calendar-holidays
;        (append japanese-holidays local-holidays other-holidays))
;  (setq calendar-weekend-marker 'diary)
;  (add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
;  (add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend))


;; midnight
;(when (require 'midnight nil t))


;; macros
(load "_window-line")
(load "_copy-region-with-info")
(load "_duplicate-line")
(define-key esc-map "Y" 'duplicate-line)
(load "_scroll-speedup")
;(load "_my-memo")
;(global-set-key "\C-c\C-w" 'my-memo)
;(load "_byte-compile-directory")
(load "_screen-read-hardcopy")
