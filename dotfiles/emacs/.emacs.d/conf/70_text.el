(setq paragraph-start '"^\\([ ¡¡¡¦¡û<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")

(add-hook 'text-mode-hook
          '(lambda ()
             ;(ruler-mode)
             (flyspell-mode)
             ;(refill-mode t)
             ))


;; text-adjust
;(install-elisp "http://taiyaki.org/elisp/text-adjust/src/text-adjust.el")
;(load "text-adjust")
;(setq adaptive-fill-regexp "[ \t]*")
;(setq adaptive-fill-mode t)
;(setq text-adjust-touten-from nil)
;(setq text-adjust-kuten-from nil)


;; word-count
;(install-elisp "http://taiyaki.org/elisp/word-count/src/word-count.el")
(autoload 'word-count-mode "word-count"
  "Minor mode to count words." t nil)
;(global-set-key "\M-+" 'word-count-mode)

;; macros
(load "text-adjust-space-before-save-if-needed")
