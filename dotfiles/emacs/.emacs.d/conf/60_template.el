(require 'autoinsert)
(setq auto-insert-directory "~/etc/emacs/template/")
(setq auto-insert-alist
      (nconc '( ("\\.c$" . "template.c")
                ("\\.f$" . "template.f")
                ) auto-insert-alist))

(add-hook 'find-file-not-found-hooks 'auto-insert)