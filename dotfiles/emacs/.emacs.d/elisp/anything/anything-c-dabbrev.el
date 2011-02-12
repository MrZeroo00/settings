;;;  -*- coding: utf-8; mode: emacs-lisp; -*-
;;; anything-c-dabbrev.el

;; Author: Kenji.Imakado <ken.imakaado@gmail.com>

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
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;; 注意: このコードはコンセプトコードです。

;; 設定サンプル
;; (require 'anything-c-dabbrev)
;; (global-set-key (kbd "M-/") 'anything-c-dabbrev-current-buffer)
;; (define-key anything-c-dabbrev-anything-map (kbd "M-/") 'anything-c-dabbrev-change-all-buffer)

;;; Code

(require 'cl)
(require 'rx)
(require 'dabbrev)
(require 'anything)

(defvar anything-c-dabbrev-cur-buf-buf-name " *anything-c-dabbrev-current-buffer completion*")
(defvar anything-c-dabbrev-initial-input "")
(defvar anything-c-dabbrev-invoking-flag nil "anything-c-dabbrev が起動中はnon-nilになる")
(defvar anything-c-dabbrev-get-extra-candidates-functions nil "list of function")
(defvar anything-c-dabbrev-enable-extra-candidates-flag nil)

(defadvice anything (after cleanup-anything-c-dabbrev-invoking-flag activate)
  (setq anything-c-dabbrev-invoking-flag nil))

(defvar anything-c-dabbrev-remove-initial-input-flag t "")

(defun anything-c-dabbrev-initialize ()
  (dabbrev--reset-global-variables)
  (setq anything-c-dabbrev-initial-input (dabbrev--abbrev-at-point)
        anything-c-dabbrev-invoking-flag t))

(defun anything-c-dabbrev-all-buffer-init ()
  (let* ((dabbrev-check-other-buffers t)
         (dabbrevs (dabbrev--find-all-expansions
                    anything-c-dabbrev-initial-input
                    nil)))
    (with-current-buffer (get-buffer-create anything-c-dabbrev-cur-buf-buf-name)
      (erase-buffer)
      (when (and (featurep 'font-lock)
                 (boundp font-lock-mode))
        (font-lock-mode -1))

      (when anything-c-dabbrev-enable-extra-candidates-flag
        (loop with ret
              for fn in anything-c-dabbrev-get-extra-candidates-functions
              when (functionp fn)
              nconc (funcall fn) into ret
              finally do (setq dabbrevs (nconc dabbrevs ret))))
        
      (insert
       (mapconcat 'identity dabbrevs "\n")))))

(defun anything-c-dabbrev-current-buffer-init ()
  (let ((re (if (equal "" anything-c-dabbrev-initial-input)
                (rx-to-string `(group (+ (regexp ,dabbrev--abbrev-char-regexp))))
              (rx-to-string `(group (* (regexp ,dabbrev--abbrev-char-regexp))
                                    ,anything-c-dabbrev-initial-input
                                    (* (regexp ,dabbrev--abbrev-char-regexp))))))
        (hash (make-hash-table :test 'equal))
        (ret nil)
        (cur-point (point)))
    
    (save-excursion
      (let ((ret nil))
        (goto-char (point-min))
        (loop always (re-search-forward re cur-point t)
              do (push (match-string-no-properties 0) ret))

        (mapc (lambda (s)
                (unless (gethash s hash)
                  (puthash s nil hash)))
              ret))
      
      (let ((ret nil))
        (goto-char cur-point)
        (loop always (re-search-forward re nil t)
              do (push (match-string-no-properties 0) ret))
        
        (mapc (lambda (s)
                (unless (gethash s hash)
                  (puthash s nil hash)))
              (nreverse ret)))


      
      (maphash (lambda (symbol-str ignore-value)
                 (push symbol-str ret))
               hash))

    (when anything-c-dabbrev-remove-initial-input-flag
      (setq ret (delete anything-c-dabbrev-initial-input ret)))

    (with-current-buffer (get-buffer-create anything-c-dabbrev-cur-buf-buf-name)
      (erase-buffer)
      (when (and (featurep 'font-lock)
                 (boundp font-lock-mode))
        (font-lock-mode -1))

      (insert
       (mapconcat 'identity (nreverse ret) "\n")))))

(defun anything-c-dabbrev-buf-match (list-of-regexp &optional buffer)
  (labels ((get-line-str ()
             (buffer-substring-no-properties
              (line-beginning-position)
              (line-end-position))))
    (let ((buf (or buffer (current-buffer)))
          (ret nil)
          (first-re (first list-of-regexp))
          (rest-re-list (rest list-of-regexp)))
      (with-current-buffer (get-buffer buffer)
        (goto-char (point-min))
        (loop always (and (re-search-forward first-re nil t)
                          (not (eobp)))
              do (progn
                   (cond
                    ((null rest-re-list) 
                     (push (get-line-str) ret))
                    (t
                     (let ((line-str (get-line-str)))
                       (when (every (lambda (re)
                                      (condition-case nil
                                          (string-match re line-str)
                                        (invalid-regexp t)))
                                    rest-re-list)
                         (push line-str ret)))))
                   (forward-line 1)))
        (nreverse ret)))))

(defun anything-c-dabbrev-current-buffer-get-cands ()
  (let ((list-of-re (split-string anything-pattern "[[:space:]]+"))
        (ret nil))
    (anything-c-dabbrev-buf-match list-of-re anything-c-dabbrev-cur-buf-buf-name)))

(defun anything-c-dabbrev-insert (candidate)
  (delete-backward-char (length anything-c-dabbrev-initial-input))
  (insert candidate))

(defvar anything-c-dabbrev-anything-map (copy-keymap anything-map))

(defvar anything-c-source-dabbrev-current-buffer
  '((name . "dabbrev current buffer")
    (init . (lambda ()
              (anything-c-dabbrev-initialize)
              (anything-c-dabbrev-current-buffer-init)))
    (candidates . anything-c-dabbrev-current-buffer-get-cands)
    (action . (("Insert" . anything-c-dabbrev-insert)))
    (match . (identity))
    (volatile)))

(defvar anything-c-source-dabbrev-all-buffer
  '((name . "dabbrev all buffer")
    (init . (lambda ()
              (anything-c-dabbrev-initialize)
              (anything-c-dabbrev-all-buffer-init)))
    (candidates . anything-c-dabbrev-current-buffer-get-cands)
    (action . (("Insert" . anything-c-dabbrev-insert)))
    (match . (identity))
    (volatile)))

(defun anything-c-dabbrev-current-buffer ()
  (interactive)
  (let ((anything-sources (list anything-c-source-dabbrev-current-buffer))
        (anything-map anything-c-dabbrev-anything-map))
    (anything)))

(defun anything-c-dabbrev-all-buffer ()
  (interactive)
  (let ((anything-sources (list anything-c-source-dabbrev-all-buffer))
        (anything-map anything-c-dabbrev-anything-map))
    (anything)))

(defun anything-c-dabbrev-change-all-buffer ()
  (interactive)
  (anything-c-dabbrev-all-buffer-init)
  (anything-update))

(provide 'anything-c-dabbrev)
;;; anything-c-dabbrev.el ends here