" Vim compiler file for Python
" Compiler:     Style checking tool for Python
" Maintainer:   Oleksandr Tymoshenko <gonzo@univ.kiev.ua>
" Last Change:  2009 Dec 5
" Version:      0.6 
" Contributors:
"     Artur Wroblewski
"     Menno
"     Jose Blanca
"
" Installation:
"   Drop pylint.vim in ~/.vim/compiler directory. Ensure that your PATH
"   environment variable includes the path to 'pylint' executable.
"
"   Add the following line to the autocmd section of .vimrc
"
"      autocmd FileType python compiler pylint
"
" Usage:
"   Pylint is called after a buffer with Python code is saved. QuickFix
"   window is opened to show errors, warnings and hints provided by Pylint.
"   Code rate calculated by Pylint is displayed at the bottom of the
"   window.
"
"   Above is realized with :Pylint command. To disable calling Pylint every
"   time a buffer is saved put into .vimrc file
"
"       let g:pylint_onwrite = 0
"
"   Openning of QuickFix window can be disabled with
"
"       let g:pylint_cwindow = 0
"
"   Setting signs for the lines with errors can be disabled with
"
"	let g:pylint_signs = 0
"
"   Of course, standard :make command can be used as in case of every
"   other compiler.
"
 
 
if exists('current_compiler')
  finish
endif
let current_compiler = 'pylint'
 
if !exists('g:pylint_onwrite')
    let g:pylint_onwrite = 1
endif
 
if !exists('g:pylint_cwindow')
    let g:pylint_cwindow = 1
endif
 
if !exists('g:pylint_signs')
    let g:pylint_signs = 1
endif
 
if exists(':Pylint') != 2
    command Pylint :call Pylint(0)
endif
 
set makeprg=python\ /usr/bin/pylint\ --reports=n\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ [%t]\ %m
 
""sings
"signs definition
sign define W text=WW texthl=pylint
sign define C text=CC texthl=pylint
sign define E text=EE texthl=pylint_error
 
if g:pylint_onwrite
    augroup python
        au!
        au BufWritePost *.py call Pylint(1)
    augroup end
endif
 
function! Pylint(writing)
    if !a:writing && &modified
        " Save before running
        write
    endif	
 
    if has('win32') || has('win16') || has('win95') || has('win64')
        setlocal sp=>%s
    else
        setlocal sp=>%s\ 2>&1
    endif
 
    " If check is executed by buffer write - do not jump to first error
    if !a:writing
        silent make
    else
        silent make!
    endif
 
    if g:pylint_cwindow
        cwindow
    endif
 
    if g:pylint_signs
        call PlacePylintSigns()
    endif
endfunction
 
function! PlacePylintSigns()
    "in which buffer are we?
    "in theory let l:buffr=bufname(l:item.bufnr)
    "should work inside the next loop, but i haven't manage to do it
    let l:buffr = bufname('%')
    "the previous lines are suppose to work, but sometimes it doesn't
    if empty(l:buffr)
        let l:buffr=bufname(1)
    endif
 
    "first remove all sings
    exec('sign unplace *')
    "now we place one sign for every quickfix line
    let l:list = getqflist()
    let l:id = 1
    for l:item in l:list
	"the line signs
	let l:lnum=item.lnum
	let l:type=item.type
	"sign place 1 line=l:lnum name=pylint file=l:buffr
	if l:type != 'I'
	    let l:exec = printf('sign place %d name=%s line=%d file=%s', l:id,
                        \ l:type, l:lnum, l:buffr)
	    let l:id = l:id + 1
	    execute l:exec
	endif
    endfor
endfunction
