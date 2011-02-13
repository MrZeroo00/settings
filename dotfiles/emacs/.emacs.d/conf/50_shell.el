(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      ;;(executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
      ;;(executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)
'(global-set-key (kbd "C-c t") '(lambda ()
                                 (interactive)
                                 (term shell-file-name)))

(setq system-uses-terminfo nil)
(my-autoload-and-when 'ansi-color-for-comint-mode-on "ansi-color")
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(setq comint-scroll-show-maximum-output t)
;;;(setq explicit-shell-file-name "bash")
;;;(setq shell-file-name "bash")
;;;(setq shell-command-switch "-c")
;;;(setq exec-suffix-list '(".exe" ".sh" ".pl"))


;;;; anything
'(add-hook 'shell-mode-hook
          (lambda ()
            (make-variable-buffer-local 'anything-sources)
            (add-to-list 'anything-sources 'anything-c-source-complete-shell-history)))


;;;; shell-pop
;;;(install-elisp-from-emacswiki "shell-pop.el")
'(my-require-and-when 'shell-pop
  (shell-pop-set-internal-mode "ansi-term")
  (shell-pop-set-internal-mode-shell "/bin/zsh")
  (shell-pop-set-window-height 60) ; the number for the percentage of the selected window.
  )
;;;(global-set-key [f8] 'shell-pop)


;;;; tails-comint-history
;;;(install-elisp "http://www.bookshelf.jp/elc/tails-comint-history.el")
;;;(my-load-and-when "tails-comint-history")


;;;; shell-command
;;;(install-elisp "http://namazu.org/~tsuchiya/elisp/shell-command.el")
'(my-require-and-when 'shell-command ; replaced by anything
  (shell-command-completion-mode))


;;;; background
;;;(install-elisp "http://www.jgk.org/src/background.el")
'(my-autoload-and-when 'background "background"
                      (global-set-key "\M-!" 'background))


;;;; pcomplete
;;;(add-hook 'shell-mode-hook 'pcomplete-shell-setup)


;;;; shell-toggle (switch shell buffer easily)
;;;(install-elisp "http://user.it.uu.se/~mic/shell-toggle.el")
(my-autoload-and-when 'shell-toggle "shell-toggle")
(my-autoload-and-when 'shell-toggle-cd "shell-toggle")


;;;; shell-history
;;;(install-elisp-from-emacswiki "shell-history.el")
(my-require-and-when 'shell-history
  (define-key shell-mode-map "\M-m" 'shell-add-to-history))


(add-hook 'shell-mode-hook
          (lambda ()
            (setq outline-regexp "[^ ]*[>%#]")
;;;            (outline-minor-mode t)
            (turn-on-orgstruct)))


;; -*-no-byte-compile: t; -*-
