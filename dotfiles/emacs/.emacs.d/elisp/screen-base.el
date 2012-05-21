(eval-when-compile (require 'cl))
(require 'assoc)
(provide 'screen-base)

;;;; This module provides generic apis of screen system ( windows.el or elscreen.el ).

(defun screen-base-get-parameter (key-symbol &optional screen) (error "need elscreen or windows"))
(defun screen-base-set-parameter (key-symbol value &optional screen) (error "need elscreen or windows"))
;; (defun screen-base-register-parameters-to-save (&rest key-symbols) (error "need windows"))

(when (featurep 'elscreen)
  ;; elscreen ;; XXX only for without frame
  (defun screen-base-get-parameter (key-symbol &optional screen)
    "Return vc top-level of SCREEN, a directory as string. If SCREEN is nil current-screen is used."
    (let ((screen-property (elscreen-get-screen-property (or screen (elscreen-get-current-screen)))))
      (aget screen-property key-symbol t)))

  (defun screen-base-set-parameter (key-symbol value &optional screen)
    "Set git-toplevel of SCREEN."
    (let ((screen-property (elscreen-get-screen-property (or screen (elscreen-get-current-screen)))))
      (aput 'screen-property key-symbol value)
      (elscreen-set-screen-property screen screen-property))))

(when (featurep 'windows)
  ;;;; windows
  (if win:use-frame
      (progn
        (defun screen-base-get-parameter (key-symbol &optional frame)
          (aget (frame-parameters frame) key-symbol t))
        (defun screen-base-set-parameter (key-symbol value &optional frame)
          (set-frame-parameter (or frame (selected-frame)) key-symbol value))
        (defun screen-base-register-parameters-to-save (&rest key-symbols)
          (mapc (lambda (key-symbol)
                  (add-to-list 'win:frame-parameters-to-save-private key-symbol))
                key-symbols)))

    (defvar screen-base-screens-parameters (make-vector win:max-configs nil))
    (add-to-list 'revive:save-variables-global-private 'screen-base-screens-parameters)
    ;; (defvar screen-base-screen-parameters-to-save nil)
    (defun screen-base-get-parameter (key-symbol &optional screen)
      (aget (aref screen-base-screens-parameters (or screen win:current-config)) key-symbol t))
    (defun screen-base-set-parameter (key-symbol value &optional screen)
      (let ((screen-base-parameters (aref screen-base-screens-parameters (or screen win:current-config))))
        (aput 'screen-base-parameters key-symbol value)
        (aset screen-base-screens-parameters (or screen win:current-config) screen-base-parameters)))
    ;; (defun screen-base-register-parameters-to-save (&rest key-symbols)
    ;;   (mapc (lambda (key-symbol)
    ;;           (add-to-list 'screen-base-screen-parameters-to-save key-symbol))
    ;;         key-symbols))
))

