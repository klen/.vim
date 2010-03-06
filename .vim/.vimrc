" Show numbers
set number

" Overide session dir
let g:session_dir = '.vim'
if expand('%') == ''
    " Load last local session
    au VimEnter * :call SessionRead('last')
endif

