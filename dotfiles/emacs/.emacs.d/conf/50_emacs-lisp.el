(setq auto-mode-alist
      (append '(("\\.el$" . emacs-lisp-mode))
              auto-mode-alist))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
