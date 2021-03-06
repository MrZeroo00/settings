;;;; proxy
(setq http-proxy-server "localhost")
(setq http-proxy-port 8080)


;;;; tramp
(my-require-and-when 'tramp
  (setq tramp-default-method "ssh")
  ;;(add-to-list 'tramp-default-proxies-alist
  ;;             '("pattern" nil "/ssh:user@host:"))
  )


;;;; emacs-wget
;;;; http://pop-club.hp.infoseek.co.jp/emacs/emacs-wget/
(my-autoload-and-when 'wget "wget")
(my-autoload-and-when 'wget-web-page "wget")
(my-eval-after-load "wget"
  (my-require-and-when 'w3m-wget)
  (setq wget-basic-options (cons "-equiet=off" wget-basic-options))
  (setq wget-basic-options (cons "-P." wget-basic-options))
  (setq wget-process-buffer nil))


;;;; browser
(if window-system
    (setq browse-url-browser-function 'browse-url-firefox)
  (setq browse-url-browser-function 'w3m-browse-url))


;;;; telnet
(setq telnet-program "telnet")
(defun my-telnet-mode-hook ()
  (set-buffer-process-coding-system 'euc-japan 'sjis-unix))
(add-hook 'telnet-mode-hook 'my-telnet-mode-hook)


;;;; ange-ftp
(setq ange-ftp-ftp-program-name "lftp")
(setq ange-ftp-try-passive-mode t)


;;;; riece
;;;; http://www.nongnu.org/riece/index.html.ja
'(my-autoload-and-when 'riece "riece")


;;;; twittering-mode
;;;; http://twmode.sourceforge.net/ja/
'(my-require-and-when 'twittering-mode
  (setq twittering-username "your twitter ID"))


;;;; twit
;;;(install-elisp-from-emacswiki "twit.el")
'(my-require-and-when 'twit
  (setq twit-user "〜"
        twit-pass "〜"))


;;;; MozRepl
;;;; http://hyperstruct.net/projects/mozlab
;;;; http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
'(add-to-list 'auto-mode-alist '("\\.js$" . java-mode))
'(my-autoload-and-when 'moz-minor-mode "moz")
'(defun java-custom-setup ()
  (moz-minor-mode 1))
'(add-hook 'java-mode-hook 'java-custom-setup)


;;;; mozadd
;;;; http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
'(my-require-and-when 'mozadd)


;;;; moz-plus
;;;(install-elisp "http://svn.coderepos.org/share/lang/elisp/moz-plus/moz-plus.el")
'(my-autoload-and-when 'run-mozilla "moz")
(defun my-inferior-moz-mode-hook ()
  (my-require-and-when 'moz-plus)
  (moz-plus 1)
  )
(add-hook 'inferior-moz-mode-hook 'my-inferior-moz-mode-hook)


;;;; google2
;;;(install-elisp "http://www.bookshelf.jp/elc/google2.el")
'(my-load-and-when "google2")


;;;; autoinfo
;;;(install-elisp-from-emacswiki "autoinfo.el")
'(my-require-and-when 'autoinfo)


;;;; macros
'(my-load-and-when "_convert-ftp-url-to-efs-filename") ; convert ftp url from "ftp://" to "/anonymous..."
'(my-load-and-when "_url-regexp") ; convert url "ttp:// to "http://"
