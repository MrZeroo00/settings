;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=exampleelisp%20color-moccur
;;;(install-elisp-from-emacswiki "moccur-edit.el")
;;;(install-elisp-from-emacswiki "color-moccur.el")
(setq moccur-split-word t)
(my-require-and-when 'migemo
  (setq moccur-use-migemo t))
(setq color-moccur-default-ime-status nil)
(my-autoload-and-when 'moccur-grep "color-moccur")
(my-autoload-and-when 'moccur-grep-find "color-moccur")
(my-autoload-and-when 'isearch-moccur "color-moccur")
(my-autoload-and-when 'isearch-moccur-all "color-moccur")
(my-autoload-and-when 'occur-by-moccur "color-moccur")
(my-autoload-and-when 'moccur "color-moccur")
(my-autoload-and-when 'dmoccur "color-moccur")
(my-autoload-and-when 'dired-do-moccur "color-moccur")
(my-autoload-and-when 'Buffer-menu-moccur "color-moccur")
(my-autoload-and-when 'moccur-narrow-down "color-moccur")
(my-autoload-and-when 'grep-buffers "color-moccur")
(my-autoload-and-when 'search-buffers "color-moccur")
(my-autoload-and-when 'gresreg "gresreg")
(my-eval-after-load "color-moccur"
  (my-require-and-when 'moccur-edit)
  (setq *moccur-buffer-name-exclusion-list*
        '(".+TAGS.+" "*Completions*" "*Messages*"
          "newsrc.eld"
          " *migemo*" ".bbdb"))
  (define-key Buffer-menu-mode-map "O" 'Buffer-menu-moccur)
;;;  (global-set-key "\M-f" 'grep-buffers)
  (global-set-key "\M-o" 'occur-by-moccur)
  (global-set-key "\C-c\C-x\C-o" 'moccur)
;;;  (global-set-key "\C-c\C-o" 'search-buffers)

  (setq *moccur-buffer-name-exclusion-list*
        '("\.svn" "*Completions*" "*Messages*"))

  (setq moccur-grep-default-word-near-point t)
;;;  (setq moccur-grep-following-mode-toggle t)
  )

(my-eval-after-load "ibuffer"
  (my-require-and-when 'color-moccur))

(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key "O" 'dired-do-moccur)))

(defadvice moccur-edit-change-file
  (after save-after-moccur-edit-buffer activate)
  (save-buffer))


;;;; dmoccur
(setq dmoccur-use-list t)
(setq dmoccur-list
      '(
        ("dir" default-directory (".*") dir)
        ))
(my-eval-after-load "dmoccur"
  (add-to-list 'dmoccur-exclusion-mask '("\\~$" "\\.svn\\/\*")))


;;;; advice
(defadvice moccur-view-file (after moccur-view-file-which-func-update)
  "Call which-func-update after moving"
  (save-selected-window
    (select-window (get-buffer-window moccur-buffer-name))
    (which-func-update)))
(defadvice moccur-scroll-file (after moccur-scroll-file-which-func-update)
  "Call which-func-update after scrolling"
  (save-selected-window
    (select-window (get-buffer-window moccur-buffer-name))
    (which-func-update)))


;;;; macros
;;;(my-load-and-when "_flush-keep-line")
