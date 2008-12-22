autocmd BufNewFile,BufRead /home/tanda/memo/* set filetype=pukiwiki_edit

if filereadable($HOME . '/.vim/after/filetype.vim.local')
  source $HOME/.vim/after/filetype.vim.local
endif
