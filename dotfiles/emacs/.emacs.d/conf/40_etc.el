;; Outputz
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/outputz/outputz.el")
;(require 'outputz)
;(setq outputz-key "Your Private Key")      ;; 復活の呪文
;(setq outputz-uri "http://example.com/%s") ;; 適当なURL。%sにmajor-modeの名前が入るので、major-modeごとのURLで投稿できます。
;(global-outputz-mode t)
;
;(require 'outputz)
;(defun outputz-buffers ()
;  (dolist (buf (buffer-list))
;    (with-current-buffer buf
;    (outputz))))
;
;(run-with-idle-timer 3 t 'outputz-buffers)
;(remove-hook 'after-save-hook 'outputz)


;; pdicv-mode
;; http://pdicviewer.naochan.com/el/
;(require 'pdicv-search)
;(require 'pdicv-mode)
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


;; bm
;; http://www.nongnu.org/bm/
(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)


;; session
;; http://emacs-session.sourceforge.net/
(require 'session)
(setq session-initialize '(de-saveplace session keys menus places)
      session-globals-include '((kill-ring 50)
                                (session-file-alist 500 t)
                                (file-name-history 10000)))
(setq session-globals-max-string 100000000)
;(setq session-undo-check -1)
(add-hook 'after-init-hook 'session-initialize)


;; desktop
;(autoload 'desktop-save "desktop" nil t)
;(autoload 'desktop-clear "desktop" nil t)
;(autoload 'desktop-load-default "desktop" nil t)
;(autoload 'desktop-remove "desktop" nil t)


;; autoarg
;(require 'autoarg)


;; viper
;(require 'viper)


;; thing-opt
(require 'thingatpt)
;(install-elisp-from-emacswiki "thing-opt.el")
(require 'thing-opt)


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
;(require 'stripes)
;(set-face-background 'stripes-face "yellow")


;; edit-list
;(install-elisp "http://mwolson.org/static/dist/elisp/edit-list.el")
;(require 'edit-list)


;; install-elisp
;(install-elisp-from-emacswiki "install-elisp.el")
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")
;(install-elisp-from-emacswiki "oddmuse.el")
;(require 'oddmuse)
;;(setq url-proxy-services '(("http" . "your.proxy.host:portnumber"))
;(oddmuse-mode-initialize)


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
;(require 'enriched)


;; iimage
;(require 'iimage)


;; thumbs
(setq thumbs-thumbsdir
      (expand-file-name "~/.emacs-thumbs"))
(setq thumbs-temp-dir (expand-file-name "~/tmp"))
(setq image-file-name-extensions
      '("xcf" "png" "jpeg" "jpg" "gif" "tiff" "tif" "xbm" "xpm" "pbm" "pgm" "ppm"))


;; macros
(load "_window-line")
(load "_copy-region-with-info")
(load "_duplicate-line")
(define-key esc-map "Y" 'duplicate-line)
(load "_scroll-speedup")
;(load "_my-memo")
;(global-set-key "\C-c\C-w" 'my-memo)
