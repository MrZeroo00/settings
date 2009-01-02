#!/usr/bin/env ruby
=begin
= gnuclient�������˻Ȥ���
== ����
gnuclient�������˻Ȥ�����Υ�åѡ����󶡤��롣
gnuclient�ȤϤ��Ǥ˵�ư���Ƥ���emacs��ȤäƳ�������ե������Խ�̿���������ꡢelisp��¹Ԥ����뤿��Υץ���ࡣ
����.emacs��
  (gnuserv-start)
�ΰ�Ԥ�ä���gnuserv��Ω���夲��ɬ�פ����롣

* ɸ�����Ϥ�gnuclient�����롣�����emacs��ڡ�����Ȥ������ѡ�
* screen�ȶ��˻ȤäƤ���Ȥ���
  * emacs��window�����Ф���
  * emacs��gnuserv-edit�����Ȥ�(���ʤ���������ФǤ��Խ���λ)�˸���window����롣

== ɬ�פʤ��
* ((<GNU screen|URL:http://www.gnu.org/software/screen/>)) 3.9.9�ʾ�
* ((<gnuserv|URL:ftp://ftp.wellfleet.com/netman/psmith/emacs/gnuserv-2.1alpha.tar.gz>))

== Emacs¦�Ǥ�����
�ʲ��Υե������.emacs�˲ä��롣

\C-c\C-c�ǥХåե�����¸�����Խ���λ����褦�ˤ�����
���Ū���Խ��ʤΤǤ虜�虜��ǧ�򤹤�ޤǤ�ʤ���

�ޤ�\C-x\C-c�Ǥ��Խ���λ����褦�ˤ��Ƥ��롣
�ǥե���ȤǤ�\C-x#�ˤʤäƤ��롣
�ǥե���Ȥ�emacs�ν�λ�˳�����Ƥ��Ƥ��뤬���ºݤˤĤ��Ƥߤ�Ф����˳�����Ƥ��̣���狼�äƤ�������ʾСˡ�
((-���ΤȤ�emacs��M-x save-buffers-kill-emacs�ǽ�λ���롣-))

  (setq screen-command "/usr/bin/screen")
  (setq gnuserv-winconf nil)
  (defun gnuserv-edit-finish ()
    (interactive)
    (and (buffer-modified-p)
         (y-or-n-p (concat "Save file " (buffer-file-name) "?" ))
         (save-buffer))
    (condition-case nil
        (gnuserv-edit)
      (error (if buffer-read-only
                 (kill-buffer (current-buffer)))
             (delete-frame)
             nil))
    (set-window-configuration gnuserv-winconf)
    (with-temp-buffer
      (insert-file-contents "~/.screen-gnuclient")
      (unless (zerop (buffer-size))
        (call-process screen-command nil nil nil "-X" "select" (buffer-string)))))

  (defun finish-buffer ()
    (interactive)
    (if (gnuserv-buffer-p (current-buffer))
        (gnuserv-edit-finish)
      (when (buffer-file-name)
        (and (buffer-modified-p)
             (y-or-n-p (concat "Save file " (buffer-file-name) "?" ))
             (save-buffer)))
      (kill-buffer (current-buffer))))

  (easy-mmode-define-minor-mode
   gnuserv-edit-mode "" nil ""
   '(("\C-c\C-c" . (lambda ()
                     (interactive)
                     (save-buffer)
                     (finish-buffer)))))

  (defun gnuserv-find-file (file)
    (interactive)
    (setq gnuserv-winconf (current-window-configuration))
    (find-file file)
    (gnuserv-edit-mode t))

  (setq gnuserv-find-file-function 'gnuserv-find-file)
  (define-key ctl-x-map "\C-c" 'gnuserv-edit-finish)

=end
#' font-lock hack

#$EmacsWindow = "emacs"              # Emacs��ư���Ƥ���window���ֹ�or̾��
$EmacsWindow = "0"              # Emacs��ư���Ƥ���window���ֹ�or̾��
$screen = "/usr/bin/screen"
$gnuclient = "/usr/bin/gnuclient"
$window_no_file = "#{ENV['HOME']}/.screen-gnuclient"

# screen�ɳ�Ǥ���
def screen?
  ENV['TERM'] =~ 'screen'
end


def jump_to_emacs
  unless $EmacsWindow == ENV['WINDOW']
    system $screen, "-X", "select", $EmacsWindow
  end
end


def edit
  if screen?
    jump_to_emacs
  end
  exec $gnuclient, *ARGV
end


def view_stdin
  require 'tempfile'
  temp = Tempfile.new "gnuclientrbtmp"
  temp.write $stdin.read
  temp.close
  
  if screen?
    jump_to_emacs
  end
#  system $gnuclient, "-v", "-q", temp.path
  system $gnuclient, temp.path
end


def main
  begin
    open( $window_no_file, "w" ) do |f|
      f.write ENV['WINDOW']
    end

    case ARGV.length
    when 0
      view_stdin
    else
      edit
    end

  ensure
    File::unlink $window_no_file if File::exist? $window_no_file
  end

end

main
