;;;; pdicv-mode
;;;; http://pdicviewer.naochan.com/el/
;;;(my-require-and-when 'pdicv-search)
;;;(my-require-and-when 'pdicv-mode)
'(my-autoload-and-when 'pdicv "pdicviewer"
     (setq pdicv-dictionary-list
           '((eijiro "~/etc/dictionary/EIJIRO95.DIC" (nil nil sjis sjis))
             (waeijiro "~/etc/dictionary/WAEIJI52.DIC" (sjis nil sjis sjis) t)
;;;                                        (ej (eijiro waeijiro))
             ))
;;;     (global-set-key "\C-c\C-e" 'pdicv-eijiro-search-interactive)
;;;     (global-set-key "\C-c\C-r" 'pdicv-eijiro-search-region)
;;;     (global-set-key "\C-c\C-d" 'pdicv-set-current-dictionary)
;;;     (global-set-key "\C-c\C-i" 'pdicv-search-interactive)
;;;     (global-set-key "\C-c\C-j" 'pdicv-search-region)
;;;     (global-set-key "\C-c\C-p" 'pdicv-mode)
     )


;;;; cheat
;;;(install-elisp "http://sami.samhuri.net/assets/2007/8/10/cheat.el")
;;;(my-require-and-when 'cheat)


;;;; eldoc
(my-autoload-and-when 'turn-on-eldoc-mode "eldoc"
                      (setq eldoc-idle-delay 0.3)
                      (setq eldoc-echo-area-use-multiline-p t))


;;;; eldoc-extension
;;;(install-elisp-from-emacswiki "eldoc-extension.el")
(my-require-and-when 'eldoc-extension
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))


;;;; info-look
(my-require-and-when 'info-look)


;;;; gtk-look
;;;(install-elisp "http://www.geocities.com/user42_kevin/gtk-look/gtk-look.el.txt")
'(my-autoload-and-when 'gtk-lookup-symbol "gtk-look"
  	      (when run-linux
  		(setq gtk-lookup-devhelp-indices
  		      '("/usr/share/doc/lib*-doc/*.devhelp*"
  			"/usr/share/doc/lib*-doc/*/*.devhelp*"
  			"/usr/share/doc/lib*-doc/*/*/*.devhelp*")))
  	      (when run-darwin
  		(setq gtk-lookup-devhelp-indices
  		      '("/opt/local/share/gtk-doc/html/*/*.devhelp"))))
