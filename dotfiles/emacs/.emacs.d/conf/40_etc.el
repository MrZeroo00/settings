;; Outputz
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/outputz/outputz.el")
;(require 'outputz)
;(setq outputz-key "Your Private Key")      ;; ����μ�ʸ
;(setq outputz-uri "http://example.com/%s") ;; Ŭ����URL��%s��major-mode��̾��������Τǡ�major-mode���Ȥ�URL����ƤǤ��ޤ���
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


;; bm
;; http://www.nongnu.org/bm/
(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)


;; minibuf-isearch
(require 'minibuf-isearch)


;; session
;; http://emacs-session.sourceforge.net/
(require 'session)
(add-hook 'after-init-hook 'session-initialize)


;; autoarg
;(require 'autoarg)


;; viper
;(require 'viper)


;; thing-opt
(require 'thingatpt)
;(install-elisp-from-emacswiki "thing-opt.el")
(require 'thing-opt)


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
    (autoload 'keisen-mode "keisen-mouse" "MULE �Ƿ����⡼�� + �ޥ���" t)
  (autoload 'keisen-mode "keisen-mule" "MULE �Ƿ����⡼��" t))


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
