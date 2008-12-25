" OmniCppComplete initialization
call omni#cpp#complete#Init()

" highlight setting
let b:c_gnu=1
let b:c_comment_strings=1
let b:c_space_errors=1
highlight cSpaceError cterm=underline ctermbg=red guibg=red

" fold setting
let b:c_no_comment_fold=1
let b:c_no_if0_fold=1
setlocal foldmethod=syntax
