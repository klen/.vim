set laststatus=2

if exists('g:statusline')
    finish
endif

let g:statusline = 1

 " Basic color presets
hi User1 guifg=#000000  guibg=#7dcc7d   ctermfg=0  ctermbg=2    " BLACK ON GREEN
hi User2 guifg=#ffffff  guibg=#5b7fbb   ctermfg=15 ctermbg=67   " WHITE ON BLUE
hi User3 guifg=#000000  guibg=#FF0000   ctermfg=15 ctermbg=9    " BLACK ON ORANGE
hi User4 guifg=#ffffff  guibg=#810085   ctermfg=15 ctermbg=53   " WHITE ON PURPLE
hi User5 guifg=#ffffff  guibg=#000000   ctermfg=15 ctermbg=0    " WHITE ON BLACK
hi User6 guifg=#ffffff  guibg=#ff00ff   ctermfg=15 ctermbg=5    " WHITE ON PINK
hi User7 guifg=#ff00ff  guibg=#000000   ctermfg=207 ctermbg=0 gui=bold cterm=bold   " PINK ON BLACK
hi User8 guifg=#000000  guibg=#00ffff   ctermfg=0 ctermbg=51 gui=bold cterm=bold    " BLACK ON CYAN

augroup Statusline
    au! Statusline
    au BufEnter * call statusline#set(1)
    au BufLeave,BufNew,BufRead,BufNewFile * call statusline#set(0)
    au InsertEnter * call statusline#modechanged(v:insertmode)
    au InsertChange * call statusline#modechanged(v:insertmode)
    au InsertLeave * call statusline#modechanged(mode())
augroup END
