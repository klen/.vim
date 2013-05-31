if !exists('g:statusline_max_path')
    let g:statusline_max_path = 20
endif

fun! statusline#path() "{{{
    if &buftype == ''
        let p = simplify(substitute(expand('%:p'), '^\V' . $HOME, '~', ''))
        if len(p) > g:statusline_max_path
            return pathshorten(p)
        endif
        return p
    endif
    return ''
endfunction "}}}

fun! statusline#mode() "{{{
    let l:mode = mode()

    if     mode ==# "n"  | return "NORMAL"
    elseif mode ==# "i"  | return "INSERT"
    elseif mode ==# "R"  | return "REPLACE"
    elseif mode ==# "v"  | return "VISUAL"
    elseif mode ==# "V"  | return "V-LINE"
    elseif mode ==# "^V" | return "V-BLOCK"
    else                 | return l:mode
    endif 
endfunction "}}}

fun! statusline#modechanged(mode) "{{{

    if     a:mode ==# "n"  | hi User1 guifg=#000000 guibg=#7dcc7d gui=NONE ctermfg=0 ctermbg=2 cterm=NONE
    elseif a:mode ==# "i"  | hi User1 guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold
    elseif a:mode ==# "r"  | hi User1 guifg=#ffff00 guibg=#5b7fbb gui=bold ctermfg=190 ctermbg=67 cterm=bold
    else                   | hi User1 guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15 ctermbg=53 cterm=NONE
    endif

endfunction "}}}


fun! statusline#set(full) "{{{
    let b:SLPath = statusline#path()
    let b:SLTerm = ':'.&tenc
    let b:SLAppend = ''

    if !&fenc || &tenc == &fenc
        let b:SLTerm = ''
    endif

    " Git support
    if exists('*fugitive#statusline')
        let b:SLAppend = b:SLAppend . fugitive#statusline()
    endif

    if !a:full || &buftype != ''
        return statusline#setSimple()
    endif

    return statusline#setFull()

endfunction "}}}


fun! statusline#synId() "{{{
    return synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction "}}}


fun! statusline#imiinsert() "{{{
    if &iminsert
        if !exists('b:keymap_name')
            return '[map]'
        endif
        return '['. b:keymap_name . ']'
    endif
    return ''
endfunction "}}}


fun! statusline#setFull() "{{{
    setlocal statusline = 
    setlocal statusline +=%#User4#%n                                        " buffer number
    " setlocal statusline +=%#User1#\ %{statusline#mode()}\                   " buffer mode
    setlocal statusline +=%#StatuslinePath#%{b:SLPath}                      " path
    setlocal statusline +=%#StatuslineFlag#%m                               " modify flag
    setlocal statusline +=\ %<%#StatuslineFlag#%y%w%#Error#%r               " other flags

    setlocal statusline +=%#StatuslineFileEnc#\ %{&fenc}                   " file encoding
    setlocal statusline +=%#StatuslineTermEnc#%{b:SLTerm}                  " encoding

    setlocal statusline +=%#StatuslineSyn#\ %{statusline#synId()}          " syn item
    setlocal statusline +=%#StatuslineChar#\ [%2B]                         " current char
    setlocal statusline +=%#StatuslineAppend#\ %{b:SLAppend}               " current char

    setlocal statusline +=%=
    setlocal statusline +=%#Error#%{statusline#imiinsert()}%#Statusline#   " keymap
    setlocal statusline +=\ \%-10.(%c%Vx%l%)                               " position
    setlocal statusline +=\ %P                                             " position percentage
endfunction "}}}


fun! statusline#setSimple() "{{{
    setlocal statusline =%#StatuslineNC#                                   " color
    setlocal statusline +=%n:                                              " buffer number
    setlocal statusline +=%#StatuslinePath#%{b:SLPath}                     " path
    setlocal statusline +=%#StatuslineFlag#%m                              " modify flag
    setlocal statusline +=\ %<%#StatuslineFlag#%y%w%#Error#%r              " other flags
    setlocal statusline +=%#StatuslineNC#                                  " color
    setlocal statusline +=%=
    setlocal statusline +=\ %P                                             " position percentage
endfunction "}}}
