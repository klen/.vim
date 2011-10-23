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


fun! statusline#set() "{{{
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

    if &buftype == ''
        return statusline#setFull()
    endif

    return statusline#setSimple()

endfunction "}}}


fun! statusline#synId() "{{{
    return synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction "}}}


fun! statusline#setFull() "{{{
    setlocal statusline =%#StatuslineBufNr#
    setlocal statusline +=%n:                                              " buffer number
    setlocal statusline +=%#StatuslinePath#%{b:SLPath}                     " path
    setlocal statusline +=%#StatuslineFlag#%m                              " modify flag
    setlocal statusline +=\ %<%#StatuslineFlag#%y%w%#Error#%r              " other flags

    setlocal statusline +=%#StatuslineFileEnc#\ %{&fenc}                   " file encoding
    setlocal statusline +=%#StatuslineTermEnc#%{b:SLTerm}                  " encoding

    setlocal statusline +=%#StatuslineSyn#\ %{statusline#synId()}             " syn item
    setlocal statusline +=%#StatuslineChar#\ [%2B]                         " current char
    setlocal statusline +=%#StatuslineAppend#\ %{b:SLAppend}               " current char

    setlocal statusline +=%=
    setlocal statusline +=\ \%-10.(%lx%c%V%)                               " position
    setlocal statusline +=\ %P                                             " position percentage
endfunction "}}}


fun! statusline#setSimple() "{{{
    setlocal statusline =%#StatuslineNC#                                   " color
    setlocal statusline +=%n:                                              " buffer number
    setlocal statusline +=%#StatuslinePath#%{b:SLPath}                     " path
    setlocal statusline +=%#StatuslineFlag#%m                              " modify flag
    setlocal statusline +=\ %<%#StatuslineFlag#%y%w%#Error#%r              " other flags
    setlocal statusline +=%#StatuslineNC#                                  " color
endfunction "}}}
