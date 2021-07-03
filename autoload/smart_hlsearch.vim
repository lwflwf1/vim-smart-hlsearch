" Description   : autoload vim-smart-hlsearch
" Maintainer    : lwflwf1
" Website       : https://github.com/lwflwf1/vim-smart-hlsearch
" Created Time  : 2021-04-29 15:28:30
" Last Modified : 2021-07-04 01:09:25
" File          : vim-smart-hlsearch.vim
" Version       : 0.1.5
" License       : MIT

function! smart_hlsearch#wrapper(action) abort
    if mode() ==# 'c'
    \ && !(getcmdtype() =~# '[/?]'
    \ || (getcmdtype() ==# ':' && match(getcmdline()[0:7], '[/?]') !=# -1))
        return a:action
    endif
    silent! autocmd! nohlsearch_group
    silent! autocmd! nohlsearch_on_insert_leave
    " if a:action ==? "\<esc>"
    "     let s:jump_post = ''
    " endif
    return a:action."\<Plug>(jump-after)"

endfunction

function! smart_hlsearch#jump_after() abort
    augroup nohlsearch_group
        autocmd!
        " autocmd InsertEnter * call s:nohlsearch_on_insert_leave() | autocmd! nohlsearch_group
        autocmd InsertEnter * call feedkeys("\<c-o>:\<c-u>nohlsearch\<cr>") | autocmd! nohlsearch_group
        autocmd CursorMoved * call feedkeys(":\<c-u>nohlsearch\<cr>") | autocmd! nohlsearch_group
    augroup END

    return g:smart_hlsearch_jump_post
endfunction

" function! s:nohlsearch_on_insert_leave() abort
"     augroup nohlsearch_on_insert_leave_group
"         autocmd!
"         autocmd InsertLeave * call feedkeys(":\<c-u>nohlsearch\<cr>") | autocmd! nohlsearch_on_insert_leave_group
"     augroup END
" endfunction
