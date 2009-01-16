colorscheme desert
"set guioptions-=m
"set guioptions-=T
set guioptions+=a
set lines=47
set columns=80
set showtabline=2
set noimdisable

if has('multi_byte_ime')
  set noimcmdline
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
  " don't hold IM status in insert mode
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

if has("x11")
  set imactivatekey=s-space
  set guifont=DejaVu\ Sans\ Mono,IPAGothic:h9
elseif has("gui_mac")
  set guifont=Osaka-Mono:h12
elseif has("gui_win32")
endif
