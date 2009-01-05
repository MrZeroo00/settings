;; w3m
(require 'w3m-load)
;(require 'mime-w3m)

(eval-after-load "w3m"
  '(progn
(setq w3m-fill-column -10)
(setq w3m-search-default-engine "google")
(setq w3m-content-type-alist
      (cons
       '("text/html" "\\.s?html?$" browse-url-firefox) w3m-content-type-alist))
))
;(setq w3m-content-type-alist
;      '(("text/plain" "\\.\\(txt\\|tex\\|diary\\|el\\)" nil)
;        ("text/html" "\\.s?html?$" w3m-w32-browser-with-fiber)
;        ("text/html" "[0-9]+$" w3m-w32-browser-with-fiber)
;        ("image/jpeg" "\\.jpe?g$" ("fiber.exe" file))
;        ("image/png" "\\.png$" ("fiber.exe" file))
;        ("image/gif" "\\gif$" ("fiber.exe" file))
;        ("image/tiff" "\\tif?f$" ("fiber.exe" file))
;        ("image/x-xwd" "\\.xwd$" ("fiber.exe" file))
;        ("image/x-xbm" "\\.xbm$" ("fiber.exe" file))
;        ("image/x-xpm" "\\.xpm$" ("fiber.exe" file))
;        ("image/x-bmp" "\\.bmp$" ("fiber.exe" file))
;        ("video/mpeg" "\\.mpe?g$" ("fiber.exe" file))
;        ("video/quicktime" "\\.mov$" ("fiber.exe" file))
;        ("application/postscript"
;         "\\.\\(ps\\|eps\\)$" ("fiber.exe" file))
;        ("application/pdf" "\\.pdf$" ("fiber.exe" file))))


;; w3m-type-ahead
;(install-elisp-from-emacswiki "w3m-type-ahead.el")
(eval-after-load "w3m"
  '(progn
     (load "w3m-type-ahead")
     (setq w3m-type-ahead-from-point t)
     (define-key w3m-mode-map (kbd "/") 'w3m-type-ahead)
     (define-key w3m-mode-map (kbd "M-/") 'w3m-type-ahead-new-session)
     ))
