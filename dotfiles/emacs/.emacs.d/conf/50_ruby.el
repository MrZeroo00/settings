(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode))
              auto-mode-alist))
(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode))
              interpreter-mode-alist))

(setq ruby-deep-indent-paren-style nil)

;; flymake
(setq flymake-allowed-file-name-masks
      (cons '(".+\\.rb$" flymake-ruby-init)
            flymake-allowed-file-name-masks))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             (flymake-mode t)))


;; refe
;(install-elisp "http://ns103.net/~arai/ruby/refe.el")
;(require 'refe)
;; http://d.hatena.ne.jp/rubikitch/20071228/rubyrefm
;(install-elisp "http://www.rubyist.net/~rubikitch/archive/refe2.e")
(defun refe2 (kw)
  (interactive "sReFe2: ")
  (with-current-buffer (get-buffer-create (concat "*refe2:" kw "*"))
    (when (zerop (buffer-size))
      (call-process "refe2" nil t t kw)
      (diff-mode))
    (setq minibuffer-scroll-window (get-buffer-window (current-buffer) t))
    (goto-char (point-min))
    (display-buffer (current-buffer))))


;; autotest
;(install-elisp-from-emacswiki "autotest.el")
(require 'autotest)

;; magic-comment
;; http://d.hatena.ne.jp/rubikitch/20080307/magiccomment
(defun ruby-insert-magic-comment-if-needed ()
  "バッファのcoding-systemをもとにmagic commentをつける。"
  (when (and (eq major-mode 'ruby-mode)
             (find-multibyte-characters (point-min) (point-max) 1))
    (save-excursion
      (goto-char 1)
      (when (looking-at "^#!")
        (forward-line 1))
      (if (re-search-forward "^#.+coding" (point-at-eol) t)
          (delete-region (point-at-bol) (point-at-eol))
        (open-line 1))
      (let* ((coding-system (symbol-name buffer-file-coding-system))
             (encoding (cond ((string-match "japanese-iso-8bit\\|euc-j" coding-system)
                              "euc-jp")
                             ((string-match "shift.jis\\|sjis\\|cp932" coding-system)
                              "shift_jis")
                             ((string-match "utf-8" coding-system)
                              "utf-8"))))
        (insert (format "# -*- coding: %s -*-" encoding))))))

(add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)
