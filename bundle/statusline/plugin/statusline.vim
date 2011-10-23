set laststatus=2

if !exists('g:statusline')
    let g:statusline = 1
endif

if g:statusline
    augroup Statusline
        au! Statusline
        au BufEnter * call statusline#set()
        au BufLeave,BufNew,BufRead,BufNewFile * call statusline#setSimple()
    augroup END
endif
