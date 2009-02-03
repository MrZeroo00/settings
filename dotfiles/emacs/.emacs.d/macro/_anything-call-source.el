;; anything-call-source
;; http://d.hatena.ne.jp/rubikitch/20090128/1233141924
(defvar anything-call-source-buffer "*anything source select*")
(defvar anything-c-source-call-source
  `((name . "Call anything source")
    (candidate-number-limit . 9999)
    (candidates
     . (lambda ()
         (loop for vname in (all-completions "anything-c-source-" obarray)
               for var = (intern vname)
               for name = (ignore-errors (assoc-default 'name (symbol-value var)))
               if name collect (cons (format "%s (%s)" name vname) var))))
    (action . (("Invoke anything with selected source" .
                (lambda (candidate)
                  (anything candidate nil nil nil nil
                            anything-call-source-buffer)))
               ("Describe variable" . describe-variable)))
    (persistent-action . describe-variable)))

(defun anything-call-source ()
  "Call anything source."
  (interactive)
  (anything 'anything-c-source-call-source nil nil nil nil
            anything-call-source-buffer))
