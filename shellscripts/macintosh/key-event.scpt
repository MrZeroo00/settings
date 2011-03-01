on run argv
  set keycode to (item 1 of argv) as integer
  tell application "System Events"
    key code keycode
  end tell
end run
