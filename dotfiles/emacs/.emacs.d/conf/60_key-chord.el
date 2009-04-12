;(install-elisp-from-emacswiki "key-chord.el")
(require 'key-chord)

(setq key-chord-two-keys-delay 0.04)
(key-chord-mode t)
(key-chord-define-global "jk" 'view-mode)
(key-chord-define-global "db" 'describe-bindings)
(key-chord-define-global "df" 'describe-function)
(key-chord-define-global "dv" 'describe-variable)


;; space-chord
;(install-elisp-from-emacswiki "space-chord.el")
(require 'space-chord)
;(space-chord-define-global "f" 'find-file)
