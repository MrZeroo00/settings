set history save on
set history size 10000
set history filename ~/.gdb_history
set print pretty on
set print address
set print symbol-filename on
set print array on
set print elements 200
set print null-stop
set print union on
set print demangle
set print static-members off
set print vtbl off
set height 0
set charset ASCII

define hookpost-run
  source .gdb_breakpoints
end
define hookpost-continue
  source .gdb_breakpoints
end

define hook-quit
#  save breakpoints .gdb_breakpoints
end

define timestamp
  shell date "+%H:%M:%S"
end
