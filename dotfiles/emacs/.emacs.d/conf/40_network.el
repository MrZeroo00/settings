;; proxy
(setq http-proxy-server "localhost")
(setq http-proxy-port 8080)


;; tramp
(require 'tramp nil t)


;; emacs-wget
;; http://pop-club.hp.infoseek.co.jp/emacs/emacs-wget/
(autoload 'wget "wget" "wget interface for Emacs." t)
(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)
(eval-after-load
    "wget"
  '(progn
     (load "w3m-wget")
     (setq wget-basic-options (cons "-equiet=off" wget-basic-options))
     (setq wget-basic-options (cons "-P." wget-basic-options))
     (setq wget-process-buffer nil)))


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


;; riece
;; http://www.nongnu.org/riece/index.html.ja
(autoload 'riece "riece" "Start Riece" t)


;; twit
;(install-elisp-from-emacswiki "twit.el")
;(require 'twit nil t)
;(setq twit-user "¡Á"
;      twit-pass "¡Á")


;; MozRepl
;; http://hyperstruct.net/projects/mozlab
(add-to-list 'auto-mode-alist '("\\.js$" . java-mode))
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(add-hook 'java-mode-hook 'java-custom-setup)
(defun java-custom-setup ()
  (moz-minor-mode 1))


;; moz-plus
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/moz-plus/moz-plus.el")
(autoload 'run-mozilla "moz" "run inferior moz" t)
(add-hook 'inferior-moz-mode-hook (lambda ()
                                    (require 'moz-plus nil t)
                                    (moz-plus 1)
                                    ))


;; google2
;(install-elisp "http://www.bookshelf.jp/elc/google2.el")
;(load "google2")


;; autoinfo
;(install-elisp-from-emacswiki "autoinfo.el")
;(require 'autoinfo nil t)


;; macros
(load "_convert-ftp-url-to-efs-filename") ; convert ftp url from "ftp://" to "/anonymous..."
;(load "_url-regexp") ; convert url "ttp:// to "http://"
