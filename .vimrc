" show numbers
set nu

" Save current session
au VimLeavePre * :call SessionSave('vim')
au VimEnter * :call SessionRead('vim')
