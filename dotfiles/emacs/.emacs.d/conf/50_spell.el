(setq-default ispell-program-name "aspell")

;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=ispell
(setq ispell-grep-command "grep")
;(setq ispell-alternate-dictionary "~/etc/dictionary/words")

(eval-after-load "ispell"
  '(setq ispell-skip-region-alist (cons '("[^\000-\377]")
                                        ispell-skip-region-alist)))


;; flyspell
(setq flyspell-auto-correct-binding [(control ?\')]) ; avoid key binding conflict with anything
(my-autoload-and-when 'flyspell-mode "flyspell")
(my-autoload-and-when 'flyspell-delay-command "flyspell")
(my-autoload-and-when 'tex-mode-flyspell-verify "flyspell")
(my-eval-after-load "flyspell"
  (setq flyspell-issue-message-flag nil)
  (setq ispell-parser 'tex))
