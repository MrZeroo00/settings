autocmd Filetype html,xml,xsl source $HOME/.vim/scripts/closetag.vim
autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* set filetype=tmux

if filereadable($HOME . '/.vim/after/filetype.vim.local')
  source $HOME/.vim/after/filetype.vim.local
endif
