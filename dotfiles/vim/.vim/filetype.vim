" My filetype file.

if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " Scala
  autocmd! BufRead,BufNewFile *.scala setfiletype scala
augroup END

