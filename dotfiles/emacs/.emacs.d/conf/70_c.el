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


;; flymake
(defun my-flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
(setcdr (assoc "\\.c\\'" flymake-allowed-file-name-masks)
        '(my-flymake-cc-init))

;(add-hook 'c-mode-common-hook
;          '(lambda ()
;             (flymake-mode)))


;; eldoc
;(install-elisp-from-emacswiki "c-eldoc.el")
(setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../ ")
(load "c-eldoc")
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

(when run-darwin
  (setq c-eldoc-cpp-command "/usr/bin/cpp"))


;; ff-find-other-file
;(setq cc-search-directories
;      (append '("/opt/local/include")
;              cc-search-directories))
(add-hook 'c-mode-common-hook (lambda ()
            (define-key c-mode-map "\M-#" 'ff-find-other-file)
            (define-key c++-mode-map "\M-#" 'ff-find-other-file)
            ))


;; moccur
(add-hook
 'c-mode-common-hook
 '(lambda ()
    (setq moccur-grep-default-mask "\\.\[HhCc\]$")))


;; summarye
;(install-elisp "http://www.bookshelf.jp/elc/summarye.el")
;(autoload 'se/make-summary-buffer "summarye" nil t)


;; cpp-complt
;;(install-elisp "http://www.bookshelf.jp/elc/cpp-complt.el")
;(add-hook 'c-mode-common-hook
;          (function (lambda ()
;                      (require 'cpp-complt)
;                      (define-key c-mode-map [mouse-2]
;                        'cpp-complt-include-mouse-select)
;                      (define-key c-mode-map "#"
;                        'cpp-complt-instruction-completing)
;                      (define-key c-mode-map "\C-c#"
;                        'cpp-complt-ifdef-region)
;                      (cpp-complt-init))))
;
;(setq cpp-complt-standard-header-path
;      '(
;        "/usr/include"
;        ))


;; pbf-mode
;(install-elisp "http://www.bookshelf.jp/elc/pbf-mode.el")
;(require 'pbf-mode)
;(pbf-setup)
;(pbf-mode t)
;(pbf-project HOME nil
;             "My private."
;             :directory (expand-file-name "~/"))


;; cwarn
(require 'cwarn)
(add-hook 'c-mode-hook 'turn-on-cwarn-mode)
