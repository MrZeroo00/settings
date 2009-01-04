;; anything-kyr
;; http://d.hatena.ne.jp/rubikitch/20080114/anythingkyr
(require 'anything-config)
(defvar anything-current-buffer nil)
(unless (boundp 'anything-current-buffer)
  (defadvice anything (before get-current-buffer activate)
    (setq anything-current-buffer (current-buffer))))
(defvar anything-kyr-candidates nil)
(defvar anything-kyr-functions nil)
(defvar anything-c-source-kyr
  '((name . "Context-aware Commands")
    (candidates . anything-kyr-candidates)
    (type . command)))
(defvar anything-kyr-commands-by-major-mode nil)
;; (setq anything-sources (list anything-c-source-kyr))
(defun anything-kyr-candidates ()
  (loop for func in anything-kyr-functions
        append (with-current-buffer anything-current-buffer (funcall func))))
(defun anything-kyr-commands-by-major-mode ()
  (assoc-default major-mode anything-kyr-commands-by-major-mode))

;; <<<  KYR vars>>>
;(setq anything-kyr-commands-by-major-mode
;      '((ruby-mode "rdefs" "rcov" "rbtest")
;        (emacs-lisp-mode "byte-compile-file"))
;      ;;
;      anything-kyr-functions
;      '(anything-kyr-commands-by-major-mode
;        ))
