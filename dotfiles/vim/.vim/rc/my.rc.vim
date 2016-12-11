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
