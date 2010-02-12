;; http://www.emacswiki.org/cgi-bin/wiki/NxhtmlMode
(my-load-and-when "nxhtml-mode/autostart.el")
;(my-autoload-and-when 'html-helper-mode "html-helper-mode")

;; association setting
;(add-to-list 'auto-mode-alist '("\\.html$" . html-helper-mode))

(add-hook 'html-mode-hook
          (lambda ()
            (setq outline-regexp "^.*<[Hh][1-6]\\>")
            (setq outline-heading-end-regexp "</[Hh][1-6]\\>")
            (setq outline-level
                  (function (lambda ()
                              (save-excursion
                                (looking-at outline-regexp)
                                (char-after (1- (match-end 0)))))))
;;;            (outline-minor-mode t)
            (turn-on-orgstruct)))
