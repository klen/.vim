" Vim plugin to save and retrieve sessions
 
" Usage:
" Save default session
" :Ssave<cr>
" Read default session
" :Sread<cr>
" Read last session
" :Slast<cr>
" Show list sessions
" :Slist<cr>
"
" Save named session
" :Ssave "session_name"
" Read named session
" :Sread "session_name"

if !has('mksession') || exists('g:sessions_loaded')
    finish
endif
let g:sessions_loaded = 1

if !exists('g:sessions_auto_save')
    let g:sessions_auto_save = 1
endif

let g:current_session= "default"
let g:last_session= "last"

set sessionoptions=blank,curdir,buffers,tabpages
 
if finddir($HOME.'/.data/') == ''
    silent call mkdir($HOME.'/.data/')
endif
if finddir($HOME.'/.data/sessions') == ''
    silent call mkdir($HOME.'/.data/sessions')
endif

fun! SessionSave(...)
    if a:0 > 0
            call SessionChange(a:1)
    endif
    call SessionSaveCurrent()
endfun
 
fun! SessionSaveCurrent()
    exe "mks! " SessionGetFile(g:current_session)
    echo "Session" g:current_session "saved"
endfun
 
fun! SessionChange(session_name)
    if a:session_name == ''
    else
        let g:current_session= a:session_name
    endif
endfun
 
fun! SessionRead(...)
    if a:0 > 0
            call SessionChange(a:1)
    endif
    call SessionReadCurrent()	
endfun
 
fun! SessionReadCurrent()
    echo "reading" g:current_session
    exe "source " SessionGetFile(g:current_session)
endfun
 
fun! SessionGetFile(session_name)
    return "~/.data/sessions/" . a:session_name . ".session"
endfun

fun! NFH_session(filename)
    exe "source " a:filename
endfun

command Ssave :call SessionSave(<args>)
command Sread :call SessionRead(<args>)
command Slast :call SessionRead('last')
command Slist :Vex ~/.data/sessions/

" Auto save last session
if g:sessions_auto_save == 1
    au VimLeavePre * :call SessionSave('last')
endif
