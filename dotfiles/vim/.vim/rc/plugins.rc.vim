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

"" unite.vim
if neobundle#tap('unite.vim') " {{{
  call neobundle#config({
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

  function! neobundle#tapped.hooks.on_source(bundle)
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

  call neobundle#untap()
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
if neobundle#tap('vimfiler') " {{{
  call neobundle#config({
        \   'autoload' : {
        \     'commands' : [
        \       'VimFilerBufferDir'
        \     ]
        \   }
        \ })

  call neobundle#untap()
endif " }}}

"" YankRing.vim
if neobundle#tap('YankRing.vim') " {{{
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:yankring_replace_n_pkey = ',yp'
    let g:yankring_replace_n_nkey = ',yn'
  endfunction

  nmap ,ys :YRShow<CR>

  call neobundle#untap()
endif " }}}
