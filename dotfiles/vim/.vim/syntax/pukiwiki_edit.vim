" Last Change: 15-Apr-2005.

scriptencoding euc-jp

runtime! syntax/help.vim

hi def link BracketName Directory
"hi def link Head Directory
"hi def link VimPHPURL Underlined
hi def link BodyDelim LineNr
"hi def link NotEditable WarningMsg
hi def link Index Directory
hi def link List Directory


"syntax match VimPHPURL display "s\?https\?:\/\/[-_.!~*'()a-zA-Z0-9;/?:@&=+$,%#]\+\/vim.php[-\./0-9a-zA-Z]*"
"syntax match BracketName display "\[\[\%(\s\)\@!:\=[^\r\n\t[\]<>#&":]\+:\=\%(\s\)\@<!\]\]"
syntax match BracketName display "\[\[\_.\{-}\]\]"
syntax match BodyDelim display "^-\{3,}.*--$"
"syntax match Head display "\\\@<!|[^"*|]\+|"
"syntax match NotEditable display "===== Not Editable ====="
syntax match Index display "^\*\{,3}"
syntax match List display "^[+-]\{,3}"

" 最小マッチ
" \_.\{-}

