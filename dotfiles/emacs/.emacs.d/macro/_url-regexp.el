;; convert url "ttp:// to "http://"
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=ttp%20navi2ch
;; ari's Diary http://www.nijino.com/ari/diary/200201.shtml#200201220 より
;; for browse-url-at-mouse
(setq thing-at-point-url-regexp
      (concat
       "\\<\\(h?ttps?://\\|ftp://\\|gopher://\\|telnet://"
       "\\|wais://\\|file:/\\|s?news:\\|mailto:\\)"
       thing-at-point-url-path-regexp))
(defadvice thing-at-point-url-at-point (after support-omitted-h activate)
  (when (and ad-return-value (string-match "\\`ttps?://" ad-return-value))
    (setq ad-return-value (concat "h" ad-return-value))))

;; for emacs-w3m
(setq ffap-url-regexp
      (concat
       "\\`\\("
       "news\\(post\\)?:\\|mailto:\\|file:"
       "\\|"
       "\\(ftp\\|h?ttps?\\|telnet\\|gopher\\|www\\|wais\\)://"
       "\\)."))
(defadvice ffap-url-at-point (after support-omitted-h activate)
  (when (and ad-return-value (string-match "\\`ttps?://" ad-return-value))
    (setq ad-return-value (concat "h" ad-return-value))))

;; for SEMI
(setq mime-browse-url-regexp
      (concat "\\(h?ttps?\\|ftp\\|file\\|gopher\\|news\\|telnet\\|wais\\|mailto\\):"
              "\\(//[-a-zA-Z0-9_.]+:[0-9]*\\)?"
              "[-a-zA-Z0-9_=?#$@~`%&*+|\\/.,]*[-a-zA-Z0-9_=#$@~`%&*+|\\/]"))
(defadvice browse-url (before support-omitted-h (url &rest args) activate)
  (when (and url (string-match "\\`ttps?://" url))
    (setq url (concat "h" url))))
