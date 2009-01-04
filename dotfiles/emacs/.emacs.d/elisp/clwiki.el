;;; clwiki.el --- Wiki modoki using ChangeLog Memo

;; Copyright (C) 2002 by Free Software Foundation, Inc.

;; Author: rubikitch <rubikitch@ruby-lang.org>
;; Keywords: tools
;; $Id: clwiki.el,v 1.9 2002/08/29 17:41:23 rubikitch Exp rubikitch $


;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; ChangeLogメモにリンク機能を追加。
;; 
;; 
;; 

;;; Code:

(require 'cl)
(require 'clmemo)

(add-to-list 'auto-mode-alist (cons "\\.clw$" 'clwiki-mode))

(defvar clwiki-open-file-function 'clwiki-open-file-by-extension
  "fileリンクをクリックしたときにそのファイルを開く関数を指定する。
引数にファイル名を取る。
デフォルトは拡張子別にプログラムを起動する `clwiki-open-file-by-extension' を起動する。")

(defvar clwiki-viewer-program-alist nil
  "(拡張子 . 起動するプログラム)のリスト。 `clwiki-open-file-by-extension' で使われる。")


(define-derived-mode clwiki-mode
  clmemo-mode "CLWiki"
  "Major mode for CLWiki.
\\{clwiki-mode-map}"
  ;(define-key clwiki-mode-map [return] 'clwiki-magic-return)
  (define-key clwiki-mode-map "\C-m" 'clwiki-magic-return)
  (define-key clwiki-mode-map "\C-c\C-c" 'clwiki-exit)
  (define-key clwiki-mode-map "\C-c\C-b" 'clwiki-append-block)
  (define-key clwiki-mode-map "\C-i" 'clwiki-next-tag)
  (define-key clwiki-mode-map "\M-\C-i" 'clwiki-previous-tag)
  (define-key clwiki-mode-map "\C-c\C-f" 'clwiki-insert-file-tag)
  (define-key clwiki-mode-map "\C-c\C-u" 'clwiki-insert-url-tag)
  (unless (clwiki-narrowed-p)
    (clwiki-narrowing))
  )

(define-derived-mode clwiki-block-mode
  text-mode "CLWiki block"
  "Major mode for CLWiki block."
  (define-key clwiki-block-mode-map "\C-c\C-c" 'clwiki-exit))

(setq clwiki-block-buffer "*clwiki block*")
(setq clwiki-saved-winconf nil)

(defun clwiki (arg)
  (interactive "P")
  (let ((add-log-current-defun-function 'ignore)
        (memo-file clmemo-file-name))
    (unless (eq major-mode 'clwiki-mode)
      (setq clwiki-saved-winconf (current-window-configuration)))
    (set-buffer (find-file-noselect memo-file))
    (clmemo arg)
    (clwiki-mode)))

(defun clwiki-narrowed-p ()
  (not (eq (1+ (buffer-size)) (point-max))))

(defun clwiki-narrowing ()
  (save-excursion
    (goto-char (point-min))
    (cond ((re-search-forward "^{{\\[block:[^]]+\\]}} #+" nil t)
           (beginning-of-line))
          (t
           (goto-char (1- (point-max)))
           (unless (bolp) (insert "\n"))))
    (narrow-to-region (point-min) (point))))


  

(defun clwiki-exit ()
  (interactive)
  (save-buffer)
  (set-window-configuration clwiki-saved-winconf))

(defun clwiki-generate-tag-name ()
  "現在時刻に基いてタグ名を生成。"
  (let ((tm (current-time)))
    (format "tag%d-%d-%d" (car tm) (second tm) (third tm))))

(defun clwiki-insert-tag (tag-name)
  (interactive "sTag Name: ")
  (insert "{{<" tag-name ">}}"))


(defun clwiki-append-block (tag-name)
  "新しいblockをつくる。"
  (interactive "sTagName: ")
  (when (string= tag-name "")
    (setq tag-name (clwiki-generate-tag-name)))
  (clwiki-insert-tag (concat "block:" tag-name))
  (let ((pop-up-windows t))
    (clwiki-prepare-block-buffer)
    (pop-to-buffer clwiki-block-buffer t t)
    (goto-char (point-max))
    (unless (bolp)
      (insert "\n"))
    (insert "\n")
    (set-window-start (selected-window) (point))
    (let* ((block-tag (concat "{{[block:" tag-name "]}}"))
           (tag-len (length block-tag))
           (fill-len 100)
           (sharp-len (- fill-len tag-len 1)))
      (insert block-tag " " (make-string sharp-len ?#) "\n"))))

(defun clwiki-insert-file-tag (file-name)
  (interactive "fFile tag: ")
  (let* ((dir-name-memo (expand-file-name (file-name-directory (buffer-file-name))))
         (dir-name-file (expand-file-name (file-name-directory file-name)))
         (rel (file-relative-name file-name dir-name-memo)))
    (unless (string= (substring rel 0 2) "..")
      (setq file-name rel))
    (clwiki-insert-tag (concat "file:" file-name))))

(defun clwiki-insert-url-tag (url)
  (interactive "sURL: ")
  (clwiki-insert-tag url))


(defvar clwiki-tag-regexp "{{<\\([^>]*\\)>}}")

(defun clwiki-next-tag (n)
  (interactive "p")
  (when (looking-at clwiki-tag-regexp)
    (goto-char (match-end 0)))
  (when (re-search-forward clwiki-tag-regexp nil t n)
    (goto-char (match-beginning 0))))

(defun clwiki-previous-tag (n)
  (interactive "p")
  (re-search-backward clwiki-tag-regexp nil t n))
      

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; rd-memo.el よりコピー
;;;; <URL:http://www.me.ics.saitama-u.ac.jp/~hira/emacs/rd-memo/> 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun clwiki-count-universal-argument (n)
  ;;(interactive "p")
  (round (log n 4)))

(defvar clwiki-magic-return-actions '(return tag))
(defun clwiki-magic-return (&optional arg)
  "ポイント位置の URL タグに書かれたファイルを開く。
URL なしの URL タグなら、新しいメモファイルを生成してリンク。
URL タグ上にいなければ, clwiki-magic-return-actions に従って動作
→ 何もつけない場合, `universal-argument' をつけた場合,
`universal-argument' `universal-argument' をつけた場合, ….
return なら改行, tag ならタグ入力, jump なら近くのタグからジャンプ."
  (interactive "p")
  (let* ((be (clwiki-search-url))
	 (b (and be (car be)))
	 (e (and be (second be)))
	 (action (nth (clwiki-count-universal-argument arg)
		      clwiki-magic-return-actions)))
    (cond ((and be (<= b (point)) (< (point) e)) (clwiki-follow-link-at b e))
	  ((eq action 'return) (newline))
	  ((eq action 'tag) (clwiki-insert-tag))
	  ((eq action 'jump) (clwiki-follow-link-at b e))
	  (t (beep) (message "Sorry. Can't understand.")))))

(defun clwiki-get-beginning-of-line ()
  "Return the boln as a position."
  (save-excursion
    (beginning-of-line)
    (point)))

(defun clwiki-get-end-of-line ()
  "Return the boln as a position."
  (save-excursion
    (end-of-line)
    (point)))


(defun clwiki-distance (c beg-end)
  (if (null beg-end)
      7777;; infinity
    (let* ((b (car beg-end))
	   (e (second beg-end)))
      (cond ((and (<= b c) (<= c e)) 0)
	    ((<= c b) (abs (- b c)))
	    ((<= e c) (abs (- c e)))))))

(defun clwiki-search-url ()
  "ポイント位置周辺で URL タグを探し、開始位置と終了位置とのリストを返す。
みつからなければ nil を返す。"
  (save-excursion
    (let* ((b (clwiki-get-beginning-of-line))
	   (e (clwiki-get-end-of-line))
	   (r "{{<[^>]*>}}")
	   (rb "{{<")
	   (re ">}}")
	   (c (point))
	   (beg-end-b (and (re-search-backward rb b t)
			   (re-search-forward r e t)
			   (list (match-beginning 0) (match-end 0))))
	   (beg-end-e (and (re-search-forward re e t)
			   (re-search-backward r b t)
			   (list (match-beginning 0) (match-end 0))))
	   (dist-b (clwiki-distance c beg-end-b))	   (dist-e (clwiki-distance c beg-end-e)))
      (cond ((and (<= dist-b dist-e) (< dist-b 777)) beg-end-b)
	    ((and (<= dist-e dist-b) (< dist-e 777)) beg-end-e)
	    (t nil)))))

(defun clwiki-open-file-by-extension (fname)
  (let* ((ext (and (string-match "\\.\\([a-zA-Z0-9]+\\)$" fname)
                   (downcase (match-string 1 fname))))
         (progm (cdr (assoc ext clwiki-viewer-program-alist))))
    (if progm
        (save-window-excursion (shell-command (concat progm " " fname "&")))
      (find-file fname))))

(defun clwiki-prepare-block-buffer ()
  (when (and (get-buffer clwiki-block-buffer)
             (not (eq (buffer-base-buffer (get-buffer clwiki-block-buffer)) (current-buffer))))
    (kill-buffer clwiki-block-buffer))
  (unless (get-buffer clwiki-block-buffer)
    (save-current-buffer
      (set-buffer (make-indirect-buffer (current-buffer) clwiki-block-buffer))
      (clwiki-block-mode)
      (widen))))
  

(defun clwiki-follow-link-at (b e)
  (let* ((d (clwiki-decompose-url-form (buffer-substring b e)))
         (type (car d))
	 (fname (second d))
	 (label (third d))
         (pt (point)))
    (case type
      ('ref
       (when (search-forward (concat "{{[" label "]}}") nil t)
         (goto-char (match-beginning 0))
         (push-mark pt)))
      ('blockref
       (let ((pop-up-windows t))
         (clwiki-prepare-block-buffer)
         (pop-to-buffer clwiki-block-buffer t t)
         (goto-char pt)
         (when (search-forward (concat "{{[block:" label "]}}") nil t)
           (beginning-of-line)
           (set-window-start (selected-window) (point))
           (push-mark pt))))
      ('file
       (funcall clwiki-open-file-function fname))
      ('url
       (browse-url fname)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ◆ リンク

;; ---- utility ----

;; {{<file:foo.txt>}}
;; {{<blockref:label-block>}}
;; {{<block:label-block>}}
;; {{<ref:label-10>}}
;; {{<label:label-10>}}

(defun clwiki-decompose-url-form (url)
  (let (type fname label)
    (cond ((string-match "{{<file:\\([^>]*\\)>}}" url)
           (setq type 'file
                 label nil
                 fname (substring url (match-beginning 1) (match-end 1))))
          ((string-match "{{<block:\\([^>]*\\)>}}" url)
           (setq type 'blockref
                 label (substring url (match-beginning 1) (match-end 1))
                 fname nil))
          ((string-match "{{<\\(\\(http\\|ftp\\):[^>]*\\)>}}" url)
           (setq type 'url
                 label nil
                 fname (substring url (match-beginning 1) (match-end 1))))
          ((string-match "{{<\\([^>]*\\)>}}" url)
           (setq type 'ref
                 label (substring url (match-beginning 1) (match-end 1))
                 fname nil))
	  (t
	   (setq type nil
                 label nil
		 fname nil)))
    (list type fname label)))

(provide 'clwiki)

;;; clwiki.el ends here