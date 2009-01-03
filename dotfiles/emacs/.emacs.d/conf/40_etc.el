;; Outputz
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/outputz/outputz.el")
(require 'outputz)
(setq outputz-key "Your Private Key")      ;; 復活の呪文
(setq outputz-uri "http://example.com/%s") ;; 適当なURL。%sにmajor-modeの名前が入るので、major-modeごとのURLで投稿できます。
(global-outputz-mode t)

(require 'outputz)
(defun outputz-buffers ()
  (dolist (buf (buffer-list))
    (with-current-buffer buf
    (outputz))))

(run-with-idle-timer 3 t 'outputz-buffers)
(remove-hook 'after-save-hook 'outputz)


;; bm
;; http://www.nongnu.org/bm/
(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)


;; minibuf-isearch
(require 'minibuf-isearch)


;; session
;; http://emacs-session.sourceforge.net/
(require 'session)
(add-hook 'after-init-hook 'session-initialize)


;; install-elisp
;(install-elisp-from-emacswiki "install-elisp.el")
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")
;(install-elisp-from-emacswiki "oddmuse.el")
;(require 'oddmuse)
;;(setq url-proxy-services '(("http" . "your.proxy.host:portnumber"))
;(oddmuse-mode-initialize)


;; color-selection
;(install-elisp "http://www.bookshelf.jp/elc/color-selection.el")
(autoload 'list-hexadecimal-colors-display "color-selection"
  "Display hexadecimal color codes, and show what they look like." t)


;; keisen-mule
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=keisen
(if window-system
    (autoload 'keisen-mode "keisen-mouse" "MULE 版罫線モード + マウス" t)
  (autoload 'keisen-mode "keisen-mule" "MULE 版罫線モード" t))


;; yank current line
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=duplicate%20line
(defun duplicate-line (&optional numlines)
  "One line is duplicated wherever there is a cursor."
  (interactive "p")
  (let* ((col (current-column))
         (bol (progn (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point)))
         (line (buffer-substring bol eol)))
    (while (> numlines 0)
      (insert "\n" line)
      (setq numlines (- numlines 1)))
    (move-to-column col)))
(define-key esc-map "Y" 'duplicate-line)


;; yank region text with line number
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=copy-region-with-info
(defun copy-region-with-info (arg)
  "リージョンの各行に行番号とファイル名をつけてヤンクバッファにコピー
   C-u で数引数をつけると、ファイル名がフルパスで付与される"
  (interactive "p")
  (save-excursion
    (let ((e (max (region-end) (region-beginning)))
          (b (min (region-end) (region-beginning)))
          (str)
          (first t))
      (goto-char b)
      (while (<= (+ (point) 1) e)
        (beginning-of-line)
        (setq str
              (format
               "%s:%d:%s"
               (if (not (eq arg 1))
                   (buffer-file-name)
                 (buffer-name))
               (1+ (count-lines 1 (point)))
               (buffer-substring
                (point)
                (progn
                  (end-of-line)
                  (if (eobp)
                      (signal 'end-of-buffer nil))
                  (forward-char)
                  (point)))))
        (backward-char)
        (if (not first)
            (kill-append str nil)
          (setq kill-ring
                (cons str
                      kill-ring))
          (if (> (length kill-ring) kill-ring-max)
              (setcdr (nthcdr (1- kill-ring-max) kill-ring) nil))
          (setq kill-ring-yank-pointer kill-ring)
          (setq first nil))
        (forward-line 1)))))
