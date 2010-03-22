#!/usr/bin/env ruby
=begin
= gnuclientを便利に使おう
== 概要
gnuclientを便利に使うためのラッパーを提供する。
gnuclientとはすでに起動しているemacsを使って外部からファイル編集命令をだしたり、elispを実行させるためのプログラム。
当然.emacsに
  (gnuserv-start)
の一行を加えてgnuservを立ち上げる必要がある。

* 標準入力をgnuclientに送る。これでemacsをページャとして利用。
* screenと共に使っているとき、
  * emacsのwindowへ飛ばす。
  * emacsでgnuserv-editしたとき(すなわち、サーバでの編集終了)に元のwindowへ戻る。

== 必要なもの
* ((<GNU screen|URL:http://www.gnu.org/software/screen/>)) 3.9.9以上
* ((<gnuserv|URL:ftp://ftp.wellfleet.com/netman/psmith/emacs/gnuserv-2.1alpha.tar.gz>))

== Emacs側での設定
以下のフォームを.emacsに加える。

\C-c\C-cでバッファを保存して編集を終了するようにした。
一時的な編集なのでわざわざ確認をするまでもない。

また\C-x\C-cでも編集を終了するようにしている。
デフォルトでは\C-x#になっている。
デフォルトでemacsの終了に割り当てられているが、実際につこてみればここに割り当てる意味がわかってくるだろう（笑）。
((-そのときemacsはM-x save-buffers-kill-emacsで終了する。-))

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

#$EmacsWindow = "emacs"              # Emacsを起動しているwindowの番号or名前
$EmacsWindow = "0"              # Emacsを起動しているwindowの番号or名前
$screen = "/usr/bin/screen"
$gnuclient = "/usr/bin/gnuclient"
$window_no_file = "#{ENV['HOME']}/.screen-gnuclient"

# screen管轄である
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
