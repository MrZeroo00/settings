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
