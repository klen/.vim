" Overide session dir
let g:session_dir = '.vim'

" Load last local session
au VimEnter * :call SessionRead('last')

set tags+=.vim/ctags

function! MyUpdateIdeCtags()
    silent !ctags --languages=Python -f .vim/ctags -R --tag-relative=yes .
endfunction

let MyUpdateCtagsFunction = "MyUpdateIdeCtags"

call {MyUpdateCtagsFunction}()

au BufWritePost *.py :call {MyUpdateCtagsFunction}()
