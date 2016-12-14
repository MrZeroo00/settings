" delete git buffer when "set hidden"
augroup MyAutoCmd
  autocmd BufNewFile,BufRead *.git/{,modules/**/}{COMMIT_EDIT,MERGE_}MSG setlocal bufhidden=delete
  autocmd BufNewFile,BufRead *.git/{,modules/**/}{COMMIT_EDIT,MERGE_}MSG setlocal viminfo="NONE"
  autocmd BufDelete *.git/{,modules/**/}{COMMIT_EDIT,MERGE_}MSG !open -a /Applications/iTerm.app
  autocmd BufNewFile,BufRead *.git/config,.gitconfig,.gitmodules setlocal bufhidden=delete
  autocmd BufNewFile,BufRead *.git/config,.gitconfig,.gitmodules setlocal viminfo="NONE"
  autocmd BufDelete *.git/config,.gitconfig,.gitmodules !open -a /Applications/iTerm.app
  autocmd BufNewFile,BufRead git-rebase-todo setlocal bufhidden=delete
  autocmd BufNewFile,BufRead git-rebase-todo setlocal viminfo="NONE"
  autocmd BufDelete git-rebase-todo !open -a /Applications/iTerm.app
  autocmd FileType gitcommit setlocal bufhidden=delete
  autocmd FileType gitcommit setlocal viminfo="NONE"
augroup END

"---------------------------------------------------------------------------
" My:
"

"" powerline
"call s:source_rc('powerline.rc.vim')

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
