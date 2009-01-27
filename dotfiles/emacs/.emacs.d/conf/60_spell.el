(setq-default ispell-program-name "aspell")

;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=ispell
(setq ispell-grep-command "grep")
;(setq ispell-alternate-dictionary "~/etc/dictionary/words")

(eval-after-load "ispell"
  '(setq ispell-skip-region-alist (cons '("[^\000-\377]")
                                        ispell-skip-region-alist)))


;; flyspell
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
(setq flyspell-issue-message-flag nil)
(setq flyspell-auto-correct-binding [(control ?\')])
