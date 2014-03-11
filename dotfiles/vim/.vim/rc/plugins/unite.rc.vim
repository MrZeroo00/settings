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
