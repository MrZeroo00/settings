;;;; change-mode
;;;; http://groups.google.com/group/gnu.emacs.sources/browse_thread/thread/1d0959df36561739/a322fe45d233d964?#a322fe45d233d964
(my-autoload-and-when 'change-mode "change-mode")
(my-autoload-and-when 'change-mode-next-change "change-mode")
(my-autoload-and-when 'change-mode-previous-change "change-mode")
(my-autoload-and-when 'compare-with-file "change-mode")
(my-autoload-and-when 'change-mode-remove-change-face "change-mode")
(my-autoload-and-when (quote global-change-mode) "change-mode")
(my-eval-after-load "change-mode"
  (global-set-key '[C-right] 'change-mode-next-change)
  (global-set-key '[C-left] 'change-mode-previous-change)

  (setq change-mode-colours '("SkyBlue"
                              "LightPink1"
                              "CadetBlue2"
                              "plum1"
                              "dark orange"
                              "dark turquoise"))
  (setq change-delete-face-foreground "pink")
  (setq change-face-foreground "pink"))

(my-add-hook 'texinfo-mode-hook
          (lambda ()
            (my-add-hook 'local-write-file-hooks 'change-mode-rotate-colours)
            (change-mode)
            (local-set-key "\C-^" 'change-mode-next-change)
            ))
