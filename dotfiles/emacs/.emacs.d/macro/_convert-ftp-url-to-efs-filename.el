;; convert ftp url from "ftp://" to "/anonymous..."
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=ange-ftp%20tips
(defun convert-ftp-url-run-real-handler (operation args)
  (let ((inhibit-file-name-handlers
         (cons 'convert-ftp-url-to-efs-filename
               (and (eq inhibit-file-name-operation operation)
                    inhibit-file-name-handlers)))
        (inhibit-file-name-operation operation))
    (apply operation args)))

(defun convert-ftp-url-to-efs-filename (operation string &rest args)
  (string-match "^ftp://\\([^/@]+@\\)?\\([^/]+\\)" string)
  (convert-ftp-url-run-real-handler
   operation
   (cons (concat "/"
                 (if (match-beginning 1)
                     (substring string (match-beginning 1) (match-end 1))
                   "anonymous@")
                 (substring string (match-beginning 2) (match-end 2))
                 ":"
                 (substring string (match-end 2)))
         args)))

(defun convert-ftp-url-hook-function (operation &rest args)
  (let ((fn (get operation 'convert-ftp-url-to-efs-filename)))
    (if fn (apply fn operation args)
      (convert-ftp-url-run-real-handler operation args))))

(or (assoc "^ftp://[^/]+" file-name-handler-alist)
    (setq file-name-handler-alist
          (cons '("^ftp://[^/]+" . convert-ftp-url-hook-function)
                file-name-handler-alist)))

(put 'substitute-in-file-name
     'convert-ftp-url-to-efs-filename 'convert-ftp-url-to-efs-filename)
(put 'expand-file-name
     'convert-ftp-url-to-efs-filename 'convert-ftp-url-to-efs-filename)
