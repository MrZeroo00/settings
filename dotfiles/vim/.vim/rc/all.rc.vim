" vundle
set nocompatible

set fileformats=unix,dos,mac
set viminfo='100,f1,\"50,:100,@100,/100,!

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
set ambiwidth=double

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

"" howm
set runtimepath+=$HOME/etc/howm_vim
let g:howm_dir="$HOME/howm"
let g:howm_grepprg="/bin/egrep"
let g:howm_findprg="/usr/bin/find"

"" im_control.vim
let g:IM_CtrlBufLocalMode = 1

"" taglist
nmap ,tlist :Tlist<CR>

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
