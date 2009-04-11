;; http://www.thaiopensource.com/nxml-mode/
(load "rng-auto.el")                    ; autoload

; association setting
(add-to-list 'auto-mode-alist '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode))

; mode hook
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq nxml-slash-auto-complete-flag t)
            (setq nxml-child-indent 2)
            (setq auto-fill-mode -1)
            (setq indent-tabs-mode t)
            (setq tab-width 2)))
