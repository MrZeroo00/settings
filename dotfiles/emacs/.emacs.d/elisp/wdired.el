<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: wdired.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=wdired.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: wdired.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=wdired.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for wdired.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=wdired.el" /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/%e3%82%b5%e3%82%a4%e3%83%88%e3%83%9e%e3%83%83%e3%83%97"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/%e3%82%b5%e3%82%a4%e3%83%88%e3%83%9e%e3%83%83%e3%83%97">サイトマップ</a> <a class="local" href="http://www.emacswiki.org/emacs/%e6%9b%b4%e6%96%b0%e5%b1%a5%e6%ad%b4">更新履歴</a> <a class="local" href="http://www.emacswiki.org/emacs/%e3%83%8b%e3%83%a5%e3%83%bc%e3%82%b9">ニュース</a> <a class="local" href="http://www.emacswiki.org/emacs/%ef%bc%a5%ef%bd%8c%ef%bd%89%ef%bd%93%ef%bd%90%e3%82%bb%e3%82%af%e3%82%b7%e3%83%a7%e3%83%b3">Ｅｌｉｓｐセクション</a> <a class="local" href="http://www.emacswiki.org/emacs/%e5%88%a9%e7%94%a8%e6%89%8b%e5%bc%95">利用手引</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<h1><a href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&q=wdired.el">wdired.el</a></h1></div><div class="wrapper"><div class="content browse"><p><p><a href="http://www.emacswiki.org/cgi-bin/wiki/download/wdired.el">Download</a></p><pre class="source"><pre class="code"><span class="linecomment">;;; wdired.el --- Rename files editing their names in dired buffers</span>

<span class="linecomment">;; Copyright (C) 2001 Juan Le�n Lahoz Garc�a</span>

<span class="linecomment">;; Filename: wdired.el</span>
<span class="linecomment">;; Author: Juan Le�n Lahoz Garc�a &lt;juan-leon.lahoz@tecsidel.es&gt;</span>
<span class="linecomment">;; Version: 1.9.2pre3</span>
<span class="linecomment">;; Keywords: dired, environment, files, renaming</span>

<span class="linecomment">;; wdired.el is free software</span>

<span class="linecomment">;; This program is free software; you can redistribute it and/or</span>
<span class="linecomment">;; modify it under the terms of the GNU General Public License as</span>
<span class="linecomment">;; published by the Free Software Foundation; either version 2, or (at</span>
<span class="linecomment">;; your option) any later version.</span>

<span class="linecomment">;; This program is distributed in the hope that it will be useful, but</span>
<span class="linecomment">;; WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU</span>
<span class="linecomment">;; General Public License for more details.</span>

<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with GNU Emacs; see the file COPYING.  If not, write to the</span>
<span class="linecomment">;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,</span>
<span class="linecomment">;; Boston, MA 02111-1307, USA.</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; wdired.el (the "w" is for writable) provides an alternative way of</span>
<span class="linecomment">;; renaming files.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Have you ever wished to use C-x r t (string-rectangle), M-%</span>
<span class="linecomment">;; (query-replace), M-c (capitalize-word), etc. to change the name of</span>
<span class="linecomment">;; the files in a "dired" buffer? Now you can do this. All the power</span>
<span class="linecomment">;; of emacs commands are available to renaming files!</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This package provides a function that makes the filenames of a a</span>
<span class="linecomment">;; dired buffer editable, by changing the buffer mode (which inhibits</span>
<span class="linecomment">;; all of the commands of dired mode). Here you can edit the names of</span>
<span class="linecomment">;; one or more files and directories, and when you press C-c C-c, the</span>
<span class="linecomment">;; renaming takes effect and you are back to dired mode.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Another things you can do with wdired:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - To move files to another directory (by typing their path,</span>
<span class="linecomment">;;   absolute or relative, as a part of the new filename).</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - To change the target of symbolic links.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - To change the permission bits of the filenames (in systems with a</span>
<span class="linecomment">;;   working unix-alike `dired-chmod-program'). See and customize the</span>
<span class="linecomment">;;   variable `wdired-allow-to-change-permissions'. To change a single</span>
<span class="linecomment">;;   char (toggling between its two more usual values) you can press</span>
<span class="linecomment">;;   the space bar over it or left-click the mouse. To set any char to</span>
<span class="linecomment">;;   an specific value (this includes the SUID, SGID and STI bits) you</span>
<span class="linecomment">;;   can use the key labeled as the letter you want. Please note that</span>
<span class="linecomment">;;   permissions of the links cannot be changed in that way, because</span>
<span class="linecomment">;;   the change would affect to their targets, and this would not be</span>
<span class="linecomment">;;   WYSIWYG :-).</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - To mark files for deletion, by deleting their whole filename.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; I do not have a URL to hang wdired, but you can use the one below</span>
<span class="linecomment">;; to find the latest version:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; http://groups.google.com/groups?as_ugroup=gnu.emacs.sources&as_q=wdired</span>

<span class="linecomment">;;; Installation:</span>

<span class="linecomment">;; Add this file (byte-compiling it is recommended) to your load-path.</span>
<span class="linecomment">;; Then add one of these set of lines (or similar ones) to your config:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This is the easy way:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; (require 'wdired)</span>
<span class="linecomment">;; (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This is recommended way for faster emacs startup time and lower</span>
<span class="linecomment">;; memory consumption, but remind to add these lines before dired.el</span>
<span class="linecomment">;; gets loaded (i.e., near the beginning of your .emacs file):</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; (autoload 'wdired-change-to-wdired-mode "wdired")</span>
<span class="linecomment">;; (add-hook 'dired-load-hook</span>
<span class="linecomment">;;           '(lambda ()</span>
<span class="linecomment">;;              (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)</span>
<span class="linecomment">;;              (define-key dired-mode-map</span>
<span class="linecomment">;;                [menu-bar immediate wdired-change-to-wdired-mode]</span>
<span class="linecomment">;;                '("Edit File Names" . wdired-change-to-wdired-mode))))</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Type "M-x customize-group RET wdired" if you want make changes to</span>
<span class="linecomment">;; the default behavior.</span>

<span class="linecomment">;;; Usage:</span>

<span class="linecomment">;; Then, you can start editing the names of the files by typing "r"</span>
<span class="linecomment">;; (or whatever key you choose, or M-x wdired-change-to-wdired-mode).</span>
<span class="linecomment">;; Use C-c C-c when finished or C-c C-k to abort. You can use also the</span>
<span class="linecomment">;; menu options: in dired mode, "Edit File Names" under "Immediate".</span>
<span class="linecomment">;; While editing the names, a new submenu "WDired" is available at top</span>
<span class="linecomment">;; level. You can customize the behavior of this package from this</span>
<span class="linecomment">;; menu.</span>

<span class="linecomment">;;; Change Log:</span>

<span class="linecomment">;; From 1.91 to 1.9.2</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Ren� Kyllingstad &lt;kyllingstad at users dot sourceforge dot net&gt;</span>
<span class="linecomment">;;   added support for XEmacs. Reported to work under XEmacs 21.4.6.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Small fix to make WDired work with XEmacs 21.1. Thanks to Uwe</span>
<span class="linecomment">;;   Brauer</span>

<span class="linecomment">;; From 1.9 to 1.91</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Fixed a bug (introduced in 1.9) so now files can be marked for</span>
<span class="linecomment">;;   deletion again, by deleting their whole filename.</span>

<span class="linecomment">;; From 1.8 to 1.9</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Another alternative way of editing permissions allowed, see</span>
<span class="linecomment">;;   `wdired-allow-to-change-permissions' for details.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Now wdired doesn't rely on regexp so much. As a consequence of</span>
<span class="linecomment">;;   this, you can add newlines to filenames and symlinks targets</span>
<span class="linecomment">;;   (although this is not very usual, IMHO). Please note that dired</span>
<span class="linecomment">;;   (at least in Emacs 21.1 and previous) does not work very well</span>
<span class="linecomment">;;   with filenames with newlines in them, so RET is deactivated in</span>
<span class="linecomment">;;   wdired mode. But you can activate it if you want.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Now `upcase-word' `capitalize-word' and `downcase-word' are not</span>
<span class="linecomment">;;   advised to work better with wdired mode, but the keys bound to</span>
<span class="linecomment">;;   them use wdired versions of those commands.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Now "undo" actions are not inherited from wdired mode when</span>
<span class="linecomment">;;   changing to dired mode.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Code and documentation cleanups.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Fixed a bug that was making wdired to fail on users with</span>
<span class="linecomment">;;   `dired-backup-overwrite' set to t.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - C-c C-[ now abort changes.</span>

<span class="linecomment">;; From 1.7 to 1.8</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Now permission (access-control) bits of the files can be changed.</span>
<span class="linecomment">;;   Please see the commentary section and the custom variable</span>
<span class="linecomment">;;   `wdired-allow-to-change-permissions' for details.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; - Added another possible value for the variable</span>
<span class="linecomment">;;   `wdired-always-move-to-filename-beginning', useful to change</span>
<span class="linecomment">;;   permission bits of several files without the cursor jumping to</span>
<span class="linecomment">;;   filenames when changing lines.</span>

<span class="linecomment">;; From 0.1 to 1.7</span>

<span class="linecomment">;; - I've moved the list of changes to another file, because it was</span>
<span class="linecomment">;;   huge. Ask me for it or search older versions in google.</span>

<span class="linecomment">;;; TODO:</span>

<span class="linecomment">;; - Make it to work in XEmacs. Any volunteer?</span>

<span class="linecomment">;;; Code:</span>

(eval-when-compile
  (require 'advice)
  (defvar make-symbolic-link) <span class="linecomment">;Avoid a compilation warning in NTEmacs</span>
  (defvar dired-backup-overwrite) <span class="linecomment">; Only in emacs 20.x this is a custom var</span>
  (set (make-local-variable 'byte-compile-dynamic) t))

(eval-and-compile
  (require 'dired)
  (autoload 'dired-do-create-files-regexp "<span class="quote">dired-aux</span>")
  (autoload 'dired-call-process "<span class="quote">dired-aux</span>"))

(defgroup wdired nil
  "<span class="quote">Mode to rename files by editing their names in dired buffers.</span>"
:group 'dired)

(defcustom wdired-use-interactive-rename nil
  "<span class="quote">*If t, confirmation is required before actually rename the files.
Confirmation is required also for overwriting files.  If nil, no
confirmation is required for change the file names, and the variable
`wdired-is-ok-overwrite' is used to see if it is ok to overwrite files
without asking.</span>"
:type 'boolean
  :group 'wdired)

(defcustom wdired-is-ok-overwrite nil
  "<span class="quote">*If non-nil the renames can overwrite files without asking.
This variable is used only if `wdired-use-interactive-rename' is nil.</span>"
:type 'boolean
  :group 'wdired)

(defcustom wdired-always-move-to-filename-beginning nil
  "<span class="quote">*If t the \</span>"up\"<span class="quote"> and \</span>"down\"<span class="quote"> movement is done as in dired mode.
That is, always move the point to the beginning of the filename at line.

If `sometimes, only move to the beginning of filename if the point is
before it, and `track-eol' is honored.  This behavior is very handy
when editing several filenames.

If nil, \</span>"up\"<span class="quote"> and \</span>"down\"<span class="quote"> movement is done as in any other buffer.</span>"
:type '(choice (const :tag "<span class="quote">As in any other mode</span>" nil)
(const :tag "<span class="quote">Smart cursor placement</span>" sometimes)
		 (other :tag "<span class="quote">As in dired mode</span>" t))
:group 'wdired)

(defcustom wdired-advise-functions t
  "<span class="quote">*If t some editing commands are advised when wdired is loaded.
The advice only has effect in wdired mode.  These commands are
`query-replace' `query-replace-regexp' `replace-string', and the
advice makes them to ignore read-only regions, so no attempts to
modify these regions are done by them, and so they don't end
prematurely.

Setting this to nil does not unadvise the functions, if they are
already advised, but new Emacs will not advise them</span>"
:type 'boolean
  :group 'wdired)

(defcustom wdired-allow-to-redirect-links t
  "<span class="quote">*If non-nil, the target of the symbolic links can be changed also.
In systems without symbolic links support, this variable has no effect
at all.</span>"
:type 'boolean
  :group 'wdired)

(defcustom wdired-allow-to-change-permissions nil
  "<span class="quote">*If non-nil, the permissions bits of the files can be changed also.

If t, to change a single bit, put the cursor over it and press the
space bar, or left click over it.  You can also hit the letter you want
to set: if this value is allowed, the character in the buffer will be
changed.  Anyway, the point is advanced one position, so, for example,
you can keep the \</span>"x\"<span class="quote"> key pressed to give execution permissions to
everybody to that file.

If `advanced, the bits are freely editable.  You can use
`string-rectangle', `query-replace', etc.  You can put any value (even
newlines), but if you want your changes to be useful, you better put a
intelligible value.

Anyway, the real change of the permissions is done with the external
program `dired-chmod-program', which must exist.</span>"
:type '(choice (const :tag "<span class="quote">Not allowed</span>" nil)
(const :tag "<span class="quote">Toggle/set bits</span>" t)
                 (other :tag "<span class="quote">Bits freely editable</span>" advanced))
:group 'wdired)


(defvar wdired-running-xemacs (featurep 'xemacs))

(require 'dired)
(if (not wdired-running-xemacs)
    (define-key dired-mode-map [menu-bar immediate
                                         wdired-change-to-wdired-mode]
      '("<span class="quote">Edit File Names</span>" . wdired-change-to-wdired-mode))
  (add-hook 'dired-mode-hook
            (lambda ()
              (add-menu-button
               '("<span class="quote">Do</span>") (vector "<span class="quote">Edit File Names</span>"
                               'wdired-change-to-wdired-mode))) t))

(defvar wdired-mode-map nil)
(unless wdired-mode-map
  (setq wdired-mode-map (make-sparse-keymap))
  (define-key wdired-mode-map "<span class="quote">\C-x\C-s</span>" 'wdired-finish-edit)
  (define-key wdired-mode-map "<span class="quote">\C-c\C-c</span>" 'wdired-finish-edit)
  (define-key wdired-mode-map "<span class="quote">\C-c\C-k</span>" 'wdired-abort-changes)
  (define-key wdired-mode-map "<span class="quote">\C-c\C-[</span>" 'wdired-abort-changes)
  (define-key wdired-mode-map [return]   'wdired-newline)
  (define-key wdired-mode-map "<span class="quote">\C-j</span>"     'wdired-newline)
  (define-key wdired-mode-map "<span class="quote">\C-o</span>"     'wdired-newline)
  (define-key wdired-mode-map [up]       'wdired-previous-line)
  (define-key wdired-mode-map "<span class="quote">\C-p</span>"     'wdired-previous-line)
  (define-key wdired-mode-map [down]     'wdired-next-line)
  (define-key wdired-mode-map "<span class="quote">\C-n</span>"     'wdired-next-line)

  (if wdired-running-xemacs
      (setq wdired-xemacs-menu '("<span class="quote">WDired</span>"
				 ["<span class="quote">Options</span>" wdired-customize]
				 "<span class="quote">---</span>"
				 ["<span class="quote">Abort Changes</span>" wdired-abort-changes]
				 ["<span class="quote">Commit Changes</span>"  wdired-finish-edit]))
    (define-key wdired-mode-map [menu-bar wdired]
      (cons "<span class="quote">WDired</span>" (make-sparse-keymap "<span class="quote">WDired</span>")))
    (define-key wdired-mode-map [menu-bar wdired wdired-customize]
      '("<span class="quote">Options</span>" . wdired-customize))
    (define-key wdired-mode-map [menu-bar wdired dashes]
      '("<span class="quote">--</span>"))
    (define-key wdired-mode-map [menu-bar wdired wdired-abort-changes]
      '("<span class="quote">Abort Changes</span>" . wdired-abort-changes))
    (define-key wdired-mode-map [menu-bar wdired wdired-finish-edit]
      '("<span class="quote">Commit Changes</span>" . wdired-finish-edit)))
  (substitute-key-definition 'upcase-word 'wdired-upcase-word
			     wdired-mode-map global-map)
  (substitute-key-definition 'capitalize-word 'wdired-capitalize-word
			     wdired-mode-map global-map)
  (substitute-key-definition 'downcase-word 'wdired-downcase-word
			     wdired-mode-map global-map))

(defvar wdired-mode-hooks nil
  "<span class="quote">Hooks run when changing to wdired mode.</span>")

(defvar wdired-load-hooks nil
  "<span class="quote">Hooks run after loading wdired code.</span>")

<span class="linecomment">;; Local variables (put here to avoid compilation gripes)</span>
(defvar wdired-col-perm) <span class="linecomment">;; Column where the permission bits start</span>
(defvar wdired-old-content)


<span class="linecomment">;;;xemacs compatibility</span>

(or (fboundp 'buffer-substring-no-properties)
    (fset 'buffer-substring-no-properties 'buffer-substring))

(or (fboundp 'match-string-no-properties)
    (defun match-string-no-properties (number)
      "<span class="quote">Return string of text matched by last search.</span>"
      (buffer-substring-no-properties (match-beginning number)
                                      (match-end number))))


(defun wdired-mode ()
  "<span class="quote">\\&lt;wdired-mode-map&gt;File Names Editing mode.

Press \\[wdired-finish-edit] to make the changes to take effect and
exit.  To abort the edit, use \\[wdired-abort-changes].

In this mode you can edit the names of the files, the target of the
links and the permission bits of the files.  You can `customize-group'
wdired.

Editing things out of the filenames, or adding or deleting lines is
not allowed, because the rest of the buffer is read-only.</span>"
  (interactive)
  (error "<span class="quote">This mode can be enabled only by `wdired-change-to-wdired-mode'</span>"))
(put 'wdired-mode 'mode-class 'special)


<span class="linecomment">;;;###autoload</span>
(defun wdired-change-to-wdired-mode ()
  "<span class="quote">Put a dired buffer in a mode in which filenames are editable.
In this mode the names of the files can be changed, and after
typing C-c C-c the files and directories in disk are renamed.

See `wdired-mode'.</span>"
  (interactive)
  (set (make-local-variable 'wdired-old-content)
       (buffer-substring (point-min) (point-max)))
  (use-local-map wdired-mode-map)
  (if wdired-running-xemacs
      (add-submenu nil wdired-xemacs-menu)
    (menu-bar-mode (or menu-bar-mode -1))) <span class="linecomment">;Force redisplay menu</span>
  (setq buffer-read-only nil)
  (dired-unadvertise default-directory)
  (make-local-hook 'kill-buffer-hook)
  (add-hook 'kill-buffer-hook 'wdired-check-kill-buffer nil t)
  (setq major-mode 'wdired-mode)
  (setq mode-name "<span class="quote">Edit filenames</span>")
  (setq revert-buffer-function 'wdired-revert)
  <span class="linecomment">;; I temp disable undo for performance: since I'm going to clear the</span>
  <span class="linecomment">;; undo list, it can save more than a 9% of time with big</span>
  <span class="linecomment">;; directories because setting properties modify the undo-list.</span>
  (buffer-disable-undo)
  (wdired-preprocess-files)
  (if wdired-allow-to-change-permissions
      (wdired-preprocess-perms))
  (if (and wdired-allow-to-redirect-links (fboundp 'make-symbolic-link))
      (wdired-preprocess-symlinks))
  (buffer-enable-undo) <span class="linecomment">; Performance hack. See above.</span>
  (set-buffer-modified-p nil)
  (setq buffer-undo-list nil)
  (run-hooks wdired-mode-hooks)
  (message "<span class="quote">Press C-c C-c when finished</span>"))


<span class="linecomment">;; Protect the buffer so only the filenames can be changed, and put</span>
<span class="linecomment">;; properties so filenames (old and new) can be easily found.</span>
(defun wdired-preprocess-files ()
  (put-text-property 1 2 'front-sticky t)
  (save-excursion
    (goto-char (point-min))
    (let ((b-protection (point))
	  (dot-dirs (concat (list directory-sep-char) "<span class="quote">\\.\\.?$</span>"))
	  filename)
      (while (not (eobp))
	(setq filename (dired-get-filename nil t))
        (when (and filename (not (string-match dot-dirs filename)))
	  (dired-move-to-filename)
	  (put-text-property (- (point) 2) (1- (point)) 'old-name filename)
	  (put-text-property b-protection (1- (point)) 'read-only t)
	  (setq b-protection (dired-move-to-end-of-filename)))
	  (put-text-property (point) (1+ (point)) 'end-name t)
        (forward-line))
      (put-text-property b-protection (point-max) 'read-only t))))

<span class="linecomment">;; This code is a copy of some dired-get-filename lines.</span>
(defsubst wdired-normalize-filename (file)
    <span class="linecomment">;; Check if ls quoted the names, and unquote them.</span>
    <span class="linecomment">;; Using read to unquote is much faster than substituting</span>
    <span class="linecomment">;; \007 (4 chars) -&gt; ^G  (1 char) etc. in a lisp loop.</span>
  (when (or (not wdired-running-xemacs) (memq ?b dired-internal-switches))
    (setq file
          (read (concat "<span class="quote">\</span>""<span class="quote">
                        (or (dired-string-replace-match
                             </span>"\\([^\\]\\|\\`\\)\"<span class="quote"></span>" file "<span class="quote">\\1\\\\\</span>""<span class="quote"> nil t)
                            file)
                        </span>"\"<span class="quote"></span>"))))
  (and file
       (boundp 'buffer-file-coding-system) buffer-file-coding-system
       (not file-name-coding-system)
       <span class="linecomment">;; default-file-name-coding-system doesn't exist in XEmacs</span>
       (or
        (not (boundp 'default-file-name-coding-system))
        (not default-file-name-coding-system))
       (setq file (encode-coding-string file
                                        buffer-file-coding-system)))
  file)

(defun wdired-get-filename (&optional no-dir old)
  "<span class="quote">Return the filename at line.
Similar to `dired-get-filename' but it doesn't rely on regexps.  It
relies on wdired buffer's properties.  Optional arg NO-DIR with value
non-nil means don't include directory.  Optional arg OLD with value
non-nil means return old filename.</span>"
  (let (beg end file)
    (save-excursion
      (setq end (progn (end-of-line) (point)))
      (beginning-of-line)
      (setq beg (next-single-property-change (point) 'old-name nil end))
      (if (not (eq beg end))
	  (progn
	    (if old
		(setq file (get-text-property beg 'old-name))
	      (setq end (next-single-property-change (1+ beg) 'end-name))
	      (setq file (buffer-substring-no-properties (+ 2 beg) end)))))
      (and file (setq file (wdired-normalize-filename file)))
      (if (or no-dir old)
	  file
	(and file (&gt; (length file) 0)
             (concat (dired-current-directory) file))))))


(defun wdired-change-to-dired-mode ()
  "<span class="quote">Change the mode back to dired.</span>"
  (let ((inhibit-read-only t))
    (remove-text-properties (point-min) (point-max)
			    '(read-only nil local-map nil)))
  (put-text-property 1 2 'front-sticky nil)
  (use-local-map dired-mode-map)
  (if wdired-running-xemacs
      (delete-menu-item '("<span class="quote">WDired</span>"))
    (menu-bar-mode (or menu-bar-mode -1))) <span class="linecomment">;Force redisplay menu</span>
  (setq buffer-read-only t)
  (setq major-mode 'dired-mode)
  (setq mode-name "<span class="quote">Dired</span>")
  (dired-advertise)
  (remove-hook 'kill-buffer-hook 'wdired-check-kill-buffer t)
  (setq revert-buffer-function 'dired-revert))


(defun wdired-abort-changes ()
  "<span class="quote">Abort changes and return to dired mode.</span>"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (insert wdired-old-content))
  (wdired-change-to-dired-mode)
  (set-buffer-modified-p nil)
  (setq buffer-undo-list nil))

(defun wdired-log (log &rest args)
  "<span class="quote">Calls dired-log, with a `BUFFER-NAME' parameter under XEmacs</span>"
  (if wdired-running-xemacs
      (dired-log (buffer-name) log args)
    (dired-log log args)))

(defun wdired-finish-edit ()
  "<span class="quote">Actually rename files based on your editing in the Dired buffer.</span>"
  (interactive)
  (wdired-change-to-dired-mode)
  (let ((overwrite (or wdired-is-ok-overwrite 1))
	(changes nil)
	(files-deleted nil)
	(errors 0)
	file-ori file-new tmp-value)
    (save-excursion
      (if (and wdired-allow-to-redirect-links
	       (fboundp 'make-symbolic-link))
	  (progn
	    (setq tmp-value (wdired-do-symlink-changes))
	    (setq errors (cdr tmp-value))
	    (setq changes (car tmp-value))))
      (if (and wdired-allow-to-change-permissions
	       (boundp 'wdired-col-perm)) <span class="linecomment">; could have been changed</span>
	  (progn
	    (setq tmp-value (wdired-do-perm-changes))
	    (setq errors (+ errors (cdr tmp-value)))
	    (setq changes (or changes (car tmp-value)))))
      (goto-char (point-max))
      (while (not (bobp))
	(setq file-ori (wdired-get-filename nil t))
	(if file-ori
	    (setq file-new (wdired-get-filename)))
	(if (and file-ori (not (equal file-new file-ori)))
	    (progn
	      (setq changes t)
	      (if (not file-new) <span class="linecomment">;empty filename!</span>
		  (setq files-deleted (cons file-ori files-deleted))
		(progn
		  (setq file-new (substitute-in-file-name file-new))
		  (if wdired-use-interactive-rename
		      (wdired-search-and-rename file-ori file-new)
		    (condition-case err
			(let ((dired-backup-overwrite nil))
			  (dired-rename-file file-ori file-new
					     overwrite))
		      (error
		       (setq errors (1+ errors))
		       (wdired-log (concat "<span class="quote">Rename `</span>" file-ori "<span class="quote">' to `</span>"
					  file-new "<span class="quote">' failed:\n%s\n</span>")
				  err))))))))
	(forward-line -1)))
    (if changes
        (revert-buffer) <span class="linecomment">;The "revert" is necessary to re-sort the buffer</span>
      (let ((buffer-read-only nil))
	(remove-text-properties (point-min) (point-max)
				'(old-name nil end-name nil old-link nil
					   end-link nil end-perm nil
					   old-perm nil perm-changed nil))
	(message "<span class="quote">(No changes to be performed)</span>")))
    (if files-deleted
        (wdired-flag-for-deletion files-deleted))
    (if (&gt; errors 0)
	<span class="linecomment">;; XEmacs dired-log-summary takes 3 args</span>
	(if wdired-running-xemacs
	    (dired-log-summary (buffer-name)
                         (format "<span class="quote">%d rename actions failed</span>" errors) nil)
	  (dired-log-summary (format "<span class="quote">%d rename actions failed</span>" errors) nil))))
  (set-buffer-modified-p nil)
  (setq buffer-undo-list nil))

<span class="linecomment">;; Renames a file, searching it in a modified dired buffer, in order</span>
<span class="linecomment">;; to be able to use `dired-do-create-files-regexp' and get its</span>
<span class="linecomment">;; "benefits"</span>
(defun wdired-search-and-rename (filename-ori filename-new)
  (save-excursion
    (goto-char (point-max))
    (forward-line -1)
    (let ((exit-while nil)
	  curr-filename)
      (while (not exit-while)
        (setq curr-filename (wdired-get-filename))
        (if (and curr-filename
                 (equal (substitute-in-file-name curr-filename) filename-new))
            (progn
              (setq exit-while t)
              (let ((inhibit-read-only t))
                (dired-move-to-filename)
                (search-forward (wdired-get-filename t) nil t)
                (replace-match (file-name-nondirectory filename-ori) t t))
              (dired-do-create-files-regexp
               (function dired-rename-file)
               "<span class="quote">Move</span>" 1 "<span class="quote">.*</span>" filename-new nil t))
          (progn
            (forward-line -1)
            (beginning-of-line)
            (setq exit-while (= 1 (point)))))))))

<span class="linecomment">;; marks a list of files for deletion</span>
(defun wdired-flag-for-deletion (filenames-ori)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (if (member (dired-get-filename nil t) filenames-ori)
          (dired-flag-file-deletion 1)
 (forward-line)))))

(defun wdired-customize ()
  "<span class="quote">Customize wdired options.</span>"
  (interactive)
  (customize-apropos "<span class="quote">wdired</span>" 'groups))

(defun wdired-revert (&optional arg noconfirm)
  "<span class="quote">Discard changes in the buffer and update the changes in the disk.</span>"
  (wdired-change-to-dired-mode)
  (revert-buffer)
  (wdired-change-to-wdired-mode))

(defun wdired-check-kill-buffer ()
  (if (and
       (buffer-modified-p)
       (not (y-or-n-p "<span class="quote">Buffer changed. Discard changes and kill buffer? </span>")))
      (error nil)))

(defun wdired-next-line (arg)
  "<span class="quote">Move down lines then position at filename or the current column.
See `wdired-always-move-to-filename-beginning'.  Optional prefix ARG
says how many lines to move; default is one line.</span>"
  (interactive "<span class="quote">p</span>")
  (next-line arg)
  (if (or (eq wdired-always-move-to-filename-beginning t)
	  (and wdired-always-move-to-filename-beginning
	       (&lt; (current-column)
		  (save-excursion (dired-move-to-filename)
				  (current-column)))))
      (dired-move-to-filename)))

(defun wdired-previous-line (arg)
  "<span class="quote">Move up lines then position at filename or the current column.
See `wdired-always-move-to-filename-beginning'.  Optional prefix ARG
says how many lines to move; default is one line.</span>"
  (interactive "<span class="quote">p</span>")
  (previous-line arg)
  (if (or (eq wdired-always-move-to-filename-beginning t)
	  (and wdired-always-move-to-filename-beginning
	       (&lt; (current-column)
		  (save-excursion (dired-move-to-filename)
				  (current-column)))))
      (dired-move-to-filename)))

<span class="linecomment">;; dired doesn't works well with newlines, so ...</span>
(defun wdired-newline ()
  "<span class="quote">Do nothing.</span>"
  (interactive))

<span class="linecomment">;; Put the needed properties to allow the user to change links' targets</span>
(defun wdired-preprocess-symlinks ()
  (let ((inhibit-read-only t))
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
        (if (looking-at dired-re-sym)
            (progn
              (re-search-forward "<span class="quote"> -&gt; \\(.*\\)$</span>")
	      (put-text-property (- (match-beginning 1) 2)
				 (1- (match-beginning 1)) 'old-link
				 (match-string-no-properties 1))
              (put-text-property (match-end 1) (1+ (match-end 1)) 'end-link t)
	      (put-text-property (1- (match-beginning 1))
				 (match-end 1) 'read-only nil)))
        (forward-line)
	(beginning-of-line)))))


(defun wdired-get-previous-link (&optional old move)
  "<span class="quote">Return the next symlink target.
If OLD, return the old target.  If MOVE, move point before it.</span>"
  (let (beg end target)
    (setq beg (previous-single-property-change (point) 'old-link nil))
    (if beg
	(progn
	  (if old
	      (setq target (get-text-property (1- beg) 'old-link))
	    (setq end (next-single-property-change beg 'end-link))
	    (setq target (buffer-substring-no-properties (1+ beg) end)))
	  (if move (goto-char (1- beg)))))
    (and target (wdired-normalize-filename target))))



<span class="linecomment">;; Perform the changes in the target of the changed links.</span>
(defun wdired-do-symlink-changes()
  (let ((changes nil)
	(errors 0)
	link-to-ori link-to-new link-from)
    (goto-char (point-max))
    (while (setq link-to-new (wdired-get-previous-link))
      (setq link-to-ori (wdired-get-previous-link t t))
      (setq link-from (wdired-get-filename nil t))
      (if (not (equal link-to-new link-to-ori))
          (progn
            (setq changes t)
            (if (equal link-to-new "<span class="quote"></span>") <span class="linecomment">;empty filename!</span>
                (setq link-to-new "<span class="quote">/dev/null</span>"))
	    (condition-case err
		(progn
		  (delete-file link-from)
		  (make-symbolic-link
		   (substitute-in-file-name link-to-new) link-from))
		  (error
		   (setq errors (1+ errors))
		   (wdired-log (concat "<span class="quote">Link `</span>" link-from "<span class="quote">' to `</span>"
				       link-to-new "<span class="quote">' failed:\n%s\n</span>")
			       err))))))
    (cons changes errors)))

<span class="linecomment">;; Perform a "case command" skipping read-only words.</span>
(defun wdired-xcase-word (command arg)
  (if (&lt; arg 0)
      (funcall command arg)
    (progn
      (while (&gt; arg 0)
	(condition-case err
	    (progn
	      (funcall command 1)
	      (setq arg (1- arg)))
	  (error
	   (if (not (forward-word 1))
	       (setq arg 0))))))))

(defun wdired-downcase-word (arg)
  "<span class="quote">Wdired version of `downcase-word'.
Like original function but it skips read-only words.</span>"
  (interactive "<span class="quote">p</span>")
  (wdired-xcase-word 'downcase-word arg))

(defun wdired-upcase-word (arg)
  "<span class="quote">Wdired version of `upcase-word'.
Like original function but it skips read-only words.</span>"
  (interactive "<span class="quote">p</span>")
  (wdired-xcase-word 'upcase-word arg))

(defun wdired-capitalize-word (arg)
  "<span class="quote">Wdired version of `capitalize-word'.
Like original function but it skips read-only words.</span>"
  (interactive "<span class="quote">p</span>")
  (wdired-xcase-word 'capitalize-word arg))

<span class="linecomment">;; The following code is related to advice some interactive functions</span>
<span class="linecomment">;; to make some editing commands in wdired mode not to fail trying to</span>
<span class="linecomment">;; change read-only text. Notice that some advises advice and unadvise</span>
<span class="linecomment">;; them-self to another functions: search-forward and</span>
<span class="linecomment">;; re-search-forward. This is to keep these functions advised only</span>
<span class="linecomment">;; when is necessary. Since they are built-in commands used heavily in</span>
<span class="linecomment">;; lots of places, to have it permanently advised would cause some</span>
<span class="linecomment">;; performance loss.</span>


(defun wdired-add-skip-in-replace (command)
  "<span class="quote">Advice COMMAND to skip matches while they have read-only properties.
This is useful to avoid \</span>"read-only\"<span class="quote"> errors in search and replace
commands.  This advice only has effect in wdired mode.</span>"
  (eval
    `(defadvice ,command (around wdired-discard-read-only activate)
       ,(format "<span class="quote">Make %s to work better with wdired,\n%s.</span>"  command
		"<span class="quote">skipping read-only matches when invoked without argument</span>")
       ad-do-it
       (if (eq major-mode 'wdired-mode)
	   (while (and ad-return-value
		       (text-property-any
			(max 1 (1- (match-beginning 0))) (match-end 0)
			'read-only t))
	     ad-do-it))
       ad-return-value)))


(defun wdired-add-replace-advice (command)
  "<span class="quote">Advice COMMAND to skip matches while they have read-only properties.
This is useful to avoid \</span>"read-only\"<span class="quote"> errors in search and replace
commands.  This advice only has effect in wdired mode.</span>"
  (eval
   `(defadvice ,command (around wdired-grok-read-only activate)
       ,(format "<span class="quote">Make %s to work better with wdired,\n%s.</span>"  command
		"<span class="quote">skipping read-only matches when invoked without argument</span>")
       (if (eq major-mode 'wdired-mode)
           (progn
             (wdired-add-skip-in-replace 'search-forward)
             (wdired-add-skip-in-replace 're-search-forward)
             (unwind-protect
                 ad-do-it
               (progn
                 (ad-remove-advice 'search-forward
                                   'around 'wdired-discard-read-only)
                 (ad-remove-advice 're-search-forward
                                   'around 'wdired-discard-read-only)
                 (ad-update 'search-forward)
                 (ad-update 're-search-forward))))
         ad-do-it)
       ad-return-value)))


(if wdired-advise-functions
    (progn
      (mapcar 'wdired-add-replace-advice
              '(query-replace query-replace-regexp replace-string))))


<span class="linecomment">;; The following code deals with changing the access bits (or</span>
<span class="linecomment">;; permissions) of the files.</span>

(defvar wdired-perm-mode-map nil)
(unless wdired-perm-mode-map
  (setq wdired-perm-mode-map (copy-keymap wdired-mode-map))
  (define-key wdired-perm-mode-map "<span class="quote"> </span>" 'wdired-toggle-bit)
  (define-key wdired-perm-mode-map "<span class="quote">r</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">w</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">x</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">-</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">S</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">s</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">T</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">t</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">s</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map "<span class="quote">l</span>" 'wdired-set-bit)
  (define-key wdired-perm-mode-map [down-mouse-1] 'wdired-mouse-toggle-bit))

<span class="linecomment">;; Put a local-map to the permission bits of the files, and store the</span>
<span class="linecomment">;; original name and permissions as a property</span>
(defun wdired-preprocess-perms()
  (let ((inhibit-read-only t)
	filename)
    (set (make-local-variable 'wdired-col-perm) nil)
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
	(if (and (not (looking-at dired-re-sym))
		 (setq filename (wdired-get-filename)))
	    (progn
	      (re-search-forward dired-re-perms)
	      (or wdired-col-perm
		  (setq wdired-col-perm (- (current-column) 9)))
	      (if (eq wdired-allow-to-change-permissions 'advanced)
		  (put-text-property (match-beginning 0) (match-end 0)
				     'read-only nil)
		(put-text-property (1+ (match-beginning 0)) (match-end 0)
				   'local-map wdired-perm-mode-map))
	      (put-text-property (match-end 0) (1+ (match-end 0)) 'end-perm t)
	      (put-text-property (match-beginning 0) (1+ (match-beginning 0))
				 'old-perm (match-string-no-properties 0))))
        (forward-line)
	(beginning-of-line)))))

(defun wdired-perm-allowed-in-pos (char pos)
  (cond
   ((= char ?-)          t)
   ((= char ?r)          (= (% pos 3) 0))
   ((= char ?w)          (= (% pos 3) 1))
   ((= char ?x)          (= (% pos 3) 2))
   ((memq char '(?s ?S)) (memq pos '(2 5)))
   ((memq char '(?t ?T)) (= pos 8))
   ((= char ?l)          (= pos 5))))

(defun wdired-set-bit ()
  "<span class="quote">Set a permission bit character.</span>"
  (interactive)
  (if (wdired-perm-allowed-in-pos last-command-char
                                  (- (current-column) wdired-col-perm))
      (let ((new-bit (char-to-string last-command-char))
            (inhibit-read-only t)
	    (pos-prop (- (point) (- (current-column) wdired-col-perm))))
        (put-text-property 0 1 'local-map wdired-perm-mode-map new-bit)
        (put-text-property 0 1 'read-only t new-bit)
        (insert new-bit)
        (delete-char 1)
	(put-text-property pos-prop (1- pos-prop) 'perm-changed t))
    (forward-char 1)))

(defun wdired-toggle-bit()
  "<span class="quote">Toggle the permission bit at point.</span>"
  (interactive)
  (let ((inhibit-read-only t)
	(new-bit "<span class="quote">-</span>")
	(pos-prop (- (point) (- (current-column) wdired-col-perm))))
    (if (eq (char-after (point)) ?-)
	(setq new-bit
	      (if (= (% (- (current-column) wdired-col-perm) 3) 0) "<span class="quote">r</span>"
		(if (= (% (- (current-column) wdired-col-perm) 3) 1) "<span class="quote">w</span>"
		  "<span class="quote">x</span>"))))
    (put-text-property 0 1 'local-map wdired-perm-mode-map new-bit)
    (put-text-property 0 1 'read-only t new-bit)
    (insert new-bit)
    (delete-char 1)
    (put-text-property pos-prop (1- pos-prop) 'perm-changed t)))

(defun wdired-mouse-toggle-bit (event)
  "<span class="quote">Toggle the permission bit that was left clicked.</span>"
  (interactive "<span class="quote">e</span>")
  (mouse-set-point event)
  (wdired-toggle-bit))

<span class="linecomment">;; Allowed chars for 4000 bit are Ss  in position 3</span>
<span class="linecomment">;; Allowed chars for 2000 bit are Ssl in position 6</span>
<span class="linecomment">;; Allowed chars for 1000 bit are Tt  in position 9</span>
(defun wdired-perms-to-number (perms)
  (let ((nperm 0777))
    (if (= (elt perms 1) ?-) (setq nperm (- nperm 400)))
    (if (= (elt perms 2) ?-) (setq nperm (- nperm 200)))
    (let ((p-bit (elt perms 3)))
      (if (memq p-bit '(?- ?S)) (setq nperm (- nperm 100)))
      (if (memq p-bit '(?s ?S)) (setq nperm (+ nperm 4000))))
    (if (= (elt perms 4) ?-) (setq nperm (- nperm 40)))
    (if (= (elt perms 5) ?-) (setq nperm (- nperm 20)))
    (let ((p-bit (elt perms 6)))
      (if (memq p-bit '(?- ?S ?l)) (setq nperm (- nperm 10)))
      (if (memq p-bit '(?s ?S ?l)) (setq nperm (+ nperm 2000))))
    (if (= (elt perms 7) ?-) (setq nperm (- nperm 4)))
    (if (= (elt perms 8) ?-) (setq nperm (- nperm 2)))
    (let ((p-bit (elt perms 9)))
      (if (memq p-bit '(?- ?T)) (setq nperm (- nperm 1)))
      (if (memq p-bit '(?t ?T)) (setq nperm (+ nperm 1000))))
    nperm))

<span class="linecomment">;; Perform the changes in the permissions of the files that have</span>
<span class="linecomment">;; changed.</span>
(defun wdired-do-perm-changes ()
  (let ((changes nil)
	(errors 0)
	(prop-wanted (if (eq wdired-allow-to-change-permissions 'advanced)
			 'old-perm 'perm-changed))
	filename perms-ori perms-new perm-tmp)
    (goto-char (next-single-property-change (point-min) prop-wanted
					    nil (point-max)))
    (while (not (eobp))
      (setq perms-ori (get-text-property (point) 'old-perm))
      (setq perms-new (buffer-substring-no-properties
		       (point) (next-single-property-change (point) 'end-perm)))
      (if (not (equal perms-ori perms-new))
	  (progn
	    (setq changes t)
	    (setq filename (wdired-get-filename nil t))
	    (if (= (length perms-new) 10)
		(progn
		  (setq perm-tmp
			(int-to-string (wdired-perms-to-number perms-new)))
		  (if (not (equal 0 (dired-call-process dired-chmod-program
				     t perm-tmp filename)))
		      (progn
			(setq errors (1+ errors))
			(wdired-log (concat dired-chmod-program "<span class="quote"> </span>" perm-tmp
					   "<span class="quote"> `</span>" filename "<span class="quote">' failed\n\n</span>")))))
	    (setq errors (1+ errors))
	    (wdired-log (concat "<span class="quote">Cannot parse permission `</span>" perms-new
			       "<span class="quote">' for file `</span>" filename "<span class="quote">'\n\n</span>")))))
      (goto-char (next-single-property-change (1+ (point)) prop-wanted
					      nil (point-max))))
    (cons changes errors)))

(provide 'wdired)
(run-hooks wdired-load-hooks)

<span class="linecomment">;;; wdired.el ends here</span></span></pre></pre></p></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/%e3%82%b5%e3%82%a4%e3%83%88%e3%83%9e%e3%83%83%e3%83%97">サイトマップ</a> <a class="local" href="http://www.emacswiki.org/emacs/%e6%9b%b4%e6%96%b0%e5%b1%a5%e6%ad%b4">更新履歴</a> <a class="local" href="http://www.emacswiki.org/emacs/%e3%83%8b%e3%83%a5%e3%83%bc%e3%82%b9">ニュース</a> <a class="local" href="http://www.emacswiki.org/emacs/%ef%bc%a5%ef%bd%8c%ef%bd%89%ef%bd%93%ef%bd%90%e3%82%bb%e3%82%af%e3%82%b7%e3%83%a7%e3%83%b3">Ｅｌｉｓｐセクション</a> <a class="local" href="http://www.emacswiki.org/emacs/%e5%88%a9%e7%94%a8%e6%89%8b%e5%bc%95">利用手引</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=wdired.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=wdired.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=wdired.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=wdired.el">Administration</a></span><span class="time"><br /> Last edited 2005-10-13 17:56 UTC by <a class="author" title="from 217-162-112-104.dclient.hispeed.ch" href="http://www.emacswiki.org/emacs/AlexSchroeder">AlexSchroeder</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=wdired.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
