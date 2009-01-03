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


;; convert ftp url from "ftp://" to "/anonymous..."
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=ange-ftp%20tips
(defun convert-ftp-url-run-real-handler (operation args)
  (let ((inhibit-file-name-handlers
         (cons 'convert-ftp-url-to-efs-filename
               (and (eq inhibit-file-name-operation operation)
                    inhibit-file-name-handlers)))
        (inhibit-file-name-operation operation))
    (apply operation args)))

(defun convert-ftp-url-to-efs-filename (operation string &rest args)
  (string-match "^ftp://\\([^/@]+@\\)?\\([^/]+\\)" string)
  (convert-ftp-url-run-real-handler
   operation
   (cons (concat "/"
                 (if (match-beginning 1)
                     (substring string (match-beginning 1) (match-end 1))
                   "anonymous@")
                 (substring string (match-beginning 2) (match-end 2))
                 ":"
                 (substring string (match-end 2)))
         args)))

(defun convert-ftp-url-hook-function (operation &rest args)
  (let ((fn (get operation 'convert-ftp-url-to-efs-filename)))
    (if fn (apply fn operation args)
      (convert-ftp-url-run-real-handler operation args))))

(or (assoc "^ftp://[^/]+" file-name-handler-alist)
    (setq file-name-handler-alist
          (cons '("^ftp://[^/]+" . convert-ftp-url-hook-function)
                file-name-handler-alist)))

(put 'substitute-in-file-name
     'convert-ftp-url-to-efs-filename 'convert-ftp-url-to-efs-filename)
(put 'expand-file-name
     'convert-ftp-url-to-efs-filename 'convert-ftp-url-to-efs-filename)


;; convert url "ttp:// to "http://"
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=ttp%20navi2ch
;; http://www.nijino.com/ari/diary/200201.shtml#200201220
;(setq thing-at-point-url-regexp ;; for browse-url-at-mouse
;      (concat
;       "\\<\\(h?ttps?://\\|ftp://\\|gopher://\\|telnet://"
;       "\\|wais://\\|file:/\\|s?news:\\|mailto:\\)"
;       thing-at-point-url-path-regexp))
;(defadvice thing-at-point-url-at-point (after support-omitted-h activate)
;  (when (and ad-return-value (string-match "\\`ttps?://" ad-return-value))
;    (setq ad-return-value (concat "h" ad-return-value))))
;
;(setq ffap-url-regexp ;; for emacs-w3m
;      (concat
;       "\\`\\("
;       "news\\(post\\)?:\\|mailto:\\|file:"
;       "\\|"
;       "\\(ftp\\|h?ttps?\\|telnet\\|gopher\\|www\\|wais\\)://"
;       "\\)."))
;(defadvice ffap-url-at-point (after support-omitted-h activate)
;  (when (and ad-return-value (string-match "\\`ttps?://" ad-return-value))
;    (setq ad-return-value (concat "h" ad-return-value))))
;
;(setq mime-browse-url-regexp ;; for SEMI
;      (concat "\\(h?ttps?\\|ftp\\|file\\|gopher\\|news\\|telnet\\|wais\\|mailto\\):"
;              "\\(//[-a-zA-Z0-9_.]+:[0-9]*\\)?"
;              "[-a-zA-Z0-9_=?#$@~`%&*+|\\/.,]*[-a-zA-Z0-9_=#$@~`%&*+|\\/]"))
;(defadvice browse-url (before support-omitted-h (url &rest args) activate)
;  (when (and url (string-match "\\`ttps?://" url))
;    (setq url (concat "h" url))))
