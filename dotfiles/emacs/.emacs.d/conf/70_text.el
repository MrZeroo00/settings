; mode hook
(add-hook 'text-mode-hook
          (lambda ()
            ;(ruler-mode)
            (flyspell-mode)
            ;(refill-mode t)
            ))

; common setting
(setq paragraph-start '"^\\([ ¡¡¡¦¡û<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")


;; word-count
;(install-elisp "http://taiyaki.org/elisp/word-count/src/word-count.el")
(autoload 'word-count-mode "word-count"
  "Minor mode to count words." t nil)
;(global-set-key "\M-+" 'word-count-mode)


;; text-adjust
;(install-elisp "http://taiyaki.org/elisp/text-adjust/src/text-adjust.el")
(add-hook 'text-mode-hook
          (lambda ()
            (load "text-adjust")
            (setq adaptive-fill-regexp "[ \t]*")
            (setq adaptive-fill-mode t)
            (setq text-adjust-touten-from nil)
            (setq text-adjust-kuten-from nil)))

;(defun text-adjust-space-before-save-if-needed ()
;  (when (memq major-mode
;              '(org-mode text-mode mew-draft-mode))
;    (text-adjust-space-buffer)))
;(defalias 'spacer 'text-adjust-space-buffer)
;(add-hook 'before-save-hook 'text-adjust-space-before-save-if-needed)


;; macros
;(add-hook 'text-mode-hook
;          (lambda ()
;            (load "text-adjust-space-before-save-if-needed")))
