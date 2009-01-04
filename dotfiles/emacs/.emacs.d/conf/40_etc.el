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


;; functions
(load "_copy-region-with-info")
(load "_duplicate-line")
(define-key esc-map "Y" 'duplicate-line)
