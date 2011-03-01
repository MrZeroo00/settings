on run argv
  set keycode to item 1 of argv
  tell application "System Events"
    key code keycode
  end tell
end run
