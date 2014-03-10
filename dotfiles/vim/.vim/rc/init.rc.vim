if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

function! s:bundle_tap(bundle) " {{{
  let s:tapped_bundle = neobundle#get(a:bundle)
  return neobundle#is_installed(a:bundle)
endfunction " }}}

function! s:bundle_config(config) " {{{
  if exists("s:tapped_bundle") && s:tapped_bundle != {}
    call neobundle#config(s:tapped_bundle.name, a:config)
  endif
endfunction " }}}

function! s:bundle_untap() " {{{
  let s:tapped_bundle = {}
endfunction " }}}

filetype plugin indent on
"NeoBundleCheck
