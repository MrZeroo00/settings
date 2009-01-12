;;; colorful.el --- 色んな色を色んなバッファに

;; Copyright (C) 2000 by Taiki Sugawara

;; Author: Taiki Sugawara <taiki.s@cityfujisawa.ne.jp>
;; Keywords: faces

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

;; 

;;; Code:

(defvar colorful-overlay nil)
(make-variable-buffer-local 'colorful-overlay)
(put 'highline-overlay 'permanent-local t)

(defvar colorful-ignore-regexp "^ ")
(defvar colorful-parmanent-regexp "Minibuf\\|\\*Completions\\*")
(defvar colorful-change-foreground nil)
(defvar colorful-using-hook-list
  '(post-command-hook
    temp-buffer-show-hook
    first-change-hook
    comint-exec-hook))

;; 乱数の種をあれする
(random t)

(defun colorful-colorful-buffer (&optional d1 d2 d3)
  (unless (and colorful-ignore-regexp
               (string-match colorful-ignore-regexp (buffer-name)))
    (unless colorful-overlay
      (setq colorful-overlay (make-overlay 1 1))
      (overlay-put colorful-overlay 'priority 0)
      (overlay-put colorful-overlay 'face (colorful-make-face)))
    (move-overlay colorful-overlay 1 (1+ (buffer-size)))))
    
(defun colorful-uncolorful-buffer ()
  (and colorful-overlay
       (move-overlay colorful-overlay 1 1)))

(defun colorful-make-face ()
  (let ((face (colorful-get-face)))
    (unless (and (memq face (face-list))
                 colorful-parmanent-regexp
                 (string-match colorful-parmanent-regexp (buffer-name)))
      (setq face (make-face face))
      (let ((list (mapcar 'random '(255 255 255))))
        (set-face-background face (apply 'format
                                         "#%02x%02x%02x"
                                         list))
        (put face 'colorful-foreground (apply 'format
                                     "#%02x%02x%02x"
                                     (mapcar* 'logxor
                                              list '(255 255 255)))))
      (colorful-set-face-foreground face))
    face))
  
(defsubst colorful-get-face ()
  (intern (concat "colorful-" (buffer-name) "-face")))

(defsubst colorful-set-face-foreground (face)
  (when (memq face (face-list))
    (set-face-foreground face (if colorful-change-foreground
                                  (get face 'colorful-foreground)
                                nil))))

(defmacro colorful-do-all-buffers (&rest body)
  `(save-excursion
     (dolist (buffer (buffer-list))
       (set-buffer buffer)
       ,@body)))

(defun colorful-toggle-change-foreground ()
  (interactive)
  (setq colorful-change-foreground (not colorful-change-foreground))
  (colorful-do-all-buffers
   (colorful-set-face-foreground (colorful-get-face))))

(defun colorful-recolor-buffer ()
  (interactive)
  (let ((colorful-parmanent-regexp nil))
    (colorful-make-face)))

(defadvice display-buffer (after colorful-ad disable)
  (save-excursion
    (set-buffer (window-buffer ad-return-value))
    (colorful-colorful-buffer)))

(defun colorful-on ()
  (interactive)
  (mapcar (lambda (x) (add-hook x 'colorful-colorful-buffer))
          colorful-using-hook-list)
  (ad-enable-advice 'display-buffer 'after 'colorful-ad)
  (ad-activate 'display-buffer)
  (colorful-do-all-buffers
   (colorful-colorful-buffer))
  (message "Welcom to colorful world!"))

(defun colorful-off ()
  (interactive)
  (mapcar (lambda (x) (remove-hook x 'colorful-colorful-buffer))
          colorful-using-hook-list)
  (ad-disable-advice 'display-buffer 'after 'colorful-ad)
  (ad-activate 'display-buffer)
  (colorful-do-all-buffers
   (colorful-uncolorful-buffer))
  (message "Please come to colorful world again."))

(provide 'colorful)

;;; colorful.el ends here