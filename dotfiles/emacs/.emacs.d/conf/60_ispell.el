(setq ispell-grep-command "grep")
;(setq ispell-alternate-dictionary "~/etc/dictionary/words")

(eval-after-load "ispell"
  '(setq ispell-skip-region-alist (cons '("[^\000-\377]")
                                        ispell-skip-region-alist)))