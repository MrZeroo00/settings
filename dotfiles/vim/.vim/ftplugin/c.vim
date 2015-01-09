" highlight setting
let b:c_gnu=1
let b:c_comment_strings=1
let b:c_space_errors=1
highlight cSpaceError cterm=underline ctermbg=red guibg=red

" fold setting
let b:c_no_comment_fold=1
let b:c_no_if0_fold=1
setlocal foldmethod=syntax

" Set cpp tags file.
"let &l:tags='./tags,tags,'.$DOTVIM.'/tags/cpp/tags'

" Set path.
if has('win32') || has('win64')
    set path+=C:/gcc/i386-pc-mingw32/include
else
    set path+=/usr/local/include;/usr/include
endif
