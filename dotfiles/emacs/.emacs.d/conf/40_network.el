;; proxy
(setq http-proxy-server "localhost")
(setq http-proxy-port 8080)


;; tramp
(require 'tramp)


;; browser
;(setq browse-url-browser-function 'w3m-browse-firefox)
(setq browse-url-browser-function 'w3m-browse-url)


;; telnet
(setq telnet-program "telnet")
(add-hook 'telnet-mode-hook '_telnet-mode)
(defun _telnet-mode ()
  (set-buffer-process-coding-system 'euc-japan 'sjis-unix))


;; ange-ftp
(setq ange-ftp-ftp-program-name "lftp")
(setq ange-ftp-try-passive-mode t)


;; google2
;(install-elisp "http://www.bookshelf.jp/elc/google2.el")
;(load "google2")


;; autoinfo
;(install-elisp-from-emacswiki "autoinfo.el")
;(require 'autoinfo)


;; macros
(load "_convert-ftp-url-to-efs-filename") ; convert ftp url from "ftp://" to "/anonymous..."
;(load "_url-regexp") ; convert url "ttp:// to "http://"
