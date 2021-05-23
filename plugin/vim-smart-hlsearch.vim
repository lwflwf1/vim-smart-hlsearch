" Description   : Smart highlight search and jump
" Maintainer    : lwflwf1
" Website       : https://github.com/lwflwf1/vim-smart-hlsearch
" Created Time  : 2021-04-24 13:17:59
" Last Modified : 2021-05-23 16:01:29
" File          : vim-smart-hlsearch.vim
" Version       : 0.1.4
" License       : MIT

if exists("g:loaded_smart_hlsearch")
    finish
endif

let g:loaded_smart_hlsearch = 1

let s:save_cpo = &cpo
set cpo&vim

let g:smart_hlsearch_jump_post = get(g:, 'smart_hlsearch_jump_post', 'zvzz')

nnoremap <expr> <Plug>(jump-after) smart_hlsearch#jump_after()
nmap <expr> n smart_hlsearch#wrapper('n')
nmap <expr> N smart_hlsearch#wrapper('N')
nmap <expr> * smart_hlsearch#wrapper('*')
nmap <expr> # smart_hlsearch#wrapper('#')
nmap <expr> g* smart_hlsearch#wrapper('g*')
nmap <expr> g# smart_hlsearch#wrapper('g#')
cmap <expr> <cr> smart_hlsearch#wrapper("\<cr>")

let &cpo = s:save_cpo
unlet s:save_cpo
" FIXME: when input a wrong g/ command(g/abc/yy), can not auto stop hlsearch
