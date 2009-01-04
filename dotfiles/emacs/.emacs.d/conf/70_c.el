(require 'cc-mode)

; association setting
(add-to-list 'auto-mode-alist '("\\.[ch]\\'" . c-mode))

; style setting
(add-hook 'c-mode-common-hook '(lambda ()
                                 ;(c-set-style "GNU")
                                 (c-set-offset 'substatement-open 0)
                                 (c-set-offset 'case-label '+)
                                 (c-set-offset 'arglist-cont-nonempty '+)
                                 (c-set-offset 'arglist-intro '+)
                                 (c-set-offset 'topmost-intro-cont '+)
                                 (c-set-offset 'arglist-close 0)
                                 (setq tab-width 4)
                                 (setq c-basic-offset tab-width)
                                 (setq indent-tabs-mode nil)
                                 ))


;; anything
(add-hook 'c-mode-common-hook
          (lambda ()
            (make-local-variable 'anything-sources)
            (add-to-list 'anything-sources 'anything-c-source-gtags-select t)
            (add-to-list 'anything-sources 'anything-c-source-yasnippet t)
            (add-to-list 'anything-sources 'anything-c-source-imenu t)
            ))


;; eldoc
;(install-elisp-from-emacswiki "c-eldoc.el")
(setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../ ")
(load "c-eldoc")
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)


;; ff-find-other-file
;(setq cc-search-directories
;      (append '("/opt/local/include")
;              cc-search-directories))
(add-hook 'c-mode-common-hook (lambda ()
            (define-key c-mode-map "\M-#" 'ff-find-other-file)
            (define-key c++-mode-map "\M-#" 'ff-find-other-file)
            ))


;; cwarn
(require 'cwarn)
(add-hook 'c-mode-hook 'turn-on-cwarn-mode)
