(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

(setq comint-scroll-show-maximum-output t)
;(setq explicit-shell-file-name "bash")
;(setq shell-file-name "bash")
;(setq shell-command-switch "-c")
;(setq exec-suffix-list '(".exe" ".sh" ".pl"))


;; anything
(add-hook 'shell-mode-hook
          (lambda ()
            (make-local-variable 'anything-sources)
            (add-to-list 'anything-sources 'anything-c-source-complete-shell-history)))


;; tails-comint-history
;(install-elisp "http://www.bookshelf.jp/elc/tails-comint-history.el")
;(load-library "tails-comint-history")


;; shell-ex
;; http://www.bookshelf.jp/elc/shell-ex.lzh
;(my-load-and-when "shell-ex")


;; shell-command
;(install-elisp "http://namazu.org/~tsuchiya/elisp/shell-command.el")
;(my-require-and-when 'shell-command) ; replaced by anything
;(shell-command-completion-mode)


;; background
;(install-elisp "http://www.jgk.org/src/background.el")
;(global-set-key "\M-!" 'background)
;(autoload 'background "background" nil t)


;; pcomplete
;(add-hook 'shell-mode-hook 'pcomplete-shell-setup)


;; shell-toggle (switch shell buffer easily)
;(install-elisp "http://user.it.uu.se/~mic/shell-toggle.el")
(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing."
  t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd \" command." t)


;; shell-history
;(install-elisp-from-emacswiki "shell-history.el")
(my-require-and-when 'shell-history)
(define-key shell-mode-map "\M-m" 'shell-add-to-history)


;; eshell
(autoload 'eshell "eshell" "Create an interactive Eshell buffer." t)
(custom-set-variables
 '(eshell-ask-to-save-history (quote always))
 '(eshell-history-size 1000)
 '(eshell-ls-dired-initial-args (quote ("-h")))
 '(eshell-ls-exclude-regexp "~\\'")
 '(eshell-ls-initial-args "-h")
 ;'(eshell-ls-use-in-dired t nil (em-ls))
 '(eshell-modules-list (quote (eshell-alias eshell-basic
                                            eshell-cmpl eshell-dirs eshell-glob
                                            eshell-hist eshell-ls eshell-pred
                                            eshell-prompt eshell-rebind
                                            eshell-script eshell-smart
                                            eshell-term eshell-unix eshell-xtra)))
 '(eshell-prefer-to-shell t nil (eshell))
 '(eshell-stringify-t nil)
 '(eshell-term-name "ansi")
 '(eshell-visual-commands (quote ("vi" "top" "screen" "less" "lynx"
                                  "ssh" "rlogin" "telnet"))))


(add-hook 'shell-mode-hook
          (lambda ()
            (setq outline-regexp "[^ ]*[>%#]")
            ;(outline-minor-mode t)
            (turn-on-orgstruct)))
