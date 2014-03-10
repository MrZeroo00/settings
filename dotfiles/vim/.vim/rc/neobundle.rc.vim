NeoBundle 'fuenor/im_control.vim'
NeoBundle 'Align'
NeoBundleLazy 'kana/vim-textobj-user'
NeoBundle 'tpope/vim-surround'
NeoBundle 'yuroyoro/monday'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'mru.vim'
NeoBundle 'kana/vim-submode'
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
NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'jceb/vim-orgmode'
NeoBundle 'vim-scripts/confluencewiki.vim'
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
