"---------------------------------------------------------------------------
" Initialize:
"

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
  set nocompatible
endif

if has('nvim')
  runtime! plugin/python_setup.vim
  set unnamedclip
endif

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

" call neobundle#rc(expand('$CACHE/neobundle'))
call neobundle#begin(expand('$CACHE/neobundle'))

if neobundle#has_cache()
  NeoBundleLoadCache
else
  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \    }
        \ }

  "call neobundle#load_toml(
  "      \ '~/.vim/rc/neobundle.toml', {'lazy' : 1})
  call s:source_rc('neobundle.rc.vim')
  NeoBundleSaveCache
endif

if filereadable('vimrc_local.vim') ||
      \ findfile('vimrc_local.vim', '.;') != ''
  " Load develop version.
  call neobundle#local(fnamemodify(
        \ findfile('vimrc_local.vim', '.;'), ':h'))
endif

NeoBundleLocal ~/.vim/bundle

" NeoBundle configurations.
" NeoBundleDisable neocomplcache.vim

call s:source_rc('plugins.rc.vim')

call neobundle#end()

filetype plugin indent on

" Enable syntax color.
syntax enable

if !has('vim_starting')
  " Installation check.
  NeoBundleCheck
endif

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
" Mappings:
"

call s:source_rc('mappings.rc.vim')

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
" Platform:
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
" GUI:
"

if has('gui_running')
  call s:source_rc('gui.rc.vim')
endif

"---------------------------------------------------------------------------
" Others:
"

"" vim-singleton
if neobundle#tap('vim-singleton') " {{{
  call singleton#enable()
endif " }}}

" If true Vim master, use English help file.
set helplang& helplang=en,ja

" Default home directory.
let t:cwd = getcwd()

set secure

"" powerline
call s:source_rc('powerline.rc.vim')

"" http://tangosource.com/blog/a-tmux-crash-course-tips-and-tweaks/
if exists('$TMUX')
  set term=screen-256color
endif

if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

" Use vsplit mode
if has("vim_starting") && !has('gui_running') && has('vertsplit')
  function! EnableVsplitMode()
    " enable origin mode and left/right margins
    let &t_CS = "y"
    let &t_ti = &t_ti . "\e[?6;69h"
    let &t_te = "\e[?6;69l\e[999H" . &t_te
    let &t_CV = "\e[%i%p1%d;%p2%ds"
    call writefile([ "\e[?6;69h" ], "/dev/tty", "a")
  endfunction

  " old vim does not ignore CPR
  map <special> <Esc>[3;9R <Nop>

  " new vim can't handle CPR with direct mapping
  " map <expr> ^[[3;3R EnableVsplitMode()
  set t_F9=[3;3R
  map <expr> <t_F9> EnableVsplitMode()
  let &t_RV .= "\e[?6;69h\e[1;3s\e[3;9H\e[6n\e[0;0s\e[?6;69l"
endif

if filereadable($HOME . '/.vimrc.local')
  source $HOME/.vimrc.local
endif

" vim: foldmethod=marker
