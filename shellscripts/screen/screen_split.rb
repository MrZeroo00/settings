#!/usr/bin/env ruby
=begin
= screensplit

== 概要
GNU Screenにて画面分割/分割解除(トグル)を行う。
状態は ~/.screensplit-split ファイルの存在であらわす。

== スクリーンショット
((<1画面|URL:1.jpg>)) ←→ ((<2画面|URL:2.jpg>))

== 使い方
.screenrcに
  bind '-' exec screensplit.rb
を加える。
そして、window_nameとresize_widthを設定する。
これで 「(screenのエスケープ)-」で画面分割状態を切り換えられる。

== 履歴
: [2002/03/30]
    screen 3.9.11対応。
=end

#window_name = "bel"             # 下のwindowの名前
window_name = ARGV[0]           # 下のwindowの名前
resize_width = "+10"            # (上のwindowの大きさ) - (画面サイズ/2)
tmpfile = File::expand_path "~/.screensplit-split"

def scrcmd( *cmds )
  system "screen", "-X", "eval", *cmds
#  cmds.each do |cmd|
#    system "screen -X #{cmd}"
#  end
end

if File::exist? tmpfile
  scrcmd "focus", "remove"
  File::unlink tmpfile
else
  scrcmd "split", "focus", "select #{window_name}", "focus", "resize #{resize_width}"
  open( tmpfile, 'w' ).close
end
