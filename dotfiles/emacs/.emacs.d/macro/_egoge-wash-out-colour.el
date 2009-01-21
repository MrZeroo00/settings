;; egoge-wash-out-colour
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=egoge%20wash
;; http://www.emacswiki.org/cgi-bin/wiki.pl/AngryFruitSalad
(defun egoge-wash-out-colour (colour)
  "Return a colour string specifying a washed-out version of COLOUR."
  (let ((basec (color-values
                (face-attribute 'default :foreground)))
        (list nil))
    (apply 'format "#%02x%02x%02x"
           (dolist (cv (color-values colour) (nreverse list))
             (push (/ (/ (+ cv (* 2 (car basec))) 3) 256) list)))))

(defun egoge-wash-out-face (face)
  "Make the foreground colour of FACE appear a bit more pale."
  (let ((colour (face-attribute face :foreground)))
    (unless (eq colour 'unspecified)
      (set-face-attribute face nil
                          :foreground (egoge-wash-out-colour colour)))))

(defun egoge-find-faces (regexp)
  "Return a list of all faces whose names match REGEXP."
  (delq nil
        (mapcar (lambda (face)
                  (and (string-match regexp
                                     (symbol-name face))
                       face))
                (face-list))))

(when (> (length (defined-colors)) 16)
  (mapc 'egoge-wash-out-face
        (delq 'font-lock-warning-face (egoge-find-faces "^font-lock"))))
