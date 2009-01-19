;;; one-key.el --- One key

;; Filename: one-key.el
;; Description: One key
;; Author: Andy Stewart lazycat.manatee@gmail.com
;; Maintainer: Andy Stewart lazycat.manatee@gmail.com
;; Copyright (C) 2008, 2009, Andy Stewart, all rights reserved.
;; Created: 2008-12-22 21:54:30
;; Version: 0.3
;; Last-Updated: 2009-01-15 23:40:39
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/one-key.el
;; Keywords: one-key
;; Compatibility: GNU Emacs 23.0.60.1
;;
;; Features that might be required by this library:
;;
;;
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Along with many extensions into Emacs, have many keystroke is
;; used, and always forget the keystroke when have too many.
;;
;; This package is for fix above problems.
;;
;; One Key provide a handle with TOP keystroke, and then when you
;; type TOP keystroke, you will get a keystroke menu with pop-up
;; window, and will show a group keystroke in pop-up window.
;;
;; Then you just type keystroke in window show, you can execute
;; command corresponding.
;;
;; So you need just remember the TOP keystroke with group command.
;; Others keystroke notify will display in pop-up window.
;;
;; * Quick use:
;;
;; Setup below variable and function in your ~/.emacs
;;
;; (defvar one-key-menu-emms-alist nil
;;   "`One-Key' menu list for EMMS.")
;;
;; (setq one-key-menu-emms-alist
;;       '(
;;         (("g" . "Playlist Go") . emms-playlist-mode-go)
;;         (("d" . "Play Directory Tree") . emms-play-directory-tree)
;;         (("f" . "Play File") . emms-play-file)
;;         (("i" . "Play Playlist") . emms-play-playlist)
;;         (("t" . "Add Directory Tree") . emms-add-directory-tree)
;;         (("c" . "Toggle Repeat Track") . emms-toggle-repeat-track)
;;         (("w" . "Toggle Repeat Playlist") . emms-toggle-repeat-playlist)
;;         (("u" . "Play Now") . emms-play-now)
;;         (("z" . "Show") . emms-show)
;;         (("s" . "Emms Streams") . emms-streams)
;;         (("b" . "Emms Browser") . emms-browser)))
;;
;; (defun one-key-menu-emms ()
;;   "`One-Key' menu for EMMS."
;;   (interactive)
;;   (one-key-menu "EMMS" one-key-menu-emms-list t))
;;
;; Bind any you like keystroke with function `one-key-menu-emms'.
;; Like me,
;;
;;      (global-set-key (kbd "C-c p") 'one-key-menu-emms)
;;
;; When type "C-c p" will popup window and list keystroke menu.
;; Then you just type special keystroke that list in menu,
;; you will execute corresponding command.
;;
;; That's all.
;;
;; And now you don't need remember so many keystrokes, just remember
;; TOP keystroke is enough.
;;
;; * Advanced use:
;;
;; ** The format of menu list:
;;
;; (("KEYSTROKE" . "DESCRIBE") . COMMAND)
;;
;; Example:
;;
;; (defvar example-menu-alist
;;      '(
;;        (("Keystroke-A" . "Describe-A") . Command-A)
;;        (("Keystroke-B" . "Describe-B") . Command-B)
;;        (("Keystroke-C" . "Describe-C") . Command-C)
;;        ))
;;
;; Make sure COMMAND is `interactive', otherwise will
;; throw error.
;;
;; ** The format of menu function:
;;
;; (one-key-menu "MENU-NAME" MENU-ALIST)
;;
;; Example:
;;
;; (defun example-menu ()
;;   (interactive)
;;   (one-key-menu "example" example-menu-alist)
;;
;; ** The argument of function `one-key-menu':
;;
;; `title' is the title of menu, any string you like.
;; `info-alist' is a special list that contain KEY, DESCRIBE
;;      and COMMAND. see above describe about `example-menu-alist'.
;; `miss-match-exit-p' is mean popup window will exit when you
;;      type a KEY that can't match in menu.
;; `recursion-p' is whether recursion execute `one-key-menu' self
;;      when no KEY match in menu.
;; `protect-function' is a protect function call last in `one-key-menu',
;;      make sure this function is a `interactive' function.
;; `alternate-function' is alternate function execute at last.
;;

;;; Installation:
;;
;; Put one-key.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'one-key)
;;
;; Because this library use special implement method,
;; can occur `max-lisp-eval-depth' or `max-specpdl-size' error.
;;
;; So i think setup above two variables larger
;; will minish probability that error occur.
;;
;; Example I set below:
;;
;; (setq max-lisp-eval-depth 10000)
;; (setq max-specpdl-size 10000)
;;

;;; Customize:
;;
;; `one-key-popup-window' whether popup window when first time run
;;      `one-key-menu', default is `t'.
;; `one-key-buffer-name' the buffer name of popup menu.
;; `one-key-help-window-max-height' the maximal height use in popup window.
;;
;; All above can customize easy through:
;;      M-x customize-group RET one-key RET
;;

;;; Change log:
;;
;; 2009/01/15
;;      * Fix bug of `one-key-menu'.
;;      * Add recursion execute support for `one-key-menu'.*
;;        Thanks "rubikitch" patched for this! ;)
;;
;; 2009/01/04
;;      * Add `alternate-function' argument with function `one-key-menu'.
;;
;; 2008/12/22
;;      * First released.
;;

;;; Acknowledgements:
;;
;;      rubikitch <rubikitch@ruby-lang.org>
;;              For patch of recursion execute `one-key-menu'.
;;

;;; TODO
;;
;;
;;

;;; Require


;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Customize ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defgroup one-key nil
  "One key."
  :group 'editing)

(defcustom one-key-popup-window t
  "Whether popup window when first time run `one-key-menu'."
  :type 'boolean
  :group 'one-key)

(defcustom one-key-buffer-name "*One-Key*"
  "The buffer name of popup help window."
  :type 'string
  :group 'one-key)

(defcustom one-key-help-window-max-height nil
  "The max height of popup help window."
  :type 'int
  :set (lambda (symbol value)
         (set symbol value)
         (unless value
           (set symbol (/ (frame-height) 2))))
  :group 'one-key)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Faces ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defface one-key-title
  '((t (:foreground "Gold")))
  "Face for highlighting title."
  :group 'one-key)

(defface one-key-keystroke
  '((t (:foreground "DarkRed")))
  "Face for highlighting keystroke."
  :group 'one-key)

(defface one-key-prompt
  '((t (:foreground "khaki3")))
  "Face for highlighting prompt."
  :group 'one-key)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variable ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar one-key-help-window-configuration nil
  "The window configuration that record
current window configuration before popup help window.")

(defvar one-key-menu-call-first-time t
  "The first time call function `one-key-menu'.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun one-key-highlight (msg msg-regexp msg-face)
  "Highlight special `MSG' with regular expression `MSG-REGEXP'.
Will highlight this `MSG' with face `MSG-FACE'."
  (with-temp-buffer
    (insert msg)
    (goto-char (point-min))
    (while (re-search-forward msg-regexp nil t)
      (add-text-properties (match-beginning 0)
                           (match-end 0)
                           msg-face))
    (buffer-string)))

(defun one-key-highlight-prompt (prompt)
  "Highlight prompt information."
  (let ((msg (format "The keystroke menu of <%s> type '?' for help." prompt)))
    (message (one-key-highlight msg
                                " \\(<[^<>]*>\\|'[^']*'\\) "
                                '(face one-key-prompt)))))

(defun one-key-highlight-help (title keystroke)
  "Highlight keystroke help information."
  (setq title (one-key-highlight (format "Here is a list of <%s> keystrokes. Type '?' for hide. Type 'q' for exit.\n\n" title)
                                 "\\(<[^<>]*>\\|'[^']*'\\)"
                                 '(face one-key-title)))
  (setq keystroke (one-key-highlight keystroke
                                     "\\[\\([^\\[\\]\\)*\\]"
                                     '(face one-key-keystroke)))
  (concat title keystroke))

(defun one-key-menu (title
                     info-alist
                     &optional
                     miss-match-exit-p
                     recursion-p
                     protect-function
                     alternate-function)
  "One key menu.
`TITLE' is the title of men, any string can use.
`INFO-ALIST' is a special alist that contain KEY, DESCRIBE and COMMAND.
`MISS-MATCH-EXIT-P' whether hide popup help window when keystroke can't match in menu.
`RECURSION-P' whether recursion execute self when keystroke can't match in menu.
`PROTECT-FUNCITN' the protect function that call in `unwind-protect'.
`ALTERNATE-FUNCTION' the alternate-function execute at last."
  (let ((self (function
               (lambda ()
                 (one-key-menu title info-alist miss-match-exit-p recursion-p protect-function alternate-function)))))
    ;; Popup help window when first time call
    ;; and option `one-key-popup-window' is `non-nil'.
    (when one-key-menu-call-first-time
      (setq one-key-menu-call-first-time nil)
      (if one-key-popup-window
          (one-key-help-window-toggle title info-alist)))
    ;; Execute.
    (unwind-protect
        (let ((key (read-key-sequence (one-key-highlight-prompt title)))
              match-key
              key-match-p)
          (cond ((one-key-match-keystroke key "q")
                 (keyboard-quit))       ;quit
                ((one-key-match-keystroke key "?")
                 ;; toggle help window
                 (one-key-help-window-toggle title info-alist)
                 (funcall self))
                ((one-key-match-keystroke key "C-n")
                 ;; scroll up one line
                 (one-key-help-window-scroll-up-line)
                 (funcall self))
                ((one-key-match-keystroke key "C-p")
                 ;; scroll down one line
                 (one-key-help-window-scroll-down-line)
                 (funcall self))
                ((one-key-match-keystroke key "C-j")
                 ;; scroll up one screen
                 (one-key-help-window-scroll-up)
                 (funcall self))
                ((one-key-match-keystroke key "C-k")
                 ;; scroll down one screen
                 (one-key-help-window-scroll-down)
                 (funcall self))
                (t
                 ;; Close help window first.
                 (one-key-help-window-close)
                 ;; Scan user keystroke list.
                 (catch 'match
                   (dolist (element info-alist)
                     (setq match-key (caar element))
                     ;; Call function when match keystroke.
                     (when (one-key-match-keystroke key match-key)
                       (setq key-match-p t)
                       ;; Set `one-key-menu-call-first-time' with "t" for recursion execute.
                       (setq one-key-menu-call-first-time t)
                       ;; Execute.
                       (call-interactively (cdr element))
                       ;; Set `one-key-menu-call-first-time' with "nil".
                       (setq one-key-menu-call-first-time nil)
                       (throw 'match (format "Match %s keystroke" (caar element))))))
                 ;; Quit when keystroke not match
                 ;; and argument `miss-match-exit-p' is `non-nil'.
                 (if (and miss-match-exit-p
                          (not key-match-p))
                     (keyboard-quit))
                 ;; Execute alternate function.
                 (if alternate-function
                     (call-interactively alternate-function))
                 ;; Recursion execute when argument
                 ;; `recursion-p' is `non-nil'.
                 (if recursion-p
                     (funcall self)))))
      ;; Restore value of `one-key-call-first-time'.
      (setq one-key-menu-call-first-time t)
      ;; Quit `one-key' menu.
      (one-key-menu-quit)
      ;; Run protect function
      ;; when `protect-function' is valid function.
      (if (and protect-function
               (functionp protect-function))
          (call-interactively protect-function)))))

(defun one-key-match-keystroke (key match-key)
  "Return `non-nil' if `KEY' match `MATCH-KEY'.
Otherwise, return `nil'."
  (cond ((stringp match-key) (setq match-key (read-kbd-macro match-key)))
        ((vectorp match-key) nil)
        (t (signal 'wrong-type-argument (list 'array match-key))))
  (equal key match-key))

(defun one-key-menu-quit ()
  "Quit `one-key' menu."
  (one-key-help-window-close)
  (message "Quit `one-key' menu."))

(defun one-key-help-window-exist-p ()
  "Return `non-nil' if `one-key' help window exist.
Otherwise, return `nil'."
  (and (get-buffer one-key-buffer-name)
       (window-live-p (get-buffer-window (get-buffer one-key-buffer-name)))))

(defun one-key-help-window-toggle (title info-alist)
  "Toggle the help window."
  (if (one-key-help-window-exist-p)
      ;; Close help window.
      (one-key-help-window-close)
    ;; Open help window.
    (one-key-help-window-open title info-alist)))

(defun one-key-help-window-open (title info-alist)
  "Open the help window."
  ;; Save current window configuration.
  (or one-key-help-window-configuration
      (setq one-key-help-window-configuration (current-window-configuration)))
  ;; Generate buffer information.
  (unless (get-buffer one-key-buffer-name)
    (with-current-buffer (get-buffer-create one-key-buffer-name)
      (goto-char (point-min))
      (save-excursion
        (insert (one-key-highlight-help
                 title
                 (one-key-help-format info-alist))))))
  ;; Pop `one-key' buffer.
  (pop-to-buffer one-key-buffer-name)
  (set-buffer one-key-buffer-name)
  ;; Adjust height of help window
  ;; to display buffer's contents exactly.
  (fit-window-to-buffer nil one-key-help-window-max-height))

(defun one-key-help-window-close ()
  "Close the help window."
  ;; Kill help buffer.
  (when (bufferp (get-buffer one-key-buffer-name))
    (kill-buffer one-key-buffer-name))
  ;; Restore window layout if
  ;; `one-key-help-window-configuration' is valid value.
  (when (and one-key-help-window-configuration
             (boundp 'one-key-help-window-configuration))
    (set-window-configuration one-key-help-window-configuration)
    (setq one-key-help-window-configuration nil)))

(defun one-key-help-window-scroll-up ()
  "Scroll up one screen `one-key' help window."
  (if (one-key-help-window-exist-p)
      (ignore-errors
        (with-current-buffer one-key-buffer-name
          (scroll-up)))))

(defun one-key-help-window-scroll-down ()
  "Scroll down one screen `one-key' help window."
  (if (one-key-help-window-exist-p)
      (ignore-errors
        (with-current-buffer one-key-buffer-name
          (scroll-down)))))

(defun one-key-help-window-scroll-up-line ()
  "Scroll up one line `one-key' help window."
  (if (one-key-help-window-exist-p)
      (ignore-errors
        (with-current-buffer one-key-buffer-name
          (scroll-up 1)))))

(defun one-key-help-window-scroll-down-line ()
  "Scroll down one line `one-key' help window."
  (if (one-key-help-window-exist-p)
      (ignore-errors
        (with-current-buffer one-key-buffer-name
          (scroll-down 1)))))

(defun one-key-help-format (info-alist)
  "Format `one-key' help information."
  (let ((keystroke-msg "")
        (max-length 0)
        (current-length 0)
        (counter 0))
    (dolist (element info-alist)
      (setq current-length (+ (length (caar element)) (length (cdar element))))
      (if (> current-length max-length)
          (setq max-length current-length)))
    (dolist (element info-alist)
      (incf counter)
      (setq keystroke-msg (concat keystroke-msg (format "[%s] %s " (caar element) (cdar element))))
      (setq current-length (+ (length (caar element)) (length (cdar element))))
      (cond ((equal 0 (% counter 3))
             ;; Add newline per 3 item.
             (setq keystroke-msg (concat keystroke-msg "\n")))
            (t
             ;; Fill space to align help information.
             (setq keystroke-msg (concat keystroke-msg (one-key-fill-space (- max-length current-length)))))))
    keystroke-msg))

(defun one-key-fill-space (num)
  "Return `num' SPACE."
  (let ((str ""))
    (while (> num 0)
      (setq str (concat str " "))
      (decf num))
    str))

(defun add-to-alist (alist-var elt-cons &optional no-replace)
  "Add to the value of ALIST-VAR an element ELT-CONS if it isn't there yet.
If an element with the same car as the car of ELT-CONS is already present,
replace it with ELT-CONS unless NO-REPLACE is non-nil; if a matching
element is not already present, add ELT-CONS to the front of the alist.
The test for presence of the car of ELT-CONS is done with `equal'."
  (let ((existing-element (assoc (car elt-cons) (symbol-value alist-var))))
    (if existing-element
        (or no-replace
            (rplacd existing-element (cdr elt-cons)))
      (set alist-var (cons elt-cons (symbol-value alist-var)))))
  (symbol-value alist-var))

(provide 'one-key)

;;; one-key.el ends here

;;; LocalWords:  emms specpdl minish DarkRed msg FUNCITN num str decf elt
