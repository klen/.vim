" Overide session dir
" let g:session_dir = '.vim'
" if expand('%') == ''
    " " Load last local session
    " au VimEnter * :call SessionRead('last')
" endif

fun! s:MyUpdateCtags()
    silent !ctags -f .vim/tags -R --tag-relative=yes .
endfun

if getfsize('.vim/tags') < 0
    call s:MyUpdateCtags()
endif

set tags+=.vim/tags

au BufWritePost * :call s:MyUpdateCtags()
