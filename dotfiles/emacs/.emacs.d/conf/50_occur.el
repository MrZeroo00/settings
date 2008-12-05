;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=exampleelisp%20color-moccur
(setq moccur-split-word t)
(setq moccur-use-migemo t)
(setq color-moccur-default-ime-status nil)
(autoload 'moccur-grep "color-moccur" nil t)
(autoload 'moccur-grep-find "color-moccur" nil t)
(autoload 'isearch-moccur "color-moccur" nil t)
(autoload 'isearch-moccur-all "color-moccur" nil t)
(autoload 'occur-by-moccur "color-moccur" nil t)
(autoload 'moccur "color-moccur" nil t)
(autoload 'dmoccur "color-moccur" nil t)
(autoload 'dired-do-moccur "color-moccur" nil t)
(autoload 'Buffer-menu-moccur "color-moccur" nil t)
(autoload 'moccur-narrow-down "color-moccur" nil t)
(autoload 'grep-buffers "color-moccur" nil t)
(autoload 'search-buffers "color-moccur" nil t)
(autoload 'gresreg "gresreg" nil t)
(eval-after-load "color-moccur"
  '(require 'moccur-edit))
(eval-after-load "ibuffer"
  '(require 'color-moccur))
(setq *moccur-buffer-name-exclusion-list*
      '(".+TAGS.+" "*Completions*" "*Messages*"
        "newsrc.eld"
        " *migemo*" ".bbdb"))

(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key "O" 'dired-do-moccur)))
(define-key Buffer-menu-mode-map "O" 'Buffer-menu-moccur)
;;(global-set-key "\M-f" 'grep-buffers)
(global-set-key "\M-o" 'occur-by-moccur)
(global-set-key "\C-c\C-x\C-o" 'moccur)
;;(global-set-key "\C-c\C-o" 'search-buffers)
