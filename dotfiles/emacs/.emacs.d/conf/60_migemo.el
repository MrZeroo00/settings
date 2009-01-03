(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

; dictionary
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)

; cache
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1024)

(require 'migemo)
(migemo-init)
