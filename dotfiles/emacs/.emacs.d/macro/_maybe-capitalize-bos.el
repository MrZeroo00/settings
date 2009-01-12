;; maybe-capitalize-bos
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=abbrev%20capitalize
(define-abbrev text-mode-abbrev-table "emacs" "Emacs")
(define-abbrev text-mode-abbrev-table "i" "I" #'abbrev-not-at-stop)
(define-abbrev text-mode-abbrev-table "i'm" "I'm") ; ... egocentric


(defun maybe-capitalize-bos ()
  "If point is at the end of the first word in a sentence, capitalize it."
  (if (= (point)
         (save-excursion
           (backward-sentence)
           (forward-word 1)
           (point)))
      (capitalize-word -1)))

;; Capitalize words at beginning of sentence.
(add-hook 'text-mode-hook (lambda ()
                            (make-local-hook 'pre-abbrev-expand-hook)
                            (add-hook 'pre-abbrev-expand-hook
                                      'maybe-capitalize-bos
                                      nil t)))

(defun abbrev-not-at-stop ()            ; avoid `i.e.' -> `I.e.'
  "Unexpand abbrev if it was just expanded by a full stop.
Intended as an abbrev hook function."
  (if (eq ?. last-command-char)
      (unexpand-abbrev)))
