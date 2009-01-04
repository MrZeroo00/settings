(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

; association setting
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(setq ruby-deep-indent-paren-style nil)

;; flymake
(setq flymake-allowed-file-name-masks
      (cons '(".+\\.rb$" flymake-ruby-init)
            flymake-allowed-file-name-masks))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             (flymake-mode t)))


;; refe
;(install-elisp "http://ns103.net/~arai/ruby/refe.el")
;(require 'refe)
;; http://d.hatena.ne.jp/rubikitch/20071228/rubyrefm
;(install-elisp "http://www.rubyist.net/~rubikitch/archive/refe2.e")
(load "_refe2")


;; autotest
;(install-elisp-from-emacswiki "autotest.el")
(require 'autotest)

;; macros
(load "_ruby-insert-magic-comment-if-needed")
(add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)
