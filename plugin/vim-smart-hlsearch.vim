" Description   : Smart highlight search and jump
" Maintainer    : lwflwf1
" Website       : https://github.com/lwflwf1/
" Created Time  : 2021-04-24 13:17:59
" Last Modified : 2021-04-29 15:19:52
" File          : smart-hlsearch.vim
" Version       : 0.1.0
" License       : MIT

set hlsearch
let s:jump_post = 'zvzz'
function s:wrapper(action) abort
    if mode() ==# 'c' 
    \ && !(getcmdtype() =~# '[/?]'
    \ || (getcmdtype() ==# ':' && match(getcmdline()[0:1], '[/?]') !=# -1))
        return a:action
    endif
    silent! autocmd! nohlsearch_group
    silent! autocmd! nohlsearch_on_insert_leave
    " if a:action ==? "\<esc>"
    "     let s:jump_post = ''
    " endif
    return a:action."\<Plug>(jump-after)"

endfunction

function s:jump_after() abort
    augroup nohlsearch_group
        autocmd!
        " autocmd InsertEnter * call s:nohlsearch_on_insert_leave() | autocmd! nohlsearch_group
        autocmd InsertEnter * call feedkeys("\<c-o>:\<c-u>nohlsearch\<cr>") | autocmd! nohlsearch_group
        autocmd CursorMoved * call feedkeys(":\<c-u>nohlsearch\<cr>") | autocmd! nohlsearch_group
    augroup END

    return s:jump_post
endfunction

" function s:nohlsearch_on_insert_leave() abort
"     augroup nohlsearch_on_insert_leave_group
"         autocmd!
"         autocmd InsertLeave * call feedkeys(":\<c-u>nohlsearch\<cr>") | autocmd! nohlsearch_on_insert_leave_group
"     augroup END
" endfunction

nnoremap <expr> <Plug>(jump-after) <SID>jump_after()
nmap <expr> n <SID>wrapper('n')
nmap <expr> N <SID>wrapper('N')
nmap <expr> * <SID>wrapper('*')
nmap <expr> # <SID>wrapper('#')
nmap <expr> g* <SID>wrapper('g*')
nmap <expr> g# <SID>wrapper('g#')
cmap <expr> <cr> <SID>wrapper("\<cr>")
