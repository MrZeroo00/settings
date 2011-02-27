;;;; iimage
'(my-require-and-when 'iimage)


;;;; thumbs
'(setq thumbs-thumbsdir
       (expand-file-name "~/.emacs-thumbs"))
'(setq thumbs-temp-dir (expand-file-name "~/tmp"))
'(setq image-file-name-extensions
       '("xcf" "png" "jpeg" "jpg" "gif" "tiff" "tif" "xbm" "xpm" "pbm" "pgm" "ppm"))


;;;; screenshot
;;;(install-elisp-from-emacswiki "screenshot.el")
'(my-require-and-when 'screenshot
   (setq screenshot-schemes
         '(
           ;; To local image directory
           ("local"
            :dir "~/images/")
           ;; To current directory
           ("current-directory"
            :dir default-directory)
           ;; To remote ssh host
           ("remote-ssh"
            :dir "/tmp/"
            :ssh-dir "www.example.org:public_html/archive/"
            :url "http://www.example.org/archive/")
           ;; To EmacsWiki (need yaoddmuse.el)
           ("EmacsWiki"
            :dir "~/.yaoddmuse/EmacsWiki/"
            :yaoddmuse "EmacsWiki")
           ;; To local web server
           ("local-server"
            :dir "~/public_html/"
            :url "http://127.0.0.1/")))
   (setq screenshot-default-scheme "local"))
