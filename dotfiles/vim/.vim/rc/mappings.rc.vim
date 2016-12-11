"---------------------------------------------------------------------------
" Key-mappings:
"

" Use <C-Space>.
nmap <C-Space>  <C-@>
cmap <C-Space>  <C-@>

" Visual mode keymappings: "{{{
" Indent
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
endif
"}}}

" Insert mode keymappings: "{{{
" <C-t>: insert tab.
inoremap <C-t>  <C-v><TAB>
" Enable undo <C-w> and <C-u>.
inoremap <C-w>  <C-g>u<C-w>
inoremap <C-u>  <C-g>u<C-u>
"}}}

" Command-line mode keymappings:"{{{
" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
" <C-y>: paste.
cnoremap <C-y>          <C-r>*
" <C-g>: Exit.
cnoremap <C-g>          <C-c>
"}}}

" [Space]: Other useful commands "{{{
" Smart space mapping.
nmap  <Space>   [Space]
nnoremap  [Space]   <Nop>

" Toggle relativenumber.
" Set autoread.
nnoremap [Space]ar
      \ :<C-u>call vimrc#toggle_option('autoread')<CR>
" Set spell check.
nnoremap [Space]p
      \ :<C-u>call vimrc#toggle_option('spell')<CR>
      \: set spelllang=en_us<CR>
      \: set spelllang+=cjk<CR>
nnoremap [Space]w
      \ :<C-u>call vimrc#toggle_option('wrap')<CR>

" Easily edit .vimrc
nnoremap <silent> [Space]ev  :<C-u>edit $MYVIMRC<CR>

" Useful save mappings.
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>

" s: Windows and buffers(High priority) "{{{
" The prefix key.
nnoremap    [Window]   <Nop>
nmap    s [Window]
nnoremap <silent> [Window]p  :<C-u>vsplit<CR>:wincmd w<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> <Tab>      :wincmd w<CR>
nnoremap <silent><expr> q winnr('$') != 1 ? ':<C-u>close<CR>' : ""
"}}}

" e: Change basic commands "{{{
" The prefix key.
nnoremap [Alt]   <Nop>
nmap    e  [Alt]

" Indent paste.
nnoremap <silent> [Alt]p o<Esc>pm``[=`]``^
nnoremap <silent> [Alt]P O<Esc>Pm``[=`]``^
"}}}

" Better x
nnoremap x "_x

" Disable Ex-mode.
nnoremap Q  q

" Useless command.
nnoremap M  m

" Smart <C-f>, <C-b>.
noremap <expr> <C-f> max([winheight(0) - 2, 1])
      \ . "\<C-d>" . (line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
      \ . "\<C-u>" . (line('w0') <= 1 ? "H" : "M")

" Disable ZZ.
nnoremap ZZ  <Nop>

" Select rectangle.
xnoremap r <C-v>

" Redraw.
nnoremap <silent> <C-l>    :<C-u>redraw!<CR>

" If press l on fold, fold open.
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" If press l on fold, range fold open.
xnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

" Substitute.
xnoremap s :s//g<Left><Left>

" Sticky shift in English keyboard."{{{
" Sticky key.
inoremap <expr> ;  vimrc#sticky_func()
cnoremap <expr> ;  vimrc#sticky_func()
snoremap <expr> ;  vimrc#sticky_func()
"}}}

" Easy escape."{{{
inoremap jj           <ESC>
cnoremap <expr> j
      \ getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'

inoremap j<Space>     j
"}}}

" a>, i], etc... "{{{
" <angle>
onoremap aa  a>
xnoremap aa  a>
onoremap ia  i>
xnoremap ia  i>

" [rectangle]
onoremap ar  a]
xnoremap ar  a]
onoremap ir  i]
xnoremap ir  i]

" 'quote'
onoremap aq  a'
xnoremap aq  a'
onoremap iq  i'
xnoremap iq  i'

" "double quote"
onoremap ad  a"
xnoremap ad  a"
onoremap id  i"
xnoremap id  i"
"}}}

" Clear highlight.
nnoremap <ESC><ESC> :nohlsearch<CR>:match<CR>

" Improved increment.
nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
command! -range -nargs=1 AddNumbers
      \ call vimrc#add_numbers((<line2>-<line1>+1) * eval(<args>))

nnoremap <silent> #    <C-^>

""" my
"" key bindings
"nnoremap + <C-a>
"nnoremap - <C-x>
"nmap <C-e> :!eijiro <C-R><C-W><CR>
"nmap ,man :!man -S 2,3,1,4,5,6,7,8,9 <C-R><C-W><CR>
"map ,cd :cd %:p:h<CR>
""nmap <C-N><C-N> :set invnumber<CR>
"nmap ,last '0
"nmap ,msession :mksession $HOME/etc/session.vim<CR>
"nmap ,rsession :source $HOME/etc/session.vim<CR>
"nmap . .`[
"
"" move between function
"map [[ ?{<CR>w99[{
"map ][ /}<CR>b99]}
"map ]] j0[[%/{<CR>
"map [] k$][%?}<CR>
"
"" ctags with screen (C-t key binding)
"nmap <c-\[> :pop<CR>
"
"" short command name
"command! MK make
"command! MKC make clean
"command! MKI make install-files
"command! GF execute "Gtags -f " . expand("%:~:.")
"command! RS %s/\s\+$//
"if has("ruby")
"  command! -nargs=+ Calc :ruby print <args>
"  ruby include Math
"endif
"
"" Don't exit vim when closing last tab with :q and :wq, :qa, :wqa
"cabbrev q   <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 && tabpagenr('$') == 1 && winnr('$') == 1 ? 'enew' : 'q')<CR>
"cabbrev wq  <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 && tabpagenr('$') == 1 && winnr('$') == 1 ? 'w\|enew' : 'wq')<CR>
"cabbrev qa  <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'tabonly\|only\|enew' : 'qa')<CR>
"cabbrev wqa <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'wa\|tabonly\|only\|enew' : 'wqa')<CR>
