set laststatus=2

if !exists('g:statusline')
    let g:statusline = 1
endif

if g:statusline
    augroup Statusline
        au! Statusline
        au BufEnter * call statusline#set(1)
        au BufLeave,BufNew,BufRead,BufNewFile * call statusline#set(0)
    augroup END
endif
