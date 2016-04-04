"---------------------------------------------------------------------------
" NeoBundle:
"

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'rhysd/vim-operator-surround', {
      \   'mappings' : '<Plug>(operator-surround',
      \ }
NeoBundle 'kana/vim-niceblock', {
      \   'mappings' : '<Plug>(niceblock-',
      \ }

NeoBundle 'Shougo/echodoc.vim'

" NeoBundle 'Shougo/neocomplcache.vim'

NeoBundle 'Shougo/neocomplete.vim'

"NeoBundleLazy 'Shougo/neocomplcache-rsense'

NeoBundleLazy 'Shougo/neosnippet.vim'

NeoBundle 'Shougo/neobundle-vim-scripts'

NeoBundle 'Shougo/unite.vim'
NeoBundleLazy 'Shougo/unite-build'
NeoBundleLazy 'Shougo/unite-ssh', {
      \ 'filetypes' : 'vimfiler',
      \ }
NeoBundleLazy 'majkinetor/unite-cmdmatch' , {
      \ 'depends':  'Shougo/unite.vim',
      \ 'mappings' : [['c', '<Plug>(unite_cmdmatch_complete)']] }
NeoBundle 'Shougo/neomru.vim'

NeoBundleLazy 'ujihisa/vimshell-ssh', {
      \ 'filetypes' : 'vimshell',
      \ }
NeoBundle 'Shougo/unite-sudo'
NeoBundleLazy 'thinca/vim-openbuf'
NeoBundleLazy 'Shougo/vim-vcs', {
      \ 'depends' : 'thinca/vim-openbuf',
      \ 'autoload' : {'commands' : 'Vcs'},
      \ }
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \ }
      \ }

NeoBundle 'Shougo/vimshell.vim'
NeoBundleLazy 'yomi322/vim-gitcomplete', {
      \ 'filetype' : 'vimshell'
      \ }

NeoBundleLazy 'Shougo/vinarise.vim'

NeoBundleLazy 'Shougo/vesting', {
      \ 'unite_sources' : 'vesting'
      \ }
NeoBundle 'vim-jp/vital.vim'
NeoBundleLazy 'Shougo/junkfile.vim'

" NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Shougo/unite-outline'

NeoBundleLazy 'hail2u/vim-css3-syntax'
NeoBundleLazy 'kana/vim-smartchr', {
      \ 'insert' : 1,
      \ }
NeoBundle 'kana/vim-operator-user', {
      \   'functions' : 'operator#user#define',
      \ }
NeoBundleLazy 'kana/vim-operator-replace', {
      \ 'depends' : 'vim-operator-user',
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nx', '<Plug>(operator-replace)']]
      \ }}
NeoBundleLazy 'kana/vim-textobj-user'
" NeoBundleLazy 'kana/vim-wwwsearch'
NeoBundleLazy 'kien/ctrlp.vim'
NeoBundleLazy 'LeafCage/foldCC', {
      \ 'filetypes' : 'vim' }
NeoBundleLazy 'mattn/webapi-vim'
" NeoBundle 'basyura/webapi-vim'
"NeoBundleLazy 'add20/vim-conque', {
"      \ 'commands' : 'ConqueTerm'
"      \ }
NeoBundleLazy 'thinca/vim-fontzoom', {
      \ 'gui' : 1,
      \ 'autoload' : {
      \  'mappings' : [
      \   ['n', '<Plug>(fontzoom-larger)'],
      \   ['n', '<Plug>(fontzoom-smaller)']]
      \ }}
NeoBundleLazy 'thinca/vim-prettyprint', {
      \ 'commands' : 'PP'
      \ }
NeoBundleLazy 'thinca/vim-qfreplace', {
      \ 'filetypes' : ['unite', 'quickfix'],
      \ }
NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'commands' : 'QuickRun',
      \ 'mappings' : [
      \   ['nxo', '<Plug>(quickrun)']],
      \ }
NeoBundleLazy 'thinca/vim-scouter', {
      \ 'commands' : 'Scouter'
      \ }
NeoBundleLazy 'thinca/vim-ref', {
      \ 'commands' : 'Ref',
      \ 'unite_sources' : 'ref',
      \ }
NeoBundleLazy 'thinca/vim-unite-history', {
      \ 'unite_sources' : ['history/command', 'history/search']
      \ }
NeoBundleLazy 'vim-ruby/vim-ruby', {
      \ 'mappings' : '<Plug>(ref-',
      \ 'filetypes' : 'ruby'
      \ }

NeoBundleLazy 'basyura/J6uil.vim'

NeoBundleLazy 'Shougo/unite-help'
NeoBundleLazy 'tsukkee/unite-tag', {
      \ 'unite_sources' : ['tag', 'tag/include', 'tag/file']
      \ }
NeoBundleLazy 'tyru/caw.vim', {
      \ 'mappings' : [
      \   '<Plug>(caw:prefix)', '<Plug>(caw:i:toggle)']
      \ }
NeoBundleLazy 'tyru/eskk.vim', {
      \ 'mappings' : [['i', '<Plug>(eskk:']],
      \ }
NeoBundleLazy 'tyru/open-browser.vim', {
      \ 'mappings' : '<Plug>(open-browser-',
      \ }
NeoBundleLazy 'tyru/restart.vim', {
      \ 'gui' : 1,
      \ 'autoload' : {
      \  'commands' : 'Restart'
      \ }}
" NeoBundle 'tyru/skk.vim'
NeoBundleLazy 'tyru/winmove.vim', { 'autoload' : {
      \ 'mappings' : [
      \   ['n', '<Plug>(winmove-up)', '<Plug>(winmove-down)',
      \         '<Plug>(winmove-left)', '<Plug>(winmove-right)']],
      \ },
      \ 'gui' : 1,
      \ 'augroup' : 'winmove',
      \ }
NeoBundleLazy 'ujihisa/neco-ghc', {
      \ 'filetypes' : 'haskell'
      \ }
NeoBundle 'ujihisa/neco-look'
NeoBundleLazy 'ujihisa/unite-colorscheme'
NeoBundleLazy 'vim-jp/vimdoc-ja', {
      \ 'filetype' : 'help',
      \ }
" NeoBundleLazy 'eignn/netrw.vim', {
      " \ 'commands' : 'Explore',
      " \ }
NeoBundleLazy 'yuratomo/w3m.vim', {
      \ 'commands' : 'W3m',
      \ }
" NeoBundle 'hrsh7th/vim-unite-vcs'
NeoBundleLazy 'osyo-manga/unite-quickfix'
NeoBundleLazy 'osyo-manga/unite-filetype'
"NeoBundleLazy 'rbtnn/hexript.vim'
NeoBundleLazy 'kana/vim-tabpagecd', {
      \ 'unite_sources' : 'tab'
      \ }
NeoBundleLazy 'rhysd/accelerated-jk', {
      \ 'mappings' : '<Plug>(accelerated_jk_',
      \ }

" NeoBundle 'gmarik/vundle'
NeoBundleLazy 'vim-jp/autofmt', {
      \ 'mappings' : [['x', 'gq']],
      \ }

NeoBundleLazy 'supermomonga/unite-kawaii-calc'

" From vim.org
NeoBundleLazy 'godlygeek/csapprox', { 'terminal' : 1 }
NeoBundleLazy 'thinca/vim-guicolorscheme', { 'terminal' : 1 }
NeoBundleLazy 'tpope/vim-repeat', {
      \ 'mappings' : '.',
      \ }
NeoBundleLazy 'autodate.vim', {
      \ 'filetypes' : 'vim',
      \ }

NeoBundleLazy 'matchit.zip', {
      \ 'mappings' : ['%', 'g%']
      \ }
let bundle = neobundle#get('matchit.zip')
function! bundle.hooks.on_post_source(bundle)
  silent! execute 'doautocmd Filetype' &filetype
endfunction


NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {
      \ 'filetypes' : 'javascript',
      \ }
NeoBundleLazy 'jelera/vim-javascript-syntax', {
      \ 'filetypes' : 'javascript',
      \ }
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
      \ 'filetypes' : 'python',
      \ }
NeoBundleLazy 'bkad/CamelCaseMotion', {
      \ 'mappings' : '<Plug>CamelCaseMotion_',
      \ }
NeoBundleLazy 'aharisu/vim-gdev', {
      \ 'filetypes' : 'scheme',
      \ }
NeoBundleLazy 'vim-jp/cpp-vim', {
      \ 'filetypes' : 'cpp',
      \ }
NeoBundleLazy 'thinca/vim-ft-diff_fold', {
      \ 'filetypes' : 'diff'
      \ }
NeoBundleLazy 'thinca/vim-ft-markdown_fold', {
      \ 'filetypes' : 'markdown'
      \ }
NeoBundleLazy 'nsf/gocode', {
      \ 'rtp' : 'vim',
      \ 'filetypes' : 'go',
      \ }

if has('python')
  " NeoBundleLazy 'marijnh/tern_for_vim', {
  "       \ 'external_commands' : 'npm',
  "       \ 'build' : 'npm install',
  "       \ 'autoload' : {
  "       \   'functions': ['tern#Complete', 'tern#Enable'],
  "       \   'filetypes' : 'javascript'
  "       \ }}
endif


NeoBundleLazy 'thinca/vim-ft-help_fold', {
      \ 'filetypes' : 'help'
      \ }

NeoBundleLazy 'elzr/vim-json', {
      \   'filetypes' : 'json',
      \ }

NeoBundleLazy 'tyru/open-browser.vim', {
      \   'commands' : ['OpenBrowserSearch', 'OpenBrowser'],
      \   'functions' : 'openbrowser#open',
      \ }

NeoBundleLazy 'kana/vim-filetype-haskell', {
      \   'filetypes' : 'haskell',
      \ }
NeoBundleLazy 'JesseKPhillips/d.vim', {
      \   'filetypes' : 'd',
      \ }
" NeoBundleLazy 'osyo-manga/vim-marching', {
"       \ 'filetypes' : ['c', 'cpp']
"       \ 'depends' : ['osyo-manga/vim-reunions', 'Shougo/vimproc.vim'],
"       \}
NeoBundleLazy 't9md/vim-smalls', {
      \ 'mappings' : ['<Plug>(smalls)', '<Plug>(smalls-)']
      \ }

" NeoBundleLazy 'LeafCage/cmdlineplus.vim', {
"       \ 'mappings': [['c', '<Plug>(cmdlineplus-']]}

NeoBundleLazy 'sophacles/vim-processing', {
      \ 'filename_patterns': '\.pde$'}

NeoBundleLazy 'Shougo/javacomplete'

NeoBundleLazy 'chikatoike/concealedyank.vim', {
      \   'mappings' : [['x', '<Plug>(operator-concealedyank)']]
      \ }

NeoBundleLazy 't9md/vim-choosewin', {
      \   'mappings' : '<Plug>(choosewin)'
      \ }

NeoBundleLazy 'gcmt/wildfire.vim', {
      \ 'mappings' : '<Plug>(wildfire-'
      \ }

if filereadable('vimrc_local.vim') ||
      \ findfile('vimrc_local.vim', '.;') != ''
  " Load develop version.
  call neobundle#local(fnamemodify(
        \ findfile('vimrc_local.vim', '.;'), ':h'))
endif

" NeoBundle 'tpope/vim-fugitive'

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

NeoBundleLazy 'Shougo/neosnippet-snippets'
"NeoBundleLazy 'yuku-t/vim-ref-ri'
"NeoBundleLazy 'szw/vim-tags'
"NeoBundleLazy 'tpope/vim-endwise'
"NeoBundle 'marcus/rsense'
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', {
      \ 'autoload' : {
      \   'insert' : 1,
      \   'filetypes': 'ruby',
      \ }}
NeoBundle 'https://vimperator-labs.googlecode.com/hg/', {
      \ 'name': 'vimperator-syntax',
      \ 'type': 'hg',
      \ 'rtp':  'vimperator/contrib/vim/'
      \ }
NeoBundleLazy 'osyo-manga/unite-choosewin-actions', {
      \ 'depends' : 't9md/vim-choosewin',
      \ 'unite_sources' : ['file']
      \ }
NeoBundleLazy 'sgur/vim-textobj-parameter'
NeoBundleLazy 'osyo-manga/vim-textobj-multiblock'
NeoBundleLazy 'osyo-manga/vim-textobj-multitextobj'
"NeoBundleLazy 'terryma/vim-multiple-cursors', {
"      \ 'autoload': {
"      \   'commands': ['MultipleCursorsFind'],
"      \}}

NeoBundleLazy 'mattn/emoji-vim',  {
      \ 'commands' : 'Emoji',
      \ }

NeoBundleLazy 'ujihisa/unite-locate', { 'autoload' : {
      \ 'unite_sources' : 'locate',
      \ }}
NeoBundleLazy 'lambdalisue/vim-gista', {
      \ 'autoload': {
      \   'commands': ['Gista'],
      \   'mappings': '<Plug>(gista-',
      \   'unite_sources': 'gista',
      \}}
NeoBundleLazy 'lambdalisue/unite-grep-vcs', {
      \ 'autoload': {
      \   'unite_sources': ['grep/git', 'grep/hg'],
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
