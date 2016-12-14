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

NeoBundleLazy 'lambdalisue/vim-gita', {
      \ 'autoload': {
      \   'commands': ['Gita'],
      \}}
"NeoBundleLazy 'tpope/vim-endwise'
"NeoBundleLazy 'szw/vim-tags' " => https://github.com/alpaca-tc/alpaca_tags
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
