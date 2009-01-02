(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)


;; pcomplete
;(add-hook 'shell-mode-hook 'pcomplete-shell-setup)


;; shell-toggle (switch shell buffer easily)
;(install-elisp "http://user.it.uu.se/~mic/shell-toggle.el")
(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing."
  t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd \" command." t)
