;; hatenahelper-mode
;; http://d.hatena.ne.jp/amt/20060115/HatenaHelperMode
(require 'hatenahelper-mode)
(global-set-key "\C-xH" 'hatenahelper-mode)
;(add-hook 'hatena-mode-hook 'hatenahelper-mode)  ; 本当はこう
(add-hook 'hatena-mode-hook
          '(lambda ()
             ; other hooks must be wrote here!
             (hatenahelper-mode 1)))
