" vundle
set nocompatible

set fileformats=unix,dos,mac
set viminfo='100,f1,\"50,:100,@100,/100,!

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
