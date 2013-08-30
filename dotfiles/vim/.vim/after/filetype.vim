autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* set filetype=tmux

if filereadable($HOME . '/.vim/after/filetype.vim.local')
  source $HOME/.vim/after/filetype.vim.local
endif
