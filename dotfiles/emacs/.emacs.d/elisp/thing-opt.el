;;; thing-opt.el --- Thing at Point optional utilities

;; Copyright (C) 2008  MATSUYAMA Tomohiro

;; Author: MATSUYAMA Tomohiro <t.matsuyama.pub@gmail.com>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; TODO documentation
;; TODO forward-string by syntax (?)

;;; Code:

(require 'thingatpt)

(defvar thing-list-cache nil)
(defvar upward-mark-thing-index 0)
(defvar upward-mark-thing-list '(string symbol (up-list . *)))
(defvar upward-mark-thing-trial 0)
(defvar upward-mark-thing-original-position)

(defun thingp (thing)
  (or (get thing 'bounds-of-thing-at-point)
      (get thing 'forward-op)
      (get thing 'beginning-op)
      (get thing 'end-op)
      (fboundp (intern-soft (concat "forward-" (symbol-name thing))))))

(defun list-thing ()
  (let (things)
    (mapatoms
     (lambda (atom)
       (if (thingp atom)
           (push atom things))))
    things))

(defun read-thing ()
  (or thing-list-cache
      (setq thing-list-cache (list-thing)))
  (completing-read "Thing: " (mapcar 'list thing-list-cache)
                   nil nil nil nil "sexp"))

;;;###autoload
(defun kill-thing (thing)
  (interactive (list (read-thing)))
  (if (stringp thing)
      (setq thing (intern thing)))
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
        (kill-region (car bounds) (cdr bounds)))))

;;;###autoload
(defun mark-thing (thing)
  (interactive (list (read-thing)))
  (if (stringp thing)
      (setq thing (intern thing)))
  (let ((bounds (bounds-of-thing-at-point thing)))
    (when bounds
      (goto-char (car bounds))
      (push-mark (cdr bounds) nil transient-mark-mode))))

;;;###autoload
(defun upward-mark-thing ()
  (interactive)
  (if (not (eq last-command this-command))
      (setq upward-mark-thing-index 0
            upward-mark-thing-trial 0
            upward-mark-thing-original-position (point)))
  (let ((index upward-mark-thing-index)
        (length (length upward-mark-thing-list))
        bounds)
    (while (and (null bounds)
                (< index length))
      (let ((thing (nth index upward-mark-thing-list))
            (limit '*))
        (if (consp thing)
            (setq limit (cdr thing)
                  thing (car thing)))
        (setq bounds (bounds-of-thing-at-point thing))
        (when (or (null bounds)
                  (and (not (eq limit '*)) (>= upward-mark-thing-trial limit))
                  (eq (car bounds) (cdr bounds))
                  (and mark-active
                       (eq (car bounds) (point))
                       (eq (cdr bounds) (mark))))
          (setq bounds nil
                index (1+ index)
                upward-mark-thing-index (1+ upward-mark-thing-index)
                upward-mark-thing-trial 0)
          (goto-char upward-mark-thing-original-position))))
    (when bounds
      (setq upward-mark-thing-trial (1+ upward-mark-thing-trial))
      (goto-char (car bounds))
      (push-mark (cdr bounds) t 'activate)
      (setq deactivate-mark nil))))

(defun string-face-p (face)
  (let (result)
    (or (consp face)
        (setq face (list face)))
    (while (and face (null result))
      (if (memq (car face) '(font-lock-string-face font-lock-doc-face))
          (setq result t)
        (setq face (cdr face))))
    result))

(defun forward-string (&optional arg)
  (interactive "p")
  (if (null arg)
      (setq arg 1))
  (cond
   ((> arg 0)
    (condition-case nil
        (while (> arg 0)
          (while (and (re-search-forward "\\s\"")
                      (string-face-p (get-text-property (point) 'face))))
          (setq arg (1- arg)))
      (error . nil)))
   ((< arg 0)
    (condition-case nil
        (while (< arg 0)
          (while (and (re-search-backward "\\s\"")
                      (string-face-p (get-text-property (1- (point)) 'face))))
          (setq arg (1+ arg)))
      (error . nil)))))

(defun backward-string (&optional arg)
  (interactive "p")
  (forward-string (- (or arg 1))))

(defun bounds-of-up-list-at-point ()
  (condition-case nil
      (save-excursion
        (let ((pos (scan-lists (point) -1 1)))
          (goto-char pos)
          (forward-list)
          (cons pos (point))))
    (error nil)))

(put 'up-list 'bounds-of-thing-at-point (symbol-function 'bounds-of-up-list-at-point))

(provide 'thing-opt)
;;; thing-opt.el ends here
