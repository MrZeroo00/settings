" vundle
set nocompatible

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

NeoBundle 'Align'
NeoBundleLazy 'kana/vim-textobj-user'
NeoBundle 'tpope/vim-surround'
NeoBundle 'yuroyoro/monday'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'mru.vim'
NeoBundleLazy 'tyru/restart.vim', {
  \ 'gui' : 1,
  \ 'autoload' : {
  \  'commands' : 'Restart'
  \ }}

NeoBundle 'ack.vim'
NeoBundle 'grep.vim'
NeoBundle 'othree/eregex.vim'
NeoBundle 'MultipleSearch'
NeoBundle 'SearchComplete'

NeoBundle 'hrp/EnhancedCommentify'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'closetag.vim'
NeoBundle 'taglist.vim'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'joonty/vdebug.git'
NeoBundleLazy 'vim-ruby/vim-ruby', {
  \ 'autoload' : {
  \   'filetypes' : 'ruby',
  \ }}
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'jceb/vim-orgmode'
NeoBundle 'vim-scripts/CodeReviewer.vim'
NeoBundleLazy 'elzr/vim-json', {
  \ 'autoload' : {
  \   'filetypes' : 'json',
  \ }}

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \   },
      \ }
NeoBundleLazy 'Shougo/vimshell', { 'depends' : [ 'Shougo/vimproc' ] }
NeoBundleLazy 'Shougo/vimfiler' ", { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle 'thinca/vim-quickrun'

NeoBundleLazy 'Shougo/unite.vim' ", { 'depends' : [ 'Shougo/vimproc' ] }
NeoBundleLazy 'ujihisa/unite-locate', { 'autoload' : {
  \ 'unite_sources' : 'locate',
  \ }}
NeoBundleLazy 'h1mesuke/unite-outline', { 'autoload' : {
  \ 'unite_sources' : 'outline',
  \ }}
NeoBundleLazy 'osyo-manga/unite-quickfix', { 'autoload' : {
  \ 'unite_sources' : 'quickfix',
  \ }}

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'thinca/vim-guicolorscheme'
if has('clientserver')
  NeoBundle 'thinca/vim-singleton'
  call singleton#enable()
endif
filetype plugin indent on
NeoBundleCheck

set fileformats=unix,dos,mac
set viminfo='100,f1,\"50,:100,@100,/100,!

" key bindings
nmap <C-e> :!eijiro <C-R><C-W><CR>
nmap ,man :!man -S 2,3,1,4,5,6,7,8,9 <C-R><C-W><CR>
map ,cd :cd %:p:h<CR>
"nmap <C-N><C-N> :set invnumber<CR>
nmap ,last '0
nmap ,msession :mksession $HOME/etc/session.vim<CR>
nmap ,rsession :source $HOME/etc/session.vim<CR>
nmap . .`[

"" command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>b <S-Left>

"" taglist
nmap ,tlist :Tlist<CR>

"nmap <Space> :MBEbn<CR>
"" screen like key bindings
"let mapleader = "^F"
"nnoremap <Leader><Space> :MBEbn<CR>
"nnoremap <Leader>n       :MBEbn<CR>
"nnoremap <Leader><C-n>   :MBEbn<CR>
"nnoremap <Leader>p       :MBEbp<CR>
"nnoremap <Leader><C-p>   :MBEbp<CR>
"nnoremap <Leader>c       :new<CR>
"nnoremap <Leader><C-c>   :new<CR>
"nnoremap <Leader>k       :bd<CR>
"nnoremap <Leader><C-k>   :bd<CR>
""nnoremap <Leader>s       :IncBufSwitch<CR>
""nnoremap <Leader><C-s>   :IncBufSwitch<CR>
"nnoremap <Leader><Tab>   :wincmd w<CR>
"nnoremap <Leader>Q       :only<CR>
"nnoremap <Leader>w       :ls<CR>
"nnoremap <Leader><C-w>   :ls<CR>
"nnoremap <Leader>a       :e #<CR>
"nnoremap <Leader><C-a>   :e #<CR>
"nnoremap <Leader>"       :BufExp<CR>
"nnoremap <Leader>1       :e #1<CR>
"nnoremap <Leader>2       :e #2<CR>
"nnoremap <Leader>3       :e #3<CR>
"nnoremap <Leader>4       :e #4<CR>
"nnoremap <Leader>5       :e #5<CR>
"nnoremap <Leader>6       :e #6<CR>
"nnoremap <Leader>6       :e #7<CR>
"nnoremap <Leader>6       :e #8<CR>
"nnoremap <Leader>6       :e #9<CR>

" close symbols
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" move between function
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" short command name
command MK make
command MKC make clean
command MKI make install-files
command GF execute "Gtags -f " . expand("%:~:.")
command RS %s/\s\+$//
if has("python")
  command! -nargs=+ Calc :python print <args>
  python from math import *
endif

" charcode setting
if has("gui_win32")
  set encoding=utf-8
  set termencoding=cp932
else
  set encoding=utf-8
endif
set fileencoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,euc-jp

" format setting
set shiftwidth=2
set tabstop=2
set softtabstop=0
set expandtab
set smarttab
"set paste

" search setting
set incsearch
set hlsearch
set smartcase
"set nowrapscan

"" view setting
" syntax setting
syntax on

set number
set nocursorline
"set ruler
"set ttyfast
set t_Co=256
set background=dark
colorscheme solarized
highlight Normal ctermfg=lightgray
highlight Search ctermbg=90 cterm=NONE
highlight CursorLine cterm=underline
"set list
"set listchars=tab:>-,trail:-,"etends:<,eol:/
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
set showmatch

"highlight tabs ctermbg=green guibg=green
"match tabs /\t/
set cmdheight=2

" status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" bell setting
set noerrorbells
set visualbell
set t_vb=

" completion
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
set complete+=k
set completeopt=menu,preview
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=12
hi PmenuSbar ctermbg=0

"" programming setting
filetype plugin indent on
"set autoindent
"set smartindent
set cindent
set tags=./tags,tags,tags;/
"set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,M0,j1,)20,*30,#0
set cinoptions=t0

" backup setting
set backupdir=$HOME/etc/backup/vim/,/tmp
set backup
set writebackup
set directory=.,/tmp

" other setting
set autowrite
"set autochdir
set browsedir=buffer
set hidden
set backspace=indent,eol,start
set imdisable
set iminsert=0
set imsearch=0
set scrolloff=5
set clipboard+=unnamed
runtime ftplugin/man.vim
set keywordprg=$HOME/bin/eijiro
set grepprg=ack\ -a
set dictionary=$HOME/.vim/dictionary
set spell spelllang=en_us
set sessionoptions+=unix,slash
"autocmd BufEnter * execute ":lcd " . expand("%:p:h")

"" for screen setting
" ctags with screen (C-t key binding)
nmap <c-\[> :pop<CR>

" set screen title to file name
if &term == $TERMSCREEN
  autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | silent! exe '!echo -n "k%\\"' | endif
  autocmd VimLeave * silent! exe '!echo -n "k`basename $PWD`\\"'
endif

" netrw setting
if v:version >= 700
  let g:netrw_alto=1
  let g:netrw_altv=1
  let g:netrw_keepdir=1
  let g:netrw_browse_split=2
  let g:netrw_sort_sequence='[\/]$,*,\.bak$,\.o$,\.c$,\.h$,\.info$,\.swp$,\.obj$'
endif

" abbreviation
iabbrev tok tokyo

"" printer setting
set printheader=%t%=%N
set printoptions=paper:A4
set printoptions+=portrait:y
set printoptions+=duplex:short
set printoptions+=left:10in,right:5in,top:5in,bottom:5in
set printoptions+=wrap:y
set printoptions+=syntax:a
set printoptions+=collate:y
set printfont=IPAGothic:h12

"" howm
set runtimepath+=$HOME/etc/howm_vim
let g:howm_dir="$HOME/howm"
let g:howm_grepprg="/bin/egrep"
let g:howm_findprg="/usr/bin/find"

"" CodeReviewer
let g:CodeReviewer_reviewer = "Mitsuhiro Tanda"

"" gtags
nmap ,gtags :Gtags <C-R><C-W><CR>
nmap ,gr :Gtags -r <C-R><C-W><CR>
nmap ,gs :Gtags -s <C-R><C-W><CR>
nmap ,gg :Gtags -g <C-R><C-W><CR>
nmap <C-n> :cnext<CR>
nmap <C-p> :cprevious<CR>
"map <C-]> :GtagsCursor<CR>
"nmap <C-J> <C-W>j<C-W>_
"nmap <C-K> <C-W>k<C-W>_

"" unite.vim
if s:bundle_tap('unite.vim') " {{{
  call s:bundle_config({
        \   'autoload' : {
        \     'commands' : [
        \       {
        \         'name' : 'Unite',
        \         'complete' : 'customlist,unite#complete_source'
        \       },
        \       'UniteWithCursorWord',
        \       'UniteWithInput'
        \     ]
        \   }
        \ })

  function! s:tapped_bundle.hooks.on_source(bundle)
    let g:unite_kind_jump_list_after_jump_scroll=0
    let g:unite_enable_start_insert = 0
    let g:unite_source_rec_min_cache_files = 1000
    let g:unite_source_rec_max_cache_files = 5000
    let g:unite_source_file_mru_long_limit = 6000
    let g:unite_source_file_mru_limit = 300
    let g:unite_source_directory_mru_long_limit = 6000
    let g:unite_prompt = '❯ '
  endfunction

  nnoremap [unite] <Nop>
  nmap <Space>u [unite]
  nnoremap <silent> [unite]u :<C-u>Unite -start-insert menu:unite<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]p :<C-u>Unite -start-insert file_rec/async:! -buffer-name=file_rec<CR>
  nnoremap <silent> [unite]g :<C-u>Unite grep -no-quit<CR>

  call s:bundle_untap()
endif " }}}

"" Vdebug
"let g:vdebug_options['port'] = 9000
"let g:vdebug_options['server'] = 'localhost'
"let g:vdebug_options['timeout'] = 20
"let g:vdebug_options['on_close'] = 'detach'
"let g:vdebug_options['break_on_open'] = 0
"let g:vdebug_options['ide_key'] = 'netbeans-xdebug'
"let g:vdebug_options['path_maps'] = {}
"let g:vdebug_options['debug_window_level'] = 0
"let g:vdebug_options['debug_file_level'] = 0
"let g:vdebug_options['debug_file'] = ''
"let g:vdebug_options['watch_window_style'] = 'expanded'
"let g:vdebug_options['marker_default'] = '⬦'
"let g:vdebug_options['marker_closed_tree'] = '▸'
"let g:vdebug_options['marker_open_tree'] = '▾'

"" vimfiler
if s:bundle_tap('vimfiler') " {{{
  call s:bundle_config({
        \   'autoload' : {
        \     'commands' : [
        \       'VimFilerBufferDir'
        \     ]
        \   }
        \ })

  call s:bundle_untap()
endif " }}}

"" YankRing.vim
if s:bundle_tap('YankRing.vim') " {{{
  function! s:tapped_bundle.hooks.on_source(bundle)
    let g:yankring_replace_n_pkey = ',yp'
    let g:yankring_replace_n_nkey = ',yn'
  endfunction

  nmap ,ys :YRShow<CR>

  call s:bundle_untap()
endif " }}}

if filereadable($HOME . '/.vimrc.local')
  source $HOME/.vimrc.local
endif
