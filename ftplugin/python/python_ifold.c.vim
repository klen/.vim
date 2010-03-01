" Vim folding file
" Language:	Python
" Author:	Jorrit Wiersma (foldexpr), Max Ischenko (foldtext), Robert,
" Ames (line counts), Jean-Pierre Chauvel (bugfixes and improvements)
" Last Change:	2008 Apr 20
" Version:	2.9.c
" Bugfixes: Jean-Pierre Chauvel


if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1 

if !exists("g:ifold_mode")
    let g:ifold_mode = 1
endif

map <buffer> f :call ToggleFold()<CR> 

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set foldcolumn=1

let w:nestinglevel = 0
let w:signature = 0
let w:is_folded = 1

function! PythonFoldText()
    let line = getline(v:foldstart)
    let nnum = nextnonblank(v:foldstart + 1)
    let nextline = getline(nnum)
    if nextline =~ '^\s\+"""$'
        let line = line . getline(nnum + 1)
    elseif nextline =~ '^\s\+"""'
        let line = line . ' ' . matchstr(nextline, '"""\zs.\{-}\ze\("""\)\?$')
    elseif nextline =~ '^\s\+"[^"]\+"$'
        let line = line . ' ' . matchstr(nextline, '"\zs.*\ze"')
    elseif nextline =~ '^\s\+pass\s*$'
        let line = line . ' pass'
    endif
    let size = 1 + v:foldend - v:foldstart
    if size < 10
        let size = " " . size
    endif
    if size < 100
        let size = " " . size
    endif
    if size < 1000
        let size = " " . size
    endif
        return size . " lines: " . line
endfunction

function! GetPythonFold(lnum)
    let line = getline(a:lnum - 1)

    " Classes and functions get their own folds
    if line =~ '^\s*\(class\|def\)\s'
    " Verify if the next line is a class or function definition
    " as well
        let imm_nnum = a:lnum + 1
        let nnum = nextnonblank(imm_nnum)
        if nnum - imm_nnum < 2
            let nind = indent(nnum)
            let pind = indent(a:lnum - 1)
            if pind >= nind
                let nline = getline(nnum)
                let w:nestinglevel = nind
                return "<" . ((w:nestinglevel + &sw) / &sw)
            endif
        endif
        let w:nestinglevel = indent(a:lnum - 1)
        return ">" . ((w:nestinglevel + &sw) / &sw)
    endif

    " If next line has less or equal indentation than the first one,
    " we end a fold.
    let nind = indent(nextnonblank(a:lnum + 1))
    if nind <= w:nestinglevel
        let w:nestinglevel = nind
        return "<" . ((w:nestinglevel + &sw) / &sw)
    else
        let ind = indent(a:lnum)
        if ind == (w:nestinglevel + &sw)
            if nind < ind
                let w:nestinglevel = nind
                return "<" . ((w:nestinglevel + &sw) / &sw)
            endif
        endif
    endif

    " If none of the above apply, keep the indentation
    return "="
endfunction

function! GetPythonFoldBest(lnum)
    " Determine folding level in Python source
    "
    let line = getline(a:lnum - 1)

    " Handle Support markers
    if line =~ '{{{'
        return "a1"
    elseif line =~ '}}}'
        return "s1"
    endif

    " Classes and functions get their own folds
      if line =~ '^\s*\(class\|def\)\s'
    " Verify if the next line is a class or function definition
    " as well
        let imm_nnum = a:lnum + 1
        let nnum = nextnonblank(imm_nnum)
        let nind = indent(nnum)
        let pind = indent(a:lnum - 1)
        if pind >= nind
            let nline = getline(nnum)
            let w:nestinglevel = nind
            return "<" . ((w:nestinglevel + &sw) / &sw)
        endif
        let w:nestinglevel = indent(a:lnum - 1)
        return ">" . ((w:nestinglevel + &sw) / &sw)
    endif

    " If next line has less or equal indentation than the first one,
    " we end a fold.
    let nnonblank = nextnonblank(a:lnum + 1)
    let nextline = getline(nnonblank) 
    if (nextline !~ '^#\+.*')
        let nind = indent(nnonblank)
        if nind <= w:nestinglevel
            let w:nestinglevel = nind
            return "<" . ((w:nestinglevel + &sw) / &sw)
        else
            let ind = indent(a:lnum)
            if ind == (w:nestinglevel + &sw)
                if nind < ind
                    let w:nestinglevel = nind
                    return "<" . ((w:nestinglevel + &sw) / &sw)
                endif
            endif
        endif
    endif

    " If none of the above apply, keep the indentation
    return "="
endfunction

function! GetPythonFoldExperimental(lnum)
    " Determine folding level in Python source
    "
    let line = getline(a:lnum - 1)

    " Handle suport markers
    if line =~ '{{{'
        return "a1"
    elseif line =~ '}}}'
        return "s1"
    endif

    " Classes and functions get their own folds
      if line =~ '^\s*\(class\|def\)\s'
    " Verify if the next line is a class or function definition
    " as well
        let imm_nnum = a:lnum + 1
        let nnum = nextnonblank(imm_nnum)
        let nind = indent(nnum)
        let pind = indent(a:lnum - 1)
        if pind >= nind
            let nline = getline(nnum)
            let w:nestinglevel = nind
            return "<" . ((w:nestinglevel + &sw) / &sw)
        endif
        let w:signature = 1
        let w:nestinglevel = indent(a:lnum - 1)
    endif

    if line =~ '^.*:' && w:signature
        let w:signature = 0
        return ">" . ((w:nestinglevel + &sw) / &sw)
    endif

    " If next line has less or equal indentation than the first one,
    " we end a fold.
    let nnonblank = nextnonblank(a:lnum + 1)
    let nextline = getline(nnonblank) 
    if (nextline !~ '^#\+.*')
        let nind = indent(nnonblank)
        if nind <= w:nestinglevel
            let w:nestinglevel = nind
            return "<" . ((w:nestinglevel + &sw) / &sw)
        else
            let ind = indent(a:lnum)
            if ind == (w:nestinglevel + &sw)
                if nind < ind
                    let w:nestinglevel = nind
                    return "<" . ((w:nestinglevel + &sw) / &sw)
                endif
            endif
        endif
    endif

    " If none of the above apply, keep the indentation
    return "="
endfunction

function! ToggleFold()
    let w:nestinglevel = 0
    let w:signature = 0
    if w:is_folded
        set foldexpr=0
        let w:is_folded = 0
    else
        call ReFold()
        " Open the fold we are in
        exec 'norm! zO'
        let w:is_folded = 1
    endif
endfunction

" In case folding breaks down
function! ReFold()
    set foldmethod=expr
    set foldexpr=0
    set foldmethod=expr
    if g:ifold_mode == 0
        set foldexpr=GetPythonFold(v:lnum)
    else
        if g:ifold_mode == 1
            set foldexpr=GetPythonFoldBest(v:lnum)
        else
            if g:ifold_mode == 2
                set foldexpr=GetPythonFoldExperimental(v:lnum)
            endif
        endif
    endif

    if g:ifold_mode
        set foldtext=PythonFoldText()
    else
        set foldtext='Folded\ code'
    endif
    echo
endfunction

call ReFold()
