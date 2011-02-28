" pydoc.vim 0.4 (initial public version)
" Allow the user to pull pydoc information into Vim
" Mike Repass <theopenroad@gmail.com>
" October 2004

" USAGE:
" Put this in ftplugin/python/ or just manually source it using a FileType
" autocommand in your vimrc. It registers the command Pydoc (try ':Pydoc re'
" for regular expression docs). Also, it remaps K so that you can position the
" cursor over a module or module.method etc and hit K to bring up the docs.
" Make sure PYDOC_CMD points to the pydoc script. I use a 'pydoc.bat' batch
" file on my WinXP system.
"
" A nice little side effect of using this is that the documentation buffers
" become sources for keyword completion. For instance, say you're working on a
" program that uses urllib2 and you're having trouble remembering the methods.
" Simply do a ':Pydoc urllib2' and close the window. The buffer will remain
" hidden and Ctrl-N and Ctrl-P will pick up all the text when you need to
" complete.
"
" Btw just doing ':Pydoc modules' should bring up a list of all available
" modules. Very handy just to leave open, as you can now just press 'K' over a
" module to load it up.

" NOTES:
" The 'cleanest' or most 'pythonic' way to do this would be use the
" vim-python interface and write some supporting python code to manually
" import pydoc and call the associated functions. However, I don't always use
" the version of python for which my vim is compiled, so I decided to
" externally call the pydoc script.  Also, it sets up the buffers to go
" 'hidden' when closed, so that when you do the same Pydoc command again, it
" will load the buffer and thus avoid the overhead of the external call
" (basically a cheap cache system). If you don't want this, set the NO_HIDE
" option to 1.

" BUGS:
" I am not aware of any major bugs, but of course there are some minor
" interface glitches. For instance, if you put the cursor over an operator
" which also has significance in your particular shell, invoking the command
" might result in a shell error. I feel having some little 'oopses' like this
" is pretty inevitable, but I'll be happy to work on anything that causes you
" problems. If you come across any bug you feel impairs your ability to use
" Vim, drop me an email and I'll get right on it.

" OPTIONS:
let s:PYDOC_CMD = "pydoc" " this must point to the pydoc script
let s:NO_HIDE = 1 " when 1, pydoc buffers will be deleted (instead of hidden)

" command interface
com! -nargs=+ Pydoc call <SID>:PydocLoad("<args>")

" remap the K (or 'help') key
nnoremap <silent> <buffer> K :call <SID>:KeyPydocLoad(expand("<cWORD>"))<Cr>

" prepares the cWORD argument for PydocLoad...
func! <SID>:KeyPydocLoad(cword)
	" make sure we got something
	if a:cword == ""
		return
	endif
	" we want the current WORD just up to the first parenthesis
	" this allows us to get math.acos from math.acos(.2) etc
	let prep = substitute(a:cword, "\(.*", "", "")
	call <SID>:PydocLoad(prep)
endfunc

" opens a new buffer, filling it with the result of calling pydoc with pyargs
func! <SID>:PydocLoad(pyargs)
	" first, check if we've already loaded the pydoc info for this search and
	" if so, open it and bail... this creates an ad hoc caching mechanism
" 	let window_name = "pydoc\ -\ " . a:pyargs
    let window_name = "__doc__"
	if bufloaded(window_name)
		exec "new " . window_name
		return
	endif

	" build and execute the command
"     let cmd = "new " . escape(window_name, " ")
"     let cmd = cmd . " | r!" . escape(s:PYDOC_CMD, " ")
    let cmd = "new __doc__ | r!" . escape(s:PYDOC_CMD, " ")
    let cmd = cmd . " " . escape(a:pyargs, " ")

	try
		silent exec cmd
	catch
		redraw |
		\ echohl WarningMSG |
		\ echomsg "Error occurred while attempting to invoke Pydoc." |
		\ echohl None
		return
	endtry


	" make sure the command succeeded and we're in the right buffer
	if bufname("") != "__doc__"
		" hmmm something didn't work... lets bail
		return
	endif

	" roll back, delete empty lines at beginning
	normal gg
	while getline(1) =~ "^\s\*$"
		normal dd
	endwhile

	" set some convenient options to avoid error messages etc
	setlocal nomodifiable
	setlocal buftype=nowrite
	setlocal bufhidden=hide
	if s:NO_HIDE
		setlocal bufhidden=delete
	endif

	" bail if no documentation was found
	if getline(1) =~ "^no Python documentation found"
		redraw |
			\ echohl WarningMsg |
			\ echomsg "No Python documentation for " . a:pyargs |
			\ echohl None
		setlocal bufhidden=delete
		quit
		return
	endif

    if winheight(0) > line('$')
        exec "resize " . line('$')
    endif

	" key map to these functions for these buffers
	nnoremap <silent> <buffer> K :call <SID>:KeyPydocLoad(expand("<cWORD>"))<Cr>

	" some _very_ basic syntax highlighting
	syn match pydocTitle "^[A-Z]\+$"
	hi link pydocTitle Tag

endfunc
