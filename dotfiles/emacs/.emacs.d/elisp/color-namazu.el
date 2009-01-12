;; -*- Mode: Emacs-Lisp -*-
;;
;;  $Id: color-namazu.el,v 2.2 2007/11/04 13:37:15 akihisa Exp $

;; Author: Matsushita Akihisa <akihisa@mail.ne.jp>
;; Keywords: namazu highlight

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; color-namazu highlights *every* match for the current search
;; string.

;; This file requires namazu.el, color-occur.el
;; The latest version of these program can be downloaded from
;; http://arika.org/timecapsule/namazu-el/
;; http://www.bookshelf.jp/elc/color-occur.el.

;;; Install:

;; Put this file into load-path'ed directory, and byte compile it if
;; desired.  And put the following expression into your ~/.emacs.
;;
;;     (require 'color-namazu)

;; The latest version of this program can be downloaded from
;; http://www.bookshelf.jp/elc/color-namazu.el

;;; History:

;; 2002/11/12: Ver.1.00

;;; Code:

(require 'view)
(require 'namazu)
(require 'color-occur)

(defface colorful-namazu-color-face
  '((((class color)
      (background dark))
     (:background "SkyBlue" :bold t :foreground "Black"))
    (((class color)
      (background light))
     (:background "ForestGreen" :bold t))
    (t
     ()))
  "*Face used by color-namazu to show the text that matches.
If the value is nil, don't highlight the matching portions specially.")

(defvar colorful-namazu-mark-search-word "")
(defvar colorful-namazu-overlays nil)
(defvar colorful-namazu-buffer nil)
(defvar colorful-namazu-mode t
  "*Non-nil means namazu highlight the text that matches.")

(defun colorful-namazu-mark-start (com)
  (save-excursion
    (colorful-namazu-remove-overlays)
    (let ((nmzkey com))
      (while (string-match " and \\| or \\| " nmzkey nil)
        (setq nmzkey (replace-match "\\\\|" nil nil nmzkey)))
      (while (string-match "/\\|(\\|)\\|{\\|}" nmzkey nil)
        (setq nmzkey (replace-match "" nil nil nmzkey)))
      (while (string-match "\\*" nmzkey nil)
        (setq nmzkey (replace-match "[^ \n\t]" nil nil nmzkey)))
      (setq colorful-namazu-mark-search-word nmzkey)
      )))

(defun colorful-namazu-mark-namazu-buf ()
  "*Highlight namazu buffer."
  (let ((ov))
    (save-excursion
      (if colorful-namazu-mark-search-word
          (progn
            (goto-char (point-min))
            (while (re-search-forward colorful-namazu-mark-search-word nil t)
              (progn
                (setq ov (make-overlay (match-beginning 0)
                                       (match-end 0)))
                (overlay-put ov 'face 'colorful-namazu-color-face)
                (overlay-put ov 'priority 0)
                (setq colorful-namazu-overlays (cons ov colorful-namazu-overlays)))))
        ))
    ))

(defun colorful-namazu-mark ()
  "*Highlight file buffer. Move cursor to the fist matching text"
  (let ((ov))
    (if (and (not (string= (buffer-name (current-buffer)) namazu-buffer))
             colorful-namazu-mark-search-word)
        (progn
          (save-excursion
            (if (not view-mode)
                (view-mode-enable))
            (colorful-namazu-view-mode)
            (setq colorful-namazu-buffer (current-buffer))
            (if colorful-namazu-mode
                (colorful-namazu-mark-namazu-buf)))
          (goto-char (point-min))
          (if (re-search-forward colorful-namazu-mark-search-word nil t)
              ()
            (goto-char (point-max))
            ))
      )))

(defun colorful-namazu-prev-view ()
  (namazu-view)
  (if (string= (buffer-name (current-buffer)) namazu-buffer)
      ()
    (goto-char (point-max))
    (if (re-search-backward colorful-namazu-mark-search-word nil t)
        ()
      (goto-char (point-min))
      )))

(defun colorful-namazu-next-match (&optional arg)
  (interactive "p")
  (let ((n 0))
    (while (< n (prefix-numeric-value arg))
      (if (not (= (point-max) (point)))
          (forward-char 1))
      (if (re-search-forward colorful-namazu-mark-search-word nil t)
          ()
        (progn
          (kill-buffer (current-buffer))
          (switch-to-buffer namazu-buffer)
          (forward-line 1)
          (if (re-search-forward namazu-output-url-pattern nil t)
              (namazu-view)
            (if (and namazu-auto-turn-page
                     (< namazu-current-page namazu-max-page))
                (progn
                  (namazu-next-page)
                  (setq n (prefix-numeric-value arg))
                  (namazu-jump-next)
                  (namazu-view)
                  ))
            )))
      (setq n (+ n 1)))
    ))

(defun colorful-namazu-prev-match (&optional arg)
  (interactive "p")
  (let ((n 0))
    (while (< n (prefix-numeric-value arg))
      (if (not (= (point-min) (point)))
          (forward-char -1))
      (if (re-search-backward colorful-namazu-mark-search-word nil t)
          ()
        (progn
          (kill-buffer (current-buffer))
          (switch-to-buffer namazu-buffer)
          (forward-line -1)
          (if (re-search-backward namazu-output-url-pattern nil t)
              (namazu-view)
            (if (and namazu-auto-turn-page
                     (> namazu-current-page 0))
                (progn
                  (namazu-prev-page)
                  (goto-char (point-max))
                  (namazu-jump-prev)
                  (setq n (prefix-numeric-value arg))
                  (colorful-namazu-prev-view)
                  ))
            )))
      (setq n (+ n 1)))
    ))

(defun colorful-namazu-next-file (&optional arg)
  (interactive "p")
  (let ((n 0) (last-file nil))
    (kill-buffer (current-buffer))
    (switch-to-buffer namazu-buffer)

    (save-excursion
      (forward-line 1)
      (if (or (re-search-forward namazu-output-url-pattern nil t)
              (and namazu-auto-turn-page
                   (< namazu-current-page namazu-max-page)))
          (setq last-file nil)
        (setq last-file t)))

    (while (< n (prefix-numeric-value arg))
      (setq pos (point))
      (namazu-jump-next)
      (setq n (+ n 1)))

    (if last-file
        ()
      (namazu-view))
    ))

(defun colorful-namazu-prev-file (&optional arg)
  (interactive "p")
  (let ((n 0) (last-file nil))
    (kill-buffer (current-buffer))
    (switch-to-buffer namazu-buffer)

    (save-excursion
      (forward-line -1)
      (if (or (re-search-backward namazu-output-url-pattern nil t)
              (and namazu-auto-turn-page
                   (> namazu-current-page 0)))
          (setq last-file nil)
        (setq last-file t)))

    (while (< n (prefix-numeric-value arg))
      (namazu-jump-prev)
      (setq n (+ n 1)))

    (if last-file
        ()
      (colorful-namazu-prev-view))
    ))

(defun colorful-namazu-remove-overlays ()
  (interactive)
  (while colorful-namazu-overlays
    (delete-overlay (car colorful-namazu-overlays))
    (setq colorful-namazu-overlays (cdr colorful-namazu-overlays))))

(defun colorful-namazu-toggle (&optional arg)
  (interactive "P")
  (setq colorful-namazu-mode
        (if (null arg)
            (not colorful-namazu-mode)
          (> (prefix-numeric-value arg) 0)))
  (if colorful-namazu-mode
      (colorful-namazu-mark-namazu-buf)
    (colorful-namazu-remove-overlays))
  )

(defun colorful-namazu-view-first-match ()
  "*View file"
  (interactive)
  (namazu-view)
  (if (and (not (string= (buffer-name (current-buffer)) namazu-buffer))
           colorful-namazu-mark-search-word)
      (progn
        (goto-char (point-min))
        (if (re-search-forward colorful-namazu-mark-search-word nil t)
            ()
          (goto-char (point-max))))))

(defun colorful-namazu-view-last-match ()
  "*Highlight file buffer. Move cursor to the last matching text"
  (interactive)
  (namazu-view)
  (if (and (not (string= (buffer-name (current-buffer)) namazu-buffer))
           colorful-namazu-mark-search-word)
      (progn
        (goto-char (point-max))
        (if (re-search-backward colorful-namazu-mark-search-word nil t)
            ()
          (goto-char (point-min))))))

(defun namazu-view-kill-and-leave ()
  "Quit View mode, kill current buffer and return to previous buffer."
  (interactive)
  (if (get-buffer "*Occur*")
      (kill-buffer (get-buffer "*Occur*")))
  (view-mode-exit view-return-to-alist (or view-exit-action 'kill-buffer) t)
  (switch-to-buffer namazu-buffer)
  (delete-other-windows)
  )

(defun colorful-namazu-occur (&optional arg)
  (interactive "P")
  (let ((migemo-occur nil))
    (if arg
        (occur colorful-namazu-mark-search-word arg)
      (occur colorful-namazu-mark-search-word 0))
    (switch-to-buffer-other-window (get-buffer "*Occur*"))
    (colorful-namazu-occur-mode)
    (color-occur-next)
    ))

(defun colorful-namazu-occur-remove-overlays ()
  (interactive)
  (if color-occur-underline-overlays
      (progn
        (delete-overlay color-occur-underline-overlays)
        (setq color-occur-underline-overlays nil))))

(defun colorful-namazu-occur-next (&optional n)
  (interactive)
  (if (= (point) (save-excursion (forward-line 1) (point)))
      (progn
        (colorful-namazu-occur-exit)
        (goto-char (point-max))
        (colorful-namazu-next-match)
        (if (and
             (not (string= (buffer-name (current-buffer)) namazu-buffer))
             colorful-namazu-view-mode)
            (colorful-namazu-occur)
          ))
    (color-occur-next n)))

(defun colorful-namazu-occur-prev (&optional n)
  (interactive)
  (if (= (point) (save-excursion (forward-line -1) (point)))
      (progn
        (colorful-namazu-occur-exit)
        (goto-char (point-min))
        (colorful-namazu-prev-match)
        (if (and
             (not (string= (buffer-name (current-buffer)) namazu-buffer))
             colorful-namazu-view-mode)
            (progn
              (colorful-namazu-occur)
              (goto-char (point-max))
              (color-occur-prev))
          ))
    (color-occur-prev n)))

(defun namazu-occur-mode-goto-occurrence ()
  "Go to the occurrence the current line describes."
  (interactive)
  (let ((pos (occur-mode-find-occurrence)))
    (pop-to-buffer occur-buffer)
    (goto-char (marker-position pos))
    (colorful-namazu-occur-remove-overlays)))

(defun colorful-namazu-occur-exit ()
  (interactive)
  (kill-buffer (get-buffer "*Occur*"))
  (colorful-namazu-occur-remove-overlays)
  (switch-to-buffer colorful-namazu-buffer)
  (delete-other-windows)
  )

(defvar colorful-namazu-view-mode nil
  "*Non-nil means in an colorful-namazu-view-mode.")
(make-variable-buffer-local 'colorful-namazu-view-mode)
(defvar colorful-namazu-view-mode-map nil "")

(or colorful-namazu-view-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map "h"
        (function colorful-namazu-next-file))
      (define-key map "j"
        (function colorful-namazu-next-match))
      (define-key map "k"
        (function colorful-namazu-prev-match))
      (define-key map "l"
        (function colorful-namazu-prev-file))
      (define-key map "o"
        (function colorful-namazu-occur))
      (define-key map "q"
        (function namazu-view-kill-and-leave))
      (define-key map "b"
        (function View-scroll-page-backward))
      (define-key map "t"
        (function colorful-namazu-toggle))
      (setq colorful-namazu-view-mode-map map)
      ))

(when (boundp 'minor-mode-map-alist)
  (or (assq 'colorful-namazu-view-mode-map minor-mode-map-alist)
      (setq minor-mode-map-alist
            (cons (cons 'colorful-namazu-view-mode colorful-namazu-view-mode-map)
                  minor-mode-map-alist))))

(defun colorful-namazu-view-mode (&optional arg)
  (interactive "P")
  (setq colorful-namazu-view-mode
        (if (null arg)
            (not colorful-namazu-view-mode)
          (> (prefix-numeric-value arg) 0))))

(defvar colorful-namazu-occur-mode nil
  "*Non-nil means in an colorful-namazu-occur-mode.")
(make-variable-buffer-local 'colorful-namazu-occur-mode)
(defvar colorful-namazu-occur-mode-map nil "")

(or colorful-namazu-occur-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map '[down]
        (function colorful-namazu-occur-next))
      (define-key map '[up]
        (function colorful-namazu-occur-prev))
      (define-key map "n"
        (function colorful-namazu-occur-next))
      (define-key map "p"
        (function colorful-namazu-occur-prev))
      (define-key map "h"
        (function colorful-namazu-occur-next))
      (define-key map "j"
        (function colorful-namazu-occur-next))
      (define-key map "k"
        (function colorful-namazu-occur-prev))
      (define-key map "l"
        (function colorful-namazu-occur-prev))
      (define-key map "q"
        (function colorful-namazu-occur-exit))
      (define-key map "b"
        (function color-occur-scroll-down))
      (define-key map " "
        (function color-occur-scroll-up))
      (define-key map "\C-m"
        (function namazu-occur-mode-goto-occurrence))
      (setq colorful-namazu-occur-mode-map map)
      ))

(when (boundp 'minor-mode-map-alist)
  (or (assq 'colorful-namazu-occur-mode-map minor-mode-map-alist)
      (setq minor-mode-map-alist
            (cons (cons 'colorful-namazu-occur-mode colorful-namazu-occur-mode-map)
                  minor-mode-map-alist))))

(defun colorful-namazu-occur-mode (&optional arg)
  (interactive "P")
  (setq colorful-namazu-occur-mode
        (if (null arg)
            (not colorful-namazu-occur-mode)
          (> (prefix-numeric-value arg) 0))))

(define-key namazu-mode-map "i" 'colorful-namazu-view-last-match)
(define-key namazu-mode-map "u" 'colorful-namazu-view-first-match)
(define-key namazu-mode-map "t" 'colorful-namazu-toggle)

(add-hook 'namazu-display-hook
          (lambda ()
            (if colorful-namazu-mode
                (colorful-namazu-mark-namazu-buf))))

(defadvice namazu
  (before namazu-mode activate)
  (colorful-namazu-mark-start key))

(defadvice namazu-view
  (after namazu-browse-url activate)
  (colorful-namazu-mark))

(provide 'color-namazu)
