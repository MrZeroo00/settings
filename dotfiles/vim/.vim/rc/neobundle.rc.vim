"---------------------------------------------------------------------------
" NeoBundle:
"

" my
"NeoBundle 'itchyny/thumbnail.vim'
"NeoBundle 'ack.vim'
"NeoBundle 'grep.vim'
"NeoBundle 'taglist.vim'

"NeoBundle 'closetag.vim'

NeoBundle 'fuenor/im_control.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'yuroyoro/monday'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'kana/vim-submode'

"NeoBundle 'othree/eregex.vim'
"NeoBundle 'SearchComplete'

NeoBundle 'zoncoen/unite-autojump'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'joker1007/unite-pull-request'
NeoBundle 'hewes/unite-gtags'
"NeoBundle 'sergei-dyshel/vim-abbrev-matcher'

NeoBundle 'cohama/agit.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'mattn/gist-vim'

NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'joonty/vdebug.git'
NeoBundle 'vim-scripts/CodeReviewer.vim'
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'osyo-manga/vim-precious'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'tyru/current-func-info.vim'
"NeoBundle 'osyo-manga/shabadou.vim'
"NeoBundle 'osyo-manga/vim-watchdogs'

NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'Quramy/vison'
NeoBundle 'stephpy/vim-yaml'
NeoBundle 'fatih/vim-go'
NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'snipMate'
NeoBundle 'ryuzee/neosnippet_chef_recipe_snippet'
NeoBundle 'glidenote/serverspec-snippets'
NeoBundle 'vim-scripts/confluencewiki.vim'
NeoBundle 'tejr/vim-tmux'

NeoBundle 'jceb/vim-orgmode'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'osyo-manga/unite-qfixhowm'

NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'cohama/lexima.vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'vim-scripts/DirDiff.vim'
NeoBundle 'tyru/capture.vim'
NeoBundle 't9md/vim-quickhl'
"NeoBundle 'wellle/tmux-complete.vim' " become slow, comment out
NeoBundle 'mhinz/vim-hugefile'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'haya14busa/vim-migemo'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'kopischke/vim-fetch'
NeoBundle 'b4b4r07/vim-shellutils'
NeoBundle 'asenac/vim-opengrok'
NeoBundle 'jeaye/color_coded', {
      \ 'build' : {
      \     'mac' : 'mkdir build && cmake -E chdir build cmake .. && make && make install',
      \     'unix' : 'mkdir build && cmake -E chdir build cmake .. && make && make install',
      \ }
      \ }

NeoBundle 'https://vimperator-labs.googlecode.com/hg/', {
      \ 'name': 'vimperator-syntax',
      \ 'type': 'hg',
      \ 'rtp':  'vimperator/contrib/vim/'
      \ }

"NeoBundleLazy 'terryma/vim-multiple-cursors', {
"      \ 'autoload': {
"      \   'commands': ['MultipleCursorsFind'],
"      \}}
NeoBundleLazy 'terryma/vim-expand-region', {
      \ 'autoload': {
      \   'mappings': ['(expand_region']
      \}}
NeoBundleLazy 'mattn/emoji-vim',  {
      \ 'commands' : 'Emoji',
      \ }

NeoBundleLazy 'sgur/vim-textobj-parameter'
NeoBundleLazy 'osyo-manga/vim-textobj-multiblock'
NeoBundleLazy 'osyo-manga/vim-textobj-multitextobj'

NeoBundleLazy 'lambdalisue/unite-grep-vcs', {
      \ 'autoload': {
      \   'unite_sources': ['grep/git', 'grep/hg'],
      \}}
NeoBundleLazy 'ujihisa/unite-locate', { 'autoload' : {
      \ 'unite_sources' : 'locate',
      \ }}
NeoBundleLazy 'osyo-manga/unite-choosewin-actions', {
      \ 'depends' : 't9md/vim-choosewin',
      \ 'unite_sources' : ['file']
      \ }

NeoBundleLazy 'lambdalisue/vim-gita', {
      \ 'autoload': {
      \   'commands': ['Gita'],
      \}}
"NeoBundleLazy 'tpope/vim-endwise'
"NeoBundleLazy 'szw/vim-tags' " => https://github.com/alpaca-tc/alpaca_tags
"NeoBundle 'marcus/rsense'
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', {
      \ 'autoload' : {
      \   'insert' : 1,
      \   'filetypes': 'ruby',
      \ }}
NeoBundleLazy 'Shougo/neosnippet-snippets'
NeoBundleLazy 'lambdalisue/vim-gista', {
      \ 'autoload': {
      \   'commands': ['Gista'],
      \   'mappings': '<Plug>(gista-',
      \   'unite_sources': 'gista',
      \}}
NeoBundleLazy 'codegram/vim-codereview', {
      \ 'depends' : 'junkblocker/patchreview-vim',
      \ 'autoload': {
      \   'commands': ['CodeReview'],
      \}}

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'
if has('clientserver')
  NeoBundle 'thinca/vim-singleton'
endif

NeoBundleLocal ~/.vim/bundle


" NeoBundle configurations.
" NeoBundleDisable neocomplcache.vim

call neobundle#config(['echodoc.vim', 'neocomplete.vim'], {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'insert' : 1,
      \ }})
call neobundle#config('neosnippet.vim', {
      \ 'lazy' : 1,
      \ 'depends' : 'Shougo/neosnippet-snippets',
      \ 'autoload' : {
      \   'insert' : 1,
      \   'filetypes' : 'snippet',
      \   'unite_sources' : [
      \      'neosnippet', 'neosnippet/user', 'neosnippet/runtime'],
      \ }})
call neobundle#config('unite.vim',{
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'Unite',
      \                   'complete' : 'customlist,unite#complete_source'},
      \                 'UniteWithCursorWord', 'UniteWithInput']
      \ }})
call neobundle#config('vimfiler.vim', {
      \ 'lazy' : 1,
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \    'commands' : [
      \                  { 'name' : 'VimFiler',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'VimFilerTab',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'VimFilerExplorer',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'Edit',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'Write',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  'Read', 'Source'],
      \    'mappings' : '<Plug>(vimfiler_',
      \    'explorer' : 1,
      \ }
      \ })
call neobundle#config('vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ })
call neobundle#config('vimshell.vim', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellCreate',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : '<Plug>(vimshell_'
      \ }})
call neobundle#config('vinarise.vim', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : [{
      \     'name' : 'Vinarise', 'complete' : 'file'
      \   }]
      \ }})
call neobundle#config('vital.vim', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \     'commands' : ['Vitalize'],
      \ }})
call neobundle#config('junkfile.vim', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : 'JunkfileOpen',
      \   'unite_sources' : ['junkfile', 'junkfile/new'],
      \ }})
call neobundle#config('unite-outline', {
      \ 'lazy' : 1,
      \ })
call neobundle#config('J6uil.vim', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : {
      \      'name' : 'J6uil',
      \      'complete' : 'custom,J6uil#complete#room'},
      \   'function_prefix' : 'J6uil',
      \   'unite_sources' : 'J6uil/rooms',
      \ },
      \ 'depends' : 'mattn/webapi-vim',
      \ })
call neobundle#config('javacomplete', {
      \ 'lazy' : 1,
      \ 'build': {
      \       'cygwin': 'javac autoload/Reflection.java',
      \       'mac': 'javac autoload/Reflection.java',
      \       'unix': 'javac autoload/Reflection.java',
      \   },
      \ 'autoload' : {
      \   'filetypes' : 'java',
      \ }
      \})
