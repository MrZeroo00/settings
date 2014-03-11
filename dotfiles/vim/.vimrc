"---------------------------------------------------------------------------
" Initialize:
"

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

function! s:source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_sudo = $SUDO_USER != '' && $USER !=# $SUDO_USER
      \ && $HOME !=# expand('~'.$USER)
      \ && $HOME ==# expand('~'.$SUDO_USER)

function! IsWindows()
  return s:is_windows
endfunction

function! IsMac()
  return !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))
endfunction

call s:source_rc('init.rc.vim')

call s:source_rc('neobundle.rc.vim')

filetype plugin indent on

" Enable syntax color.
syntax enable

" Installation check.
NeoBundleCheck

"---------------------------------------------------------------------------
" Encoding:
"
call s:source_rc('encoding.rc.vim')

"---------------------------------------------------------------------------
" Search:
"
" Ignore the case of normal letters.
set ignorecase
" If the search pattern contains upper case characters, override ignorecase option.
set smartcase

" Enable incremental search.
set incsearch
" Don't highlight search result.
set nohlsearch

" Searches wrap around the end of the file.
set wrapscan

"---------------------------------------------------------------------------
" Edit:
"
call s:source_rc('edit.rc.vim')

"---------------------------------------------------------------------------
" View:
"
call s:source_rc('view.rc.vim')

"---------------------------------------------------------------------------
" FileType:
"
call s:source_rc('filetype.rc.vim')

"---------------------------------------------------------------------------
" Plugin:
"
call s:source_rc('plugins.rc.vim')

"---------------------------------------------------------------------------
" Key-mappings:
"
call s:source_rc('mappings.rc.vim')

" tmp
call s:source_rc('all.rc.vim')

"---------------------------------------------------------------------------
" Commands:
"
" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap

"---------------------------------------------------------------------------
" Platform depends:
"
if s:is_windows
  call s:source_rc('windows.rc.vim')
else
  call s:source_rc('unix.rc.vim')
endif

" Using the mouse on a terminal.
if has('mouse')
  set mouse=a
  if has('mouse_sgr') || v:version > 703 ||
        \ v:version == 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif

  " Paste.
  nnoremap <RightMouse> "+p
  xnoremap <RightMouse> "+p
  inoremap <RightMouse> <C-r><C-o>+
  cnoremap <RightMouse> <C-r>+
endif

"---------------------------------------------------------------------------
" Others:
"

" If true Vim master, use English help file.
set helplang& helplang=en,ja

" Default home directory.
let t:cwd = getcwd()

call neobundle#call_hook('on_source')

set secure

" vim: foldmethod=marker
