-- http://memogaki.soudesune.net/AppleScript.html

on run argv
  set type to (item 1 of argv) as string
  set x to (item 2 of argv) as integer
  set y to (item 3 of argv) as integer
  my mouseClick({x, y}, type, 1, "", 0.1)
end run

-- 現在のマウスの場所をコントロール+クリックする
--my mouseClick({"mouse", "mouse"}, "left", 1, "control", 0.1)

-- アップルメニューあたりをクリックする
--my mouseClick({18, 10}, "left", 1, "", 0.1)

-- 100,100を1.1秒押すクリックする
-- miの長押しコンテキストメニューの表示テスト
--tell application "mi" to activate
--my mouseClick({100, 100}, "left", 1, "", 1.1)

-- 現在のマウスの場所を右クリックする
--my mouseClick({"mouse", "mouse"}, "right", 1, "", 0.1)

-- 現在のマウスの場所をミドルクリックする
--my mouseClick({"mouse", "mouse"}, "middle", 1, "", 0.1)

-- 現在のマウスの場所をトリプルクリックする
--my mouseClick({"mouse", "mouse"}, "left", 3, "", 0.1)

on mouseClick(thePosition, theButton, theClickCount, theModifierKeys, thePressSec)
  (*
ver.2010.6.11
 thePosition は {"mouse", "mouse"} で現在のマウスの位置をクリックする
 theButton　は "left" "right" "middle"
 theClickCount はクリック回数。2でダブルクリック
 theModifierKeys は command shift control option fn caps
 thePressSecは押している時間。秒
 *)
  set theModifierKeys to theModifierKeys & " - "
  set thePressSecText to thePressSec as text
  set theRubyScript to "require 'osx/cocoa';
if ARGV[0] == 'mouse' then
event=OSX::CGEventCreate(nil);
pos = OSX::CGEventGetLocation(event);
print pos.x , ',', pos.y;
else
pos = [ARGV[0], ARGV[1]];

end

buttonInput = ARGV[2];
clickCount = ARGV[3].to_i;
modifierKeys = ARGV[4];
thePressSec = ARGV[5].to_f;

if  buttonInput  == 'left' then
button=0;
eventTypeDown=1;
eventTypeUp=2;
end

if buttonInput == 'right' then
button=1;
eventTypeDown=3;
eventTypeUp=4;
end

if  buttonInput == 'middle'  then
button=2;
eventTypeDown=25;
eventTypeUp=26;
end

eventFlag = 0;

if modifierKeys.index('command' ) != nil then
eventFlag |= 0x00100000;
end

if modifierKeys.index('shift' ) != nil then
eventFlag |= 0x00020000;
end

if modifierKeys.index('option' ) != nil then
eventFlag |= 0x00080000;
end

if modifierKeys.index('control' ) != nil then
eventFlag |= 0x00040000;
end

if modifierKeys.index('fn' ) != nil then
eventFlag |= 0x00800000;
end

if modifierKeys.index('caps' ) != nil then
eventFlag |= 0x00010000;
end



ev=OSX::CGEventCreateMouseEvent(nil, eventTypeDown, pos, button);
OSX::CGEventSetIntegerValueField(ev, 1, clickCount);
OSX::CGEventSetFlags(ev, eventFlag);
OSX::CGEventPost(0,ev);

sleep thePressSec;

ev2=OSX::CGEventCreateMouseEvent(nil, eventTypeUp, pos, button);
OSX::CGEventSetIntegerValueField(ev2, 1, clickCount);
OSX::CGEventSetFlags(ev2, eventFlag);
OSX::CGEventPost(0,ev2);
"
  do shell script "/usr/bin/ruby -e " & quoted form of theRubyScript & " " & item 1 of thePosition & " " & item 2 of thePosition & " " & theButton & " " & theClickCount & " " & quoted form of theModifierKeys & " " & quoted form of thePressSecText
end mouseClick
