;; js2-mode
;; http://code.google.com/p/js2-mode/
(autoload 'js2-mode "js2" nil t)

; association setting
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
