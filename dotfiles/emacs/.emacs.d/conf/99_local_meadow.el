(set-language-environment "Japanese")

;;;; IME
(setq default-input-method "MW32-IME")
(add-hook 'mw32-ime-on-hook
          (function (lambda () (set-cursor-color "SkyBlue"))))
(add-hook 'mw32-ime-off-hook
          (function (lambda () (set-cursor-color "LemonChiffon"))))
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[J]" "[--]"))
(mw32-ime-initialize)

;;;; mouse cursor
(setq w32-hide-mouse-timeout 1000)
(setq w32-hide-mouse-on-key t)


;;;; ttfont-setup
;;;(install-elisp "http://www.fan.gr.jp/~ring/doc/misc/ttfont-setup.el")
(my-require-and-when 'ttfont-setup
  (ttfont-setup))


;;;; font-setup
;;;(install-elisp "http://www.bookshelf.jp/elc/font-setup.el")
;;;; フォント設定
'(my-require-and-when 'font-setup
  (setq font-setup-bdf-dir
        (expand-file-name "../../fonts/intlfonts" data-directory))
  (defun font-setup-small (&optional font num unuse set)
    (interactive)
    (let ((fn (or font font-setup-ttf-def))
          (n (or num font-setup-ttf-def-number))
          (dir (expand-file-name font-setup-bdf-dir))
          fs min
          (num 2) (size -14))
      (setq min (or font-setup-bdf-hangul-mincho
                    (string-match "明朝\\|mincho" fn)))

      (while (not (= num 0))
        (if (= num 1)
            (setq size -12))
        (setq fs
              (or set
                  (concat fn (int-to-string size))))
        (w32-add-font
         fs
         `((spec
            ;; **TrueType Fonts**
            ;; ascii
            ((:char-spec ascii :height any)
             strict
             (w32-logfont ,fn 0 ,size 400 0 nil nil nil 0 1 3 ,n))
            ((:char-spec ascii :height any :weight bold)
             strict
             (w32-logfont ,fn 0 ,size 700 0 nil nil nil 0 1 3 ,n)
             ((spacing . -1)))
            ((:char-spec ascii :height any :weight normal :slant italic)
             strict
             (w32-logfont ,fn 0 ,size 400 0 t nil nil 0 1 3 ,n))
            ((:char-spec ascii :height any :weight bold :slant italic)
             strict
             (w32-logfont ,fn 0 ,size 700 0 t nil nil 0 1 3 ,n)
             ((spacing . -1)))
            ;; katakana-jisx0201
            ((:char-spec katakana-jisx0201 :height any)
             strict
             (w32-logfont ,fn 0 ,size 400 0 nil nil nil 128 1 3 ,n))
            ((:char-spec katakana-jisx0201 :height any :weight bold)
             strict
             (w32-logfont ,fn 0 ,size 700 0 nil nil nil 128 1 3 ,n)
             ((spacing . -1)))
            ((:char-spec katakana-jisx0201
                         :height any :weight normal :slant italic)
             strict
             (w32-logfont ,fn 0 ,size 400 0 t nil nil 128 1 3 ,n))
            ((:char-spec katakana-jisx0201
                         :height any :weight bold :slant italic)
             strict
             (w32-logfont ,fn 0 ,size 700 0 t nil nil 128 1 3 ,n)
             ((spacing . -1)))
            ;; japanese-jisx0208
            ((:char-spec japanese-jisx0208 :height any)
             strict
             (w32-logfont ,fn 0 ,size 400 0 nil nil nil 128 1 3 ,n))
            ((:char-spec japanese-jisx0208 :height any :weight bold)
             strict
             (w32-logfont ,fn 0 ,size 700 0 nil nil nil 128 1 3 ,n)
             ((spacing . -1)))
            ((:char-spec japanese-jisx0208
                         :height any :weight normal :slant italic)
             strict
             (w32-logfont ,fn 0 ,size 400 0 t nil nil 128 1 3 ,n))
            ((:char-spec japanese-jisx0208
                         :height any :weight bold :slant italic)
             strict
             (w32-logfont ,fn 0 ,size 700 0 t nil nil 128 1 3 ,n)
             ((spacing . -1))))))
        ;; その他
        (setq scalable-fonts-allowed t)
        (setq num (- num 1)))))
  (font-setup "ＭＳ ゴシック" 49 t)
  (font-setup "ＭＳ 明朝" 17 t)
  (font-setup-small "ＭＳ ゴシック" 49 t)
  (font-setup-small "ＭＳ 明朝" 17 t)
  ;; IME の Font
  (add-to-list 'default-frame-alist
               `(ime-font
                 w32-logfont "ＭＳ ゴシック" 0 0 400 0 nil nil nil 128 1 3 49)))


;;;; buffer-fiber-exe
;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=fiberfile
(defun buffer-fiber-exe ()
  (interactive)
  (let ((file (buffer-file-name)))
    (cond
     ((string= major-mode 'dired-mode)
      (if (string-match "^\\([a-z]:\\)/$" default-directory)
          (start-process "explorer" "diredfiber" "explorer.exe"
                         (match-string 1 default-directory))
        (start-process "explorer" "diredfiber" "explorer.exe"
                       (unix-to-dos-filename
                        (directory-file-name
                         default-directory)))))
     ((and mmemo-buffer-file-name
           (file-exists-p mmemo-buffer-file-name))
      (start-process "fiber" "diredfiber" "fiber.exe"
                     mmemo-buffer-file-name))
     ((not file)
      (error
       "現在のバッファはファイルではありません"))
     ((file-directory-p file)
      (start-process
       "explorer" "diredfiber" "explorer.exe"
       (unix-to-dos-filename file)))
     ((file-exists-p file)
      (start-process
       "fiber" "diredfiber" "fiber.exe" file))
     ((not (file-exists-p file))
      (error "ファイルが存在しません")))))


(my-require-and-when 'outlookedit)
