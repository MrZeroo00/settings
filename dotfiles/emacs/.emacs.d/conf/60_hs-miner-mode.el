(load-library "hideshow")

(setq hs-hide-comments nil)
(setq hs-isearch-open 't)

(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
