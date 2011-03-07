(my-require-and-when 'cc-mode
  ;; anything
  (when (featurep 'anything)
    (add-to-list 'anything-mode-specific-alist
                 '(c-mode . (
                             ;;anything-c-source-yasnippet
                             anything-c-source-imenu
                             ;;anything-c-source-gtags-select
                             ))
                 '(c++-mode . (
                               ;;anything-c-source-yasnippet
                               anything-c-source-imenu
                               ;;anything-c-source-gtags-select
                               )))
	(add-to-list 'anything-kyr-commands-by-major-mode
				 '(c-mode
				   recompile
				   compile
				   gtags-find-file
				   gtags-find-rtag
				   ff-find-other-file
				   align
				   highlight-lines-matching-regexp
				   hs-hide-block
				   hs-show-block
				   hide-ifdef-mode
				   develock-mode
				   )
				 '(c++-mode
				   recompile
				   compile
				   gtags-find-file
				   gtags-find-rtag
				   ff-find-other-file
				   align
				   highlight-lines-matching-regexp
				   hs-hide-block
				   hs-show-block
				   hide-ifdef-mode
				   develock-mode
				   ))
    )

  ;; flymake
  (when (featurep 'flymake)
    (defun my-flymake-gcc-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
    (defun my-flymake-cc-conditional-init()
      (cond ((file-exists-p (concat flymake-base-dir "/" "Makefile")) 'flymake-simple-make-init)
            (t 'my-flymake-gcc-init)))
    (setcdr (assoc "\\.c\\'" flymake-allowed-file-name-masks)
            (list (my-flymake-cc-conditional-init)))
    )

  ;; ifdef
  ;;(setq hide-ifdef-define-alist
  ;;      '((list-name
  ;;         DEFINE1
  ;;         DEFINE2
  ;;         ))

  ;; summarye
  ;;(install-elisp "http://www.bookshelf.jp/elc/summarye.el")
  '(autoload 'se/make-summary-buffer "summarye" nil t)
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.[ch]\\'" . c-mode))


;;;; mode hook
(defun my-c-mode-hook ()
(when (memq major-mode '(c-mode c++-mode))
  ;; common setting
  (c-set-style "k&r")
  ;;(c-set-offset 'substatement-open 0)
  ;;(c-set-offset 'case-label '+)
  ;;(c-set-offset 'arglist-cont-nonempty '+)
  ;;(c-set-offset 'arglist-intro '+)
  ;;(c-set-offset 'topmost-intro-cont '+)
  ;;(c-set-offset 'arglist-close 0)
  (setq c-basic-offset tab-width)
  (setq show-trailing-whitespace t)
  ;;(c-toggle-auto-hungry-state 1)
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-map "{" 'insert-braces)
  (define-key c-mode-map "(" 'insert-parens)
  (define-key c-mode-map "\"" 'insert-double-quotation)
  (define-key c-mode-map "[" 'insert-brackets)
  (define-key c-mode-map "\C-c}" 'insert-braces-region)
  (define-key c-mode-map "\C-c)" 'insert-parens-region)
  (define-key c-mode-map "\C-c]" 'insert-brackets-region)
  (define-key c-mode-map "\C-c\"" 'insert-double-quotation-region)

  ;; auto-complete
  (when (featurep 'auto-complete)
    (add-to-list 'ac-sources 'ac-source-yasnippet)
    )

  ;; doxymacs
  (when (featurep 'doxymacs)
    (doxymacs-mode)
    (doxymacs-font-lock)
    )

  ;; gtags
  (when (featurep 'gtags)
    (gtags-mode t)
    ;;(gtags-make-complete-list)
    )

  ;; imenu
  (setq imenu-create-index-function 'imenu-default-create-index-function)

  ;; flymake
  (when (featurep 'flymake)
    (flymake-mode t)
    )

  ;; flyspell
  '(when (featurep 'flyspell)
    (flyspell-prog-mode)
    )

  ;; eldoc
  ;;(install-elisp-from-emacswiki "c-eldoc.el")
  ;; http://github.com/nflath/cache
  (my-require-and-when 'cache
    (my-require-and-when 'c-eldoc
      (setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I/usr/include -I./ -I../")
      (c-turn-on-eldoc-mode)
      (when run-darwin
        (setq c-eldoc-cpp-command "/usr/bin/cpp"))
      )
    )

  ;; hs-minor-mode
  (when (featurep 'hideshow)
    (hs-minor-mode 1)
    )

  ;; moccur
  (setq moccur-grep-default-mask "\\.\[HhCc\]$")

  ;; ff-find-other-file
  '(progn
     (setq cc-search-directories
           (append '("/opt/local/include") cc-search-directories))
     (define-key c-mode-map "\M-#" 'ff-find-other-file)
     (define-key c++-mode-map "\M-#" 'ff-find-other-file)
     )

  ;; cpp-complt
  ;;(install-elisp "http://www.bookshelf.jp/elc/cpp-complt.el")
  '(setq cpp-complt-standard-header-path '(
                                           "/usr/include"
                                           ))
  '(my-require-and-when 'cpp-complt
     (define-key c-mode-map [mouse-2] 'cpp-complt-include-mouse-select)
     (define-key c-mode-map "#" 'cpp-complt-instruction-completing)
     (define-key c-mode-map "\C-c#" 'cpp-complt-ifdef-region)
     (cpp-complt-init)
     )

  ;; cwarn
  '(my-require-and-when 'cwarn
     (turn-on-cwarn-mode)
     )

  ;; pbf-mode
  ;;(install-elisp "http://www.bookshelf.jp/elc/pbf-mode.el")
  '(my-require-and-when 'pbf-mode
     (pbf-setup)
     (pbf-mode t)
     (pbf-project HOME nil "My private." :directory (expand-file-name "~/"))
     )
  )
)
(add-hook 'c-mode-hook 'my-c-mode-hook)


;; -*-no-byte-compile: t; -*-
