; language setting
(set-language-environment "Japanese")
;(set-default-coding-systems 'euc-jp-unix)
(set-default-coding-systems 'japanese-shift-jis-dos)
;(set-w32-system-coding-system 'japanese-shift-jis-dos)
;(set-buffer-file-coding-system 'euc-jp-unix)
(set-buffer-file-coding-system 'japanese-shift-jis-dos)
(setq default-file-name-coding-system 'japanese-shift-jis)
(setq file-name-coding-system 'japanese-shift-jis)
(set-terminal-coding-system 'japanese-shift-jis-dos)
(set-keyboard-coding-system 'japanese-shift-jis-dos)
;(set-clipboard-coding-system 'japanese-shift-jis-dos)
(set-clipboard-coding-system 'cp932)
(setq default-process-coding-system '(euc-jp-unix . euc-jp-unix))

; Cygwin
(setenv "CYGWIN" "")
(setq explicit-shell-file-name "c:\\cygwin\\bin\\zsh.exe")
(setq shell-file-name "sh.exe")
(setq shell-command-switch "-c")

; other setting
(global-set-key [M-kanji] 'ignore)


;; cygwin-mount
;(install-elisp-from-emacswiki "cygwin-mount.el")
(my-require-and-when 'cygwin-mount
  (setq cygwin-mount-cygwin-bin-directory "C:\\cygwin\\bin")
  (cygwin-mount-activate))


;; vsn
;; http://www.bookshelf.jp/pukiwiki/pukiwiki.php?plugin=attach&pcmd=open&file=vsn.el&refer=Windows
(my-require-and-when 'vsn
  (global-set-key [M-return] 'vsn-line-open-buffer)
  (setq vsn-open-key "^g")
  (setq vsn-open-type "VS6")
  (setq vsn-open-exec "C:/home/Mitsuhiro.Tanda/bin/vsn-open.vbs")
  (add-hook 'c-mode-hook 'turn-on-auto-revert-mode))
