" Mines.vim: emulates a minefield
"   Author:		Charles E. Campbell, Jr.
"   Date:		Aug 06, 2009
"   Version:	17
" Copyright:    Copyright (C) 1999-2009 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like much else that's free,
"               Mines.vim is provided *as is* and comes with no warranty
"               of any kind, either expressed or implied. By using this
"               plugin, you agree that in no event will the copyright
"               holder be liable for any damages resulting from the use
"               of this software.
" GetLatestVimScripts: 551 1 :AutoInstall: Mines.vim
" GetLatestVimScripts: 1066 1 cecutil.vim
"
"  There is therefore now no condemnation to those who are in {{{1
"  Christ Jesus, who don't walk according to the flesh, but
"  according to the Spirit. (Rom 8:1 WEB)
"redraw!|call DechoSep()|call inputsave()|call input("Press <cr> to continue")|call inputrestore()
" ---------------------------------------------------------------------
"  Single Loading Only: {{{1
if &cp || exists("g:loaded_Mines")
 finish
endif
let g:loaded_Mines = "v17"
let s:keepcpo      = &cpo
set cpo&vim
"DechoTabOn

" ---------------------------------------------------------------------
"  Mining Variables: {{{1
let s:displayname = "-Mines-"
let s:savesession = tempname()
if !exists("g:mines_timer")
 let g:mines_timer= 1
endif
let s:mines_timer   = g:mines_timer
let s:timestart     = 0
let s:timestop      = 0
let s:timesuspended = 0
let s:MFmines       = 0

" ---------------------------------------------------------------------
"  Public Interface: {{{1

if !hasmapto('<Plug>EasyMines')
 nmap <unique> <Leader>mfe	<Plug>EasyMines
endif
nmap <silent> <script> <Plug>EasyMines	:set lz<CR>:call <SID>EasyMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>MedMines')
 nmap <unique> <Leader>mfm	<Plug>MedMines
endif
nmap <silent> <script> <Plug>MedMines	:set lz<CR>:call <SID>MedMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>HardMines')
 nmap <unique> <Leader>mfh	<Plug>HardMines
endif
nmap <silent> <script> <Plug>HardMines	:set lz<CR>:call <SID>HardMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>RestoreMines')
 nmap <unique> <Leader>mfr  <Plug>RestoreMines
endif
nmap <silent> <script> <Plug>RestoreMines	:set lz<CR>:call <SID>DisplayMines(0)<CR>:set nolz<CR>

if !hasmapto('<Plug>ToggleMineTimer')
 nmap <unique> <Leader>mft  <Plug>ToggleMineTimer
endif
nmap <silent> <script> <Plug>ToggleMineTimer	:set lz<CR>:let g:mines_timer= !g:mines_timer<CR>:set nolz<CR>

if !hasmapto('<Plug>SaveStatistics')
 nmap <unique> <Leader>mfc  <Plug>SaveStatistics
endif
nmap <silent> <script> <Plug>SaveStatistics	:set lz<CR>:call <SID>SaveStatistics(0)<CR>:set nolz<CR>

" =====================================================================
" Functions: {{{1

" ---------------------------------------------------------------------
" EasyMines: {{{2
"    Requires an 12x12 grid be displayable with 15% mines
fun! s:EasyMines()
"  let g:decho_hide= 1  "Decho
"  call Dfunc("EasyMines()")
  if s:SanityCheck()|return|endif
  let s:field = "E"
  call RndmInit()
  call MineFieldSettings(10,10,15*10*10/100,120)
"  call Dret("EasyMines")
endfun

" ---------------------------------------------------------------------
" MedMines: {{{2
"    Requires a 20x20 grid be displayable with 15% mines
fun! s:MedMines()
"  let g:decho_hide= 1  "Decho
"  call Dfunc("MedMines()")
  if s:SanityCheck()|return|endif
  let s:field = "M"
  call RndmInit()
  call MineFieldSettings(18,18,15*22*22/100,240)
"  call Dret("MedMines")
endfun

" ---------------------------------------------------------------------
" HardMines: {{{2{
"    Requies a 50x50 grid be displayable with 18% mines
fun! s:HardMines()
"  let g:decho_hide= 1  "Decho
"  call Dfunc("HardMines()")
  if s:SanityCheck()|return|endif
  let s:field = "H"
  call RndmInit()
  call MineFieldSettings(48,48,18*48*48/100,480)
"  call Dret("HardMines")
endfun

" ---------------------------------------------------------------------
"  SanityCheck: {{{2
fun! s:SanityCheck()
  if !exists("*RndmInit")
   rightb split
   enew
   setlocal bt=nofile
   put ='You need Rndm.vim!'
   put =' '
   put ='Rndm.vim is available at'
   put ='http://mysite.verizon.net/astronaut/vim/index.html#VimFuncs'
   let msg='as "Rndm"  (Rndm is what generates pseudo-random variates)'
   put =msg
   return 1
  endif
  return 0
endfun

" ---------------------------------------------------------------------
" MineFieldSettings: {{{2
"   Can be used to generate a custom-sized display.
"   The grid will be rows x cols big, plus 2 rows and columns for
"   the outline.
"   The third argument specifies how many mines will be placed into
"   the grid.  Arbitrarily I've selected that at least 1/3 of the
"   grid must be clear at the very least.
fun! MineFieldSettings(rows,cols,mines,timelapse)
"  call Dfunc("MineFieldSettings(rows=".a:rows.",cols=".a:cols.",mines=".a:mines.",timelapse=".a:timelapse.")")
  let s:MFrows    = a:rows
  let s:MFcols    = a:cols
  let s:MFmines   = a:mines
  let s:MFmaxtime = a:timelapse
  if s:MFmines >= s:MFrows*s:MFcols*2/3
   echoerr "Too many mines selected"
  else
   if s:InitMines()
    set nomod
"    call Dret("MineFieldSettings")
    return
   endif
  endif
  call s:MFSyntax()
  let s:timestart    = localtime()
  let s:timestop     = 0
  let s:timesuspended= 0
  let s:bombsflagged = 0
  let s:flagsused    = 0
  let s:marked       = 0
  let s:nobombs      = s:MFrows*s:MFcols- s:MFmines
  set nomod
"  call Dret("MineFieldSettings : timestart=".s:timestart." nobombs=".s:nobombs)
endfun

" ---------------------------------------------------------------------
" InitMines: {{{2
fun! s:InitMines()
"  call Dfunc("InitMines(".s:MFrows."x".s:MFcols." mines=".s:MFmines.")")
  if filereadable("-Mines-")
   redraw!
   echohl WarningMsg | echo "the <-Mines-> file already exists!" | echohl None
   sleep 2
"   call Dret("InitMines")
   return 1
  endif

  setlocal nomod ma
  call s:DisplayMines(1)
  call s:ToggleMineTimer(g:mines_timer)

  let s:keep_list   = &list
  let s:keep_gd     = &gd
  let s:keep_go     = &go
  let s:keep_fo     = &fo
  let s:keep_report = &report
  let s:keep_spell  = &spell
  setlocal nolist go-=aA fo-=a nogd report=10000 nospell

  " draw grid
"  call Decho("draw grid")
  let col= 1
  let line=":"
  while col <= s:MFcols
   let line= line . "	"
   let col = col + 1
  endwhile
  let line= line . ":"

  put =line
  s/././g
  norm! 1ggdd
  let row= 1
  while row <= s:MFrows
   put =line
   let row = row + 1
  endwhile
  put =line
  s/././g
  set nomod

  " clear the minefield
"  call Decho("clear minefield")
  let col= 1
  while col <= s:MFcols
   let row= 1
   while row <= s:MFrows
	let s:MF_{row}_{col} = '0'
	let row              = row + 1
   endwhile
	let col = col + 1
  endwhile

  " set mines into minefield
"  call Decho("set mines into minefield")
  let mines= 0
  while mines < s:MFmines
   let row  = Urndm(1,s:MFrows)
   let col  = Urndm(1,s:MFcols)
   if s:MF_{row}_{col} == '0'
    let mines            = mines + 1
    let s:MF_{row}_{col} = '*'
   endif
  endwhile

  " analyze minefield
"  call Decho("analyze minefield: ".s:MFrows."x".s:MFcols)
  let row= 1
  while row <= s:MFrows
   let col= 1
   while col <= s:MFcols
    if " ".s:MF_{row}_{col} != ' *'
     let row1 = <SID>RowLimit(row-1)
     let rowN = <SID>RowLimit(row+1)
     let col1 = <SID>ColLimit(col-1)
     let colN = <SID>ColLimit(col+1)
     let cnt  = 0
     let irow = row1
     while irow <= rowN
      let icol= col1
      while icol <= colN
       if " ".s:MF_{irow}_{icol} == ' *'
        let cnt= cnt + 1
"		call Decho("  (".irow.",".icol.")")
       endif
       let icol= icol + 1
      endwhile
      let irow= irow + 1
     endwhile
     let s:MF_{row}_{col}= cnt
"     call Decho("s:MF_".row."_".col."= ((irow=[".row1.",".rowN."] icol=[".col1.",".colN."])) =".cnt)
    endif
	let col = col + 1
   endwhile
   let row = row + 1
  endwhile
  augroup MFTimerAutocmd
   au!
  augroup END

  if g:mines_timer
   augroup MFTimerAutocmd
    au CursorHold *		call s:TimeLapse()
	au BufLeave -Mines-	call s:MFBufLeave()
   augroup END
  endif
  let s:utkeep= &ut
  set ut=100
  augroup MFTimerAutocmd
   au ColorScheme -Mines- call s:MFSyntax()
  augroup END

  " title and author stuff
  1
  exe "norm! jA           M I N E S"
  exe "norm! jA    by Charles E. Campbell"

  nmap <buffer> 0		:exe 'norm! 0l\n'<cr>
  nmap <buffer> $		:exe 'norm! 0f:h\n'<cr>
  nmap <buffer> G		:exe 'norm! Gk\n'<cr>
  nmap <buffer> g		:exe 'norm! ggj\n'<cr>
  nmap <buffer> c		:call <SID>ChgCorner()<cr>
  set nomod

  " place cursor in upper left-hand corner of minefield
  call cursor(2,2)

"  call Dret("InitMines")
  return 0
endfun

" ---------------------------------------------------------------------
" ChgCorner: {{{2
fun! s:ChgCorner()
"  call Dfunc("ChgCorner()")
  let row = line(".")
  let col = col(".")
  if row < s:MFrows/2
   if col < s:MFcols/2
   	norm! Gk0l
   else
   	norm! 1G0jl
   endif
  else
   if col < s:MFcols/2
   	norm! Gk0f:h
   else
   	norm! 1Gj0f:h
   endif
  endif
"  call Dret("ChgCorner")
endfun

" ---------------------------------------------------------------------
" ColLimit: {{{2
fun! s:ColLimit(col)
"  call Dfunc("ColLimit(col=".a:col.")")
  let col= a:col
  if col <= 0
   let col= 1
  endif
  if col > s:MFcols
   let col= s:MFcols
  endif
"  call Dret("ColLimit : col=".col)
  return col
endfun

" ---------------------------------------------------------------------
" RowLimit: {{{2
fun! s:RowLimit(row)
"  call Dfunc("RowLimit(row=".a:row.")")
  let row= a:row
  if row <= 0
   let row= 1
  endif
  if row > s:MFrows
   let row= s:MFrows
  endif
"  call Dret("RowLimit : row=".row)
  return row
endfun

" ---------------------------------------------------------------------
" DrawMinefield: {{{2
"     This function is responsible for drawing the minefield
"     as the leftmouse is clicked (or an "x" is pressed)
fun! s:DrawMinefield()
"  call Dfunc("DrawMinefield()")
  let col   = col(".")
  let row   = line(".")
  let colm1 = col - 1
  let rowm1 = row - 1
"  call Decho("DrawMinefield: ".row.",".col." <".s:MF_{rowm1}_{colm1}.">")

  "  sanity check: x atop a f should do nothing (must use f atop an f to clear it)
  norm! vy
  if @@ == 'f'
   set nomod
"   call Dret("DrawMinefield")
   return
  endif

  " first test: insure that the mouseclick is inside the playing area
  if 1 <= rowm1 && rowm1 <= s:MFrows && 1 <= colm1 && colm1 <= s:MFcols
   if " ".s:MF_{rowm1}_{colm1} == ' *'
   	" mark the location where the bomb went off
   	let s:MF_{rowm1}_{colm1}= 'X'
    call s:Boom()
   else
    call s:ShowAt(rowm1,colm1)
   endif
  endif
  " check if all the bombs have been flagged???
  if s:MFmines == s:flagsused && s:MFmines == s:bombsflagged && s:marked == s:nobombs
   call s:MF_Happy()
  endif

  if s:mines_timer
   call s:TimeLapse()
  endif
  set nomod
"  call Dret("DrawMinefield")
endfun

" ---------------------------------------------------------------------
" DrawMineflag: {{{2
"    This function is responsible for drawing the minefield
"    flags as the rightmouse is clicked
fun! s:DrawMineflag()
"  call Dfunc("DrawMineflag()")

  " prevents some errors when trying to modify a completed minefield
  if &ma == 0
   set nomod
"  call Dret("Boom")
   return
  endif

  let scol   = col(".")
  let srow   = line(".")
  let fcol = scol - 1
  let frow = srow - 1
  if s:mines_timer
   call s:TimeLapse()
  endif

  " sanity check
  if fcol <= 0 || s:MFcols < fcol
   call s:FlagCounter()
   let &ve= vekeep
   set nomod
"   call Dret("DrawMineflag")
   return
  endif

  " sanity check
  if frow <= 0 || s:MFrows < frow
   call s:FlagCounter()
   set nomod
"   call Dret("DrawMineflag")
   return
  endif

  " flip flagged square to unmarked
  norm! vy
  if @@ == 'f'
   exe "norm r	"
   let s:flagsused= s:flagsused - 1
   if " ".s:MF_{frow}_{fcol} == ' *'
	let s:bombsflagged= s:bombsflagged - 1
   endif
   call s:FlagCounter()
   set nomod
"   call Dret("DrawMineflag")
   return
  endif
  if @@ =~ '\d' || @@ == ' '
   " don't change numbered entries or no-bomb areas
   call s:FlagCounter()
   set nomod
"   call Dret("DrawMineflag")
   return
  endif

"  call Decho("DrawMineflag: ".frow.",".fcol." <".s:MF_{frow}_{fcol}.">")
  if 1 <= frow && frow <= s:MFrows && 1 <= fcol && fcol <= s:MFcols
   if " ".s:MF_{frow}_{fcol} == ' *'
    let s:flagsused    = s:flagsused    + 1
    let s:bombsflagged = s:bombsflagged + 1
   else
    let s:flagsused= s:flagsused + 1
   endif
   norm! rf
  endif

  " check if all the bombs have been flagged???
"  call Decho("DrawMineflag: flagsused=".s:flagsused." bombsflagged=".s:bombsflagged." marked=".s:marked)
  if s:MFmines == s:flagsused && s:MFmines == s:bombsflagged && s:marked == s:nobombs
   call s:MF_Happy()
  else
   call s:FlagCounter()
  endif
  set nomod
"  call Dret("DrawMineflag")
endfun

" ---------------------------------------------------------------------
" TimeLapse: {{{2
fun! s:TimeLapse()
  if expand("%") != '-Mines-'
   return
  endif
"  call Dfunc("TimeLapse()")

  let timeused = localtime() - s:timestart - s:timesuspended
  let curline  = line(".")
  let curcol   = col(".")

  if exists("s:mines_timer")
   if timeused > s:MFmaxtime
    call s:Boom()

   elseif g:mines_timer
	let tms= localtime() - s:timestart
	8
    s/  Time.*$//e
	exe "norm! A  Time used=".timeused.'sec'
	9
    s/  Time.*$//e
	let timeleft= s:MFmaxtime - timeused
	exe "norm! A  Time left=".timeleft
"    call Decho("tms=".tms." timeused=".timeused." timeleft=".timeleft)
   endif
  endif

  exe "norm! ".curline."G".curcol."\<bar>"
  set nomod
"  call Dret("TimeLapse")
endfun

" ---------------------------------------------------------------------
" s:MFBufLeave: {{{2
fun! s:MFBufLeave()
"  call Dfunc("s:MFBufLeave()")

  if s:mines_timer
   augroup MFTimerAutocmd
	au!
	au BufEnter -Mines- call s:MFBufEnter()
   augroup END
  endif

"  call Dret("s:MFBufLeave")
endfun

" ---------------------------------------------------------------------
" s:MFBufEnter: {{{2
fun! s:MFBufEnter()
"  call Dfunc("s:MFBufEnter()")

  if s:mines_timer
   augroup MFTimerAutocmd
    au!
    au CursorHold *		call s:TimeLapse()
	au BufLeave -Mines-	call s:MFBufLeave()
   augroup END
  endif

"  call Dret("s:MFBufEnter")
endfun

" ---------------------------------------------------------------------
" ToggleMineTimer: {{{2
"    Toggles timing use
"      0: turn off
"      1: turn on
"      2: toggle
fun! s:ToggleMineTimer(mode)
"  call Dfunc("ToggleMineTimer(mode=".a:mode.")")

  if a:mode == 0
   let s:mines_timer= 0
  elseif a:mode == 1
   let s:mines_timer= 1
  else
   let s:mines_timer= !s:mines_timer
  endif

  " clear off time information
  silent! 8,9s/  Time.*$//e

  if s:mines_timer
   " turn timing on
   augroup MFTimerAutocmd
    au!
    au CursorHold *		call s:TimeLapse()
	au BufLeave -Mines-	call s:MFBufLeave()
   augroup END

  else
   " turn timing off
   augroup MFTimerAutocmd
    au!
   augroup END
   augroup! MFTimerAutocmd
  endif

"  call Dret("ToggleMineTimer")
endfun

" ---------------------------------------------------------------------
" Boom: {{{2
fun! s:Boom()
"  call Dfunc("Boom()")

  " delete the -Mines- file if it exists
  if filereadable("-Mines-")
   call delete("-Mines-")
  endif

  " prevents some errors when trying to modify a completed minefield
  if &ma == 0
"  call Dret("Boom")
   return
  endif

  " set virtualedit
  let vekeep= &ve
  set ve=all

  " clean off right-hand side of minefield
  %s/^:.\{-}:\zs.*$//e

  let curline= line(".")
  let curcol = col(".")
  echohl Error
  echomsg "Boom!"
  echohl None
"  call Decho("Boom!")

  call s:ToggleMineTimer(0)

  if s:field == "E"
   3
  elseif s:field == "M"
   7
  elseif s:field == "H"
   10
  endif
  let s:timelapse= localtime() - s:timestart - s:timesuspended
  exe "norm! A  BOOM!"
  exe "norm! jA  Time  Used   : ".s:timelapse."sec"
  exe "norm! jA  Bombs Flagged: ".s:bombsflagged
  exe "norm! jA  Bombs Present: ".s:MFmines
  exe "norm! jA  Flags Used   : ".s:flagsused
  let s:timestart    = 0
  let s:timestop     = 0
  let s:timesuspended= 0
  if exists("s:utkeep")
   let &ut= s:utkeep
  endif
  call s:Winners(0)
  11
  let row= 1
  norm! gg0jl

  " show true minefield
  while row <= s:MFrows
   let col = 1
   let line= ""
   while col <= s:MFcols

   	" show mistakes with Boomfield# syntax highlighting COMBAK
	let rcchar= getline(row+1)[col]
"	call Decho("MF[".row."][".col."]<".s:MF_{row}_{col}."> getline(".(row+1).")[".col."]<".rcchar.">")
	if rcchar != '\t' && rcchar == 'f' && s:MF_{row}_{col} > 0
	 exe 'syn match Boomfield'.s:MF_{row}_{col}." '\\%".(row+1)."l\\%".(col+1)."c.'"
"	 call Decho('exe syn match Boomfield'.s:MF_{row}_{col}." '\\%".(row+1)."l\\%".(col+1)."c.'")
	endif

	if " ".s:MF_{row}_{col} == " z" || " ".s:MF_{row}_{col} == ' 0'
	 let line= line.' '
	else
	 let line= line.s:MF_{row}_{col}
	endif
	let col = col + 1
   endwhile
"   call Decho("Boom: row=".row." line<".line.">")
   exe 'norm! R'.line
   let row = row + 1
   norm! j0l
  endwhile

  norm! gg0
  exe "norm! ".curline."G".curcol."\<bar>"
  call RndmSave()
  setlocal nolz nomod noma

  " restore virtualedit
  let &ve= vekeep

"  call Dret("Boom")
endfun

" ---------------------------------------------------------------------
" MFSyntax: {{{2
"   Set up syntax highlighting for minefield
fun! s:MFSyntax()
"  call Dfunc("MFSyntax()")

  syn clear
  syn match MinefieldRim	"[.:]"
  syn match MinefieldFlag	"f"
  syn match Minefield0		"[-LR]"
  syn match Minefield1		"1"
  syn match Minefield2		"2"
  syn match Minefield3		"3"
  syn match Minefield4		"4"
  syn match Minefield5		"5"
  syn match Minefield6		"6"
  syn match Minefield7		"7"
  syn match Minefield8		"8"
  syn match MinefieldTab	"	"
  syn match MinefieldSpace	" "
  syn match MinefieldBomb	'[*X]'
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zeTime"		end="$"
  syn region MinefieldTime    start="\s\+\zeTime Used"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zeBombs"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zeFlags"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zeBOOM"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zetotal"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zestreak"	end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zelongest"	end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zecurrent"	end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zebest"		end="$"
  syn region MinefieldMinnie  matchgroup=MinefieldBg start="\s\+\ze[-,/\\)o|]"	end="$" contains=MinefieldWinner keepend
  syn region MinefieldWinner  matchgroup=MinefieldBg start="\s\+\ze\(YOU\|WON\|!!!\)" end="$" keepend
  syn region MinefieldTitle	  matchgroup=MinefieldBg start="\s\+\zeM I N E S\>"	end="$"
  syn region MinefieldTitle	  matchgroup=MinefieldBg start="\s\+\zeby Charles"	end="$"
  syn region MinefieldFlagCnt matchgroup=MinefieldBg start="\s\+\zeFlags Used: " end="$"
  if &bg == "dark"
   hi Minefield0		 ctermfg=black   guifg=black    ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield1		 ctermfg=green   guifg=green    ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield2		 ctermfg=yellow  guifg=yellow   ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield3		 ctermfg=red     guifg=red      ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield4		 ctermfg=cyan    guifg=cyan     ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield5		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Minefield6		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Minefield7		 ctermfg=red     guifg=red	    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Minefield8		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield0		 ctermfg=black   guifg=black    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield1		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield2		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield3		 ctermfg=red     guifg=red      ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield4		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield5		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield6		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield7		 ctermfg=red     guifg=red	    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield8		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi MinefieldTab		 ctermfg=blue    guifg=blue     ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi MinefieldRim		 ctermfg=white   guifg=white    ctermbg=white   guibg=white    term=NONE cterm=NONE gui=NONE
   hi MinefieldFlag		 ctermfg=white   guifg=white    ctermbg=magenta guibg=magenta  term=NONE cterm=NONE gui=NONE
   hi MinefieldText		 ctermfg=white   guifg=white    ctermbg=magenta guibg=magenta  term=NONE cterm=NONE gui=NONE
   hi MinefieldSpace	 ctermfg=black   guifg=black    ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi MinefieldMinnie	 ctermfg=white   guifg=white                                   term=NONE cterm=NONE gui=NONE
   hi MinefieldBomb		 ctermfg=white   guifg=white    ctermbg=red     guibg=red      term=NONE cterm=NONE gui=NONE
   hi link MinefieldWinner MinefieldText
  else
   hi Minefield0		 ctermfg=black   guifg=black    ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield1		 ctermfg=green   guifg=green    ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield2		 ctermfg=yellow  guifg=yellow   ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield3		 ctermfg=red     guifg=red      ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield4		 ctermfg=cyan    guifg=cyan     ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield5		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Minefield6		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Minefield7		 ctermfg=red     guifg=red	    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Minefield8		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield0		 ctermfg=black   guifg=black    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield1		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield2		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield3		 ctermfg=red     guifg=red      ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield4		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield5		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield6		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield7		 ctermfg=red     guifg=red	    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield8		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi MinefieldTab		 ctermfg=blue    guifg=blue     ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi MinefieldRim		 ctermfg=magenta guifg=magenta  ctermbg=magenta guibg=magenta   term=NONE cterm=NONE gui=NONE
   hi MinefieldFlag		 ctermfg=white   guifg=white    ctermbg=magenta guibg=magenta   term=NONE cterm=NONE gui=NONE
   hi MinefieldText		 ctermfg=black   guifg=black    ctermbg=cyan    guibg=cyan      term=NONE cterm=NONE gui=NONE
   hi MinefieldSpace	 ctermfg=black   guifg=black    ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi MinefieldMinnie	 ctermfg=black   guifg=black                                    term=NONE cterm=NONE gui=NONE
   hi MinefieldBomb		 ctermfg=white   guifg=white    ctermbg=red     guibg=red       term=NONE cterm=NONE gui=NONE
   hi Cursor			 ctermfg=blue guifg=blue ctermbg=white guibg=white              term=NONE cterm=NONE gui=NONE
   hi link MinefieldWinner MinefieldText
  endif
  hi link MinefieldTitle  PreProc

"  call Dret("MFSyntax")
endfun

" ---------------------------------------------------------------------
" DisplayMines: {{{2
"    Displays a Minefield and sets up Minefield mappings
fun! s:DisplayMines(init)
"  call Dfunc("DisplayMines(init=".a:init.")")

  " Settings
  set ts=1    " set tabstop to 1
  set mouse=n " initialize mouse

  if bufname("%") == s:displayname
   " already have a minefield display, and its showing
   if a:init == 1
    silent! %d
"    call Decho("cleared screen")
   endif
"   call Dret("DisplayMines")
   return
  endif

  " error message: attempt to restore a game that no longer exists
  if a:init == 0 && !exists("s:minebufnum")
   echomsg "***sorry*** I'm unable to restore your game (s suspends, q quits)"
"   call Dret("DisplayMines : unable to restore")
   return
  endif

  " save current working session
  call SaveSession(s:savesession)

  " clear screen
  silent! %d
"    call Decho("cleared screen")
  set nomod

  if !exists("s:minebufnum")
   " need to create a new buffer with s:displayname
   exe "e ".s:displayname
   let s:minebufnum    = bufnr("%")
   let s:timestart     = localtime()
   let s:timesuspended = 0
   let s:timestop      = 0
  else
   " minefield buffer is merely hidden, restore it to view
   exe "b ".s:minebufnum
   let srows=s:MFrows+2
   exe "silent! norm! ".srows."\<c-y>"
   let s:timesuspended= s:timesuspended + localtime() - s:timestop
  endif
  silent only!
  set nomod

  " set up interface
  call s:MFSyntax()
  nnoremap <silent> <leftmouse>  <leftmouse>:<c-u>call <SID>DrawMinefield()<CR>
  nnoremap <silent> <rightmouse> <leftmouse>:<c-u>call <SID>DrawMineflag()<CR>
  nmap <silent> x :silent call <SID>DrawMinefield()<CR>
  nmap <silent> q :silent call <SID>StopMines(0)<CR>
  nmap <silent> s :silent call <SID>StopMines(1)<CR>
  nmap <silent> f :silent call <SID>DrawMineflag()<CR>
  nmap <silent> C :set lz<CR>:call <SID>SaveStatistics(0)<CR>:set nolz<CR>
  nmap <silent> E :set lz<CR>:call <SID>EasyMines()<CR>:set nolz<CR>
  nmap <silent> M :set lz<CR>:call <SID>MedMines()<CR>:set nolz<CR>
  nmap <silent> H :set lz<CR>:call <SID>HardMines()<CR>:set nolz<CR>

  call s:ToggleMineTimer(g:mines_timer)
"  call Dret("DisplayMines")
endfun

" ---------------------------------------------------------------------
" StopMines: {{{2
"         Stops the Mines game; it can either truly quit
"            Mines or merely temporarily suspend Mines.
"            The screen is restored to its pre-Mines condition
"         StopMines(0) -- really quits Mines
"         StopMines(1) -- suspends Mines
fun! s:StopMines(suspend)
"  call Dfunc("StopMines(suspend=".a:suspend.")")

  call s:ToggleMineTimer(0)
  if a:suspend == 0
   " quit Mines
"   call Decho("quitting Mines")

   " restore display based on savesession
"   call Decho("restoring display based on savesession<".s:savesession.">")
   try
    exe "source ".s:savesession
   catch /^Vim\%((\a\+)\)\=:E/
"   	call Decho("intercepted error ".v:errmsg)
   endtry
   call delete(s:savesession)

   set nohidden
   if exists("s:minebufnum") && bufname(s:minebufnum) != ""
"   	call Decho("buffer-wiping ".s:minebufnum)
    exe "bw! ".s:minebufnum
    unlet s:minebufnum
   endif

"   call Decho("restoring options")
   let &hidden   = s:keep_hidden
   let &mouse    = s:keep_mouse
   let &gdefault = s:keep_gdefault
   let &list     = s:keep_list
   let &go       = s:keep_go
   let &fo       = s:keep_fo
   let &gd       = s:keep_gd
   let &report   = s:keep_report
   let &spell    = s:keep_spell

  else
   " suspend  Mines
"   call Decho("suspending Mines")
   exe "b ".s:keep_bufnum
   " restore display based on savesession
   exe "silent! source ".s:savesession
  endif

  " restore any pre-existing to <Mines.vim> maps
  if !exists("b:netrw_curdir")
   let b:netrw_curdir= getcwd()
  endif
  call RestoreUserMaps("Mines")
  let s:timestop= localtime()

"  call Dret("StopMines")
endfun

" ---------------------------------------------------------------------
" SaveSession: {{{2
"    Save session into given savefile
fun! SaveSession(savefile)
"  call Dfunc("SaveSession(savefile<".a:savefile.">)")
  silent! windo w

  " Save any pre-existing maps that conflict with <Mines.vim>'s maps
  " (uses call RestoreUserMaps("Mines") to restore user maps in s:StopMines() )
  call SaveUserMaps("n","","emhxqsf","Mines")
  call SaveUserMaps("n","","<leftmouse>","Mines")
  call SaveUserMaps("n","","<rightmouse>","Mines")

  " save user settings
  let keep_ssop       = &ssop
  let s:keep_hidden   = &hidden
  let s:keep_mouse    = &mouse
  let s:keep_bufnum   = bufnr("%")
  let s:keep_gdefault = &gdefault
  let &ssop           = 'winpos,buffers,slash,globals,resize,blank,folds,help,options,winsize'
  set hidden nogd

  " make a session file and save it in the a:savefile (a temporary file)
  exe 'silent! mksession! '.a:savefile
  let &ssop            = keep_ssop

"  call Dret("SaveSession")
endfun

" ---------------------------------------------------------------------
" ShowAt: {{{2
"    This function displays the Minefield at the given row,column
fun! s:ShowAt(row,col)
"  call Dfunc("ShowAt(".a:row.",".a:col."): MF=".s:MF_{a:row}_{a:col})

  if " ".s:MF_{a:row}_{a:col} == ' 0'
   call s:MF_Flood(a:row,a:col)
   call s:MF_Posn(a:row,a:col)
  else
   norm! vy
   if @@ == "\t"
    call s:CheckIfFlagged()
    exe "norm! r".s:MF_{a:row}_{a:col}
   endif
  endif

"  call Dret("ShowAt")
endfun

" ---------------------------------------------------------------------
" CheckIfFlagged: {{{2
"    When marking a square, this function keeps track of
"    how many squares are flagged and how many are marked
fun! s:CheckIfFlagged()
"  call Dfunc("CheckIfFlagged()")

  norm! vy
  if @@ == 'f'
   let s:marked   = s:marked    + 1
   let s:flagsused= s:flagsused - 1
  elseif @@ == "\t"
   let s:marked   = s:marked    + 1
  endif

"  call Dret("CheckIfFlagged : marked=".s:marked." flagged=".s:flagsused)
endfun

" ---------------------------------------------------------------------
" FlagCounter: show count of flags{{{2
fun! s:FlagCounter()
"  call Dfunc("FlagCounter()")
  let vekeep= &ve
  setlocal ve=all

  let curpos    = getpos(".")
  call cursor(5,s:MFcols + 3)
  exe "norm! DA".(printf("    Flags Used: %d",s:flagsused))
  call cursor(6,s:MFcols + 3)
  let s:timelapse= localtime() - s:timestart - s:timesuspended
  exe "norm! DA    Time Used : ".s:timelapse."sec"
  call setpos(".",curpos)
  set nomod

  let &ve= vekeep
"  call Dret("FlagCounter")
endfun

" ---------------------------------------------------------------------
" MF_Flood: {{{2
"    Fills in 0-minefield count area
"      frow,fcol: mine-f-ield row and column
"      col1,col2: index into minefield array from 0..0 (ie. not [1-8])
fun! s:MF_Flood(frow,fcol)
"  call Dfunc("MF_Flood(frow=".a:frow.",fcol=".a:fcol.")")

"  redr!
  if s:MF_Posn(a:frow,a:fcol)
"   call Dret("MF_Flood")
   return
  endif
  setlocal ma
  let colL= s:MF_FillLeft(a:frow,a:fcol)
  let colR= s:MF_FillRight(a:frow,a:fcol+1)
  let colL= (colL > 1)?        colL-1 : 1
  let colR= (colR < s:MFcols)? colR+1 : s:MFcols
  if a:frow > 1
   call s:MF_FillRun(a:frow-1,colL,colR)
  endif
  if a:frow < s:MFrows
   call s:MF_FillRun(a:frow+1,colL,colR)
  endif
"  call Dret("MF_Flood")
endfun

" ---------------------------------------------------------------------
"  MF_FillLeft: {{{2
fun! s:MF_FillLeft(frow,fcol)
"  call Dfunc("MF_FillLeft(frow=".a:frow.",fcol=".a:fcol.")")

  if s:MF_Posn(a:frow,a:fcol)
"   call Dret("MF_FillLeft : fcol=".a:fcol)
   return a:fcol
  endif

  setlocal ma
  let Lcol= a:fcol
  while Lcol >= 1
   if " ".s:MF_{a:frow}_{Lcol} == " 0"
	call s:CheckIfFlagged()
    exe "norm! r h"
    let s:MF_{a:frow}_{Lcol}= 'z'
   elseif " ".s:MF_{a:frow}_{Lcol} != " z"
	call s:CheckIfFlagged()
    exe "norm! r".s:MF_{a:frow}_{Lcol}
"	call Decho("end-of-run left: Lcol=".Lcol."<".s:MF_{a:frow}_{Lcol}.">")
    break
   else
	norm! h
   endif
   let Lcol= Lcol - 1
  endwhile

  let Lcol= (Lcol < 1)? 1 : Lcol + 1

"  redr!	"Decho
"  call Dret("MF_FillLeft : Lcol=".Lcol)
"  let response= confirm("filled left row ".a:frow)	"Decho
  return Lcol
endfun

" ---------------------------------------------------------------------
"  MF_FillRight: {{{2
fun! s:MF_FillRight(frow,fcol)
"  call Dfunc("MF_FillRight(frow=".a:frow.",fcol=".a:fcol.")")

  if s:MF_Posn(a:frow,a:fcol)
"   call Dret("MF_FillRight : fcol=".a:fcol)
   return a:fcol
  endif

  setlocal ma
  let Rcol= a:fcol
  while Rcol <= s:MFcols
   if " ".s:MF_{a:frow}_{Rcol} == " 0"
	call s:CheckIfFlagged()
    exe "norm! r l"
	let s:MF_{a:frow}_{Rcol}= 'z'
   elseif " ".s:MF_{a:frow}_{Rcol} != " z"
	call s:CheckIfFlagged()
    exe "norm! r".s:MF_{a:frow}_{Rcol}
"	call Decho("end-of-run right: Rcol=".Rcol."<".s:MF_{a:frow}_{Rcol}.">")
    break
   else
    norm! l
   endif
   let Rcol= Rcol + 1
  endwhile

  let Rcol= (Rcol > s:MFcols)? s:MFcols : Rcol - 1

"  redr!	"Decho
"  call Dret("MF_FillRight : Rcol=".Rcol)
"  let response= confirm("filled right row ".a:frow)	"Decho
  return Rcol
endfun

" ---------------------------------------------------------------------
"  MF_FillRun: {{{2
fun! s:MF_FillRun(frow,fcolL,fcolR)
"  call Dfunc("MF_FillRun(frow=".a:frow.",fcol[".a:fcolL.",".a:fcolR."])")

  if s:MF_Posn(a:frow,a:fcolL)
"   call Dret("MF_FillRun : bad posn (row ".a:frow.")")
   return
  endif

  " Flood
  call s:MF_Posn(a:frow,a:fcolL)
"  call Decho("flood row=".a:frow." col[".a:fcolL.",".a:fcolR."]")
  let icol= a:fcolL
  while icol <= a:fcolR
   if " ".s:MF_{a:frow}_{icol} == " 0"
	call s:CheckIfFlagged()
	exe "norm! r l"
	let s:MF_{a:frow}_{icol}= 'z'
	call s:MF_Flood(a:frow,icol)
    call s:MF_Posn(a:frow,icol+1)
   elseif " ".s:MF_{a:frow}_{icol} != " z"
	call s:CheckIfFlagged()
	exe "norm! r".s:MF_{a:frow}_{icol}."l"
   else
	norm! l
   endif
   let icol= icol + 1
  endwhile

"  redr!	"Decho
"  call Dret("MF_FillRun : row=".a:frow)
"  let response= confirm("flooded row ".a:frow)  "Decho
endfun

" ---------------------------------------------------------------------
" MF_Posn: {{{2
"    Put cursor into given position on screen
"       srow,scol: -s-creen    row and column
"      Returns  1 : failed sanity check
"               0 : otherwise
fun! s:MF_Posn(frow,fcol)
"  call Dfunc("MF_Posn(frow=".a:frow.",fcol=".a:fcol.")")

  " sanity checks
  if a:frow < 1 || s:MFrows < a:frow
"   call Dret("MF_Posn 1")
   return 1
  endif
  if a:fcol < 1 || s:MFcols < a:fcol
"   call Dret("MF_Posn 1")
   return 1
  endif
  let srow= a:frow + 1
  let scol= a:fcol + 1
  exe "norm! ".srow."G".scol."\<Bar>"

"  call Dret("MF_Posn 0")
  return 0
endfun

" ---------------------------------------------------------------------
" MF_Happy: Minnie does a cartwheel when you win {{{2
fun! s:MF_Happy()
"  call Dfunc("MF_Happy()")

  " delete the -Mines- file if it exists
  if filereadable("-Mines-")
   call delete("-Mines-")
  endif

  " prevents some errors when trying to modify a completed minefield
  if &ma == 0
"  call Dret("Boom")
   return
  endif

  " clean off right-hand side of minefield
  %s/^:.\{-}:\zs.*$//e

  if s:timestart == 0
   " already gave a Happy!
"   call Dret("MF_Happy")
   return
  endif

  " set virtualedit
  let vekeep= &ve
  set ve=all

  call s:ToggleMineTimer(0)
  let s:timelapse = localtime() - s:timestart
  let keep_ch   = &ch
  set ch=5
  set lz
  exe "silent! norm! z-"

  2
  exe "norm! A   o"
  exe "norm! jA  ,\<bar>`"
  exe "norm! jA  /\\"
  sleep 250m
  redr

  2
  exe "norm! 0f:lDA      o"
  exe "norm! 0jf:lDA     /\\"
  exe "norm! 0jf:lDA    /\\"
  sleep 250m
  redr

  2
  exe "norm! 0f:lDA     \\   "
  exe "norm! 0jf:lDA      --o"
  exe "norm! 0jf:lDA     / \\"
  sleep 250m
  redr

  2
  exe "norm! 0f:lDA        \\ /"
  exe "norm! 0jf:lDA         \<bar>"
  exe "norm! 0jf:lDA         o"
  exe "norm! jA        / \\"
  sleep 250m
  redr

  2
  exe "norm! 0f:lDA         \\ /"
  exe "norm! 0jf:lDA          /"
  exe "norm! 0jf:lDA         o"
  exe "norm! 0jf:lDA        / \\"
  sleep 250m
  redr

  2
  exe "norm! 0f:lDA            /"
  exe "norm! j0f:lDA         o-- "
  exe "norm! j0f:lDA        / \\ \\"
  exe "norm! j0f:lD"
  sleep 250m
  redr

  2
  exe "norm! 0f:lDA             \\o/   YOU"
  exe "norm! j0f:lDA              )    WON"
  exe "norm! j0f:lDA             /\\    !!!"
  redr

  " clear off "Flags Used: ..." field
  call cursor(5,13)
  norm! Dk$
  redr

  exe "norm! jjA  Time  Used   : ".s:timelapse."sec"
  exe "norm! jA  Bombs Flagged: ".s:MFmines

  let s:timestart= 0
  let &ch        = keep_ch
  if exists("s:utkeep")
   let &ut= s:utkeep
  endif
  call s:Winners(1)
  call RndmSave()
  setlocal nolz nomod noma

  " restore virtualedit
  let &ve= vekeep

"  call Dret("MF_Happy")
endfun

" ---------------------------------------------------------------------
" Winners: checks top winners in the $HOME directory {{{2
fun! s:Winners(winner)
"  call Dfunc("Winners(winner=".a:winner.")")

  if $HOME == ""
"   call Dret("Winners : no home directory")
   return
  endif

  " sanity preservation
  call s:StatSanity("E")
  call s:StatSanity("M")
  call s:StatSanity("H")

  " initialize statistics
  if filereadable($HOME."/.vimMines")
   exe "so ".$HOME."/.vimMines"
  else
   call s:SaveStatistics(0)
  endif

  call s:UpdateStatistics(a:winner)
  call s:SaveStatistics(1)

  " report on statistics
  norm! j
  if g:mines_losecnt{s:field} > 0
   let totgames = g:mines_wincnt{s:field} + g:mines_losecnt{s:field}
   let percent  = (100000*g:mines_wincnt{s:field})/totgames
   let int      = percent/1000
   let frac     = percent%1000
   exe  "norm! j$lA  totals         : [".g:mines_wincnt{s:field}." wins]/[".totgames." games]=".int.'.'.printf("%03d",frac)."%"
  else
   exe  "norm! j$lA  totals         : ".g:mines_wincnt{s:field}." wins, ".g:mines_losecnt{s:field}." losses"
  endif
  if g:mines_curwinstreak{s:field} > 0
   exe "norm! j$lA  current streak : ".g:mines_curwinstreak{s:field}." wins"
  else
   exe "norm! j$lA  current streak : ".g:mines_curlosestreak{s:field}." losses"
  endif
  exe "norm! j$lA  longest streaks: ".g:mines_winstreak{s:field}." wins, ".g:mines_losestreak{s:field}." losses"

  if s:field == "E"
   if g:mines_timeE > 0
    exe "norm! j$lA  best time=".g:mines_timeE."sec (easy)"
   endif
  endif
  if s:field == "M"
   if g:mines_timeM > 0
    exe "norm! j$lA  best time=".g:mines_timeM."sec (medium)"
   endif
  endif
  if s:field == "H"
   if g:mines_timeH > 0
    exe "norm! j$lA  best time=".g:mines_timeH."sec (hard)"
   endif
  endif

"  call Dret("Winners")
endfun

" ---------------------------------------------------------------------
" UpdateStatistics: {{{2
fun! s:UpdateStatistics(winner)
"  call Dfunc("UpdateStatistics(winner<".a:winner.">) s:field<".s:field.">")

  " update statistics
  let g:mines_wincnt{s:field}  = g:mines_wincnt{s:field}  +  a:winner
  let g:mines_losecnt{s:field} = g:mines_losecnt{s:field} + !a:winner
  if a:winner == 1
   let g:mines_curwinstreak{s:field}  = g:mines_curwinstreak{s:field} + 1
   let g:mines_curlosestreak{s:field} = 0
   if g:mines_curwinstreak{s:field} > g:mines_winstreak{s:field}
   	let g:mines_winstreak{s:field}= g:mines_curwinstreak{s:field}
   endif
  else
   let g:mines_curlosestreak{s:field} = g:mines_curlosestreak{s:field} + 1
   let g:mines_curwinstreak{s:field}  = 0
   if g:mines_curlosestreak{s:field} > g:mines_losestreak{s:field}
   	let g:mines_losestreak{s:field}= g:mines_curlosestreak{s:field}
   endif
  endif

  if a:winner == 1
   if g:mines_time{s:field} == 0 || g:mines_time{s:field} > s:timelapse
   	let g:mines_time{s:field}= s:timelapse
   endif
  endif
"  call Dret("UpdateStatistics")
endfun

" ---------------------------------------------------------------------
" StatSanity: make sure statistics variables are initialized to zero {{{2
"             if they don't exist
fun! s:StatSanity(field)
"  call Dfunc("StatSanity(field<".a:field.">)")

   let g:mines_wincnt{a:field}        = 0
   let g:mines_curwinstreak{a:field}  = 0
   let g:mines_curlosestreak{a:field} = 0
   let g:mines_winstreak{a:field}     = 0
   let g:mines_losestreak{a:field}    = 0
   let g:mines_losecnt{a:field}       = 0
   if !exists("g:mines_time{a:field}")
    let g:mines_time{a:field}         = 0
   endif

"  call Dret("StatSanity")
endfun

" ---------------------------------------------------------------------
" SaveStatistics: {{{2
fun! s:SaveStatistics(mode)
"  call Dfunc("SaveStatistics(mode=".a:mode.")")

  if $HOME == ""
"   call Dret("SaveStatistics : no $HOME")
   return
  endif

  if a:mode == 0
   let g:mines_wincntE        = 0
   let g:mines_curwinstreakE  = 0
   let g:mines_curlosestreakE = 0
   let g:mines_winstreakE     = 0
   let g:mines_losestreakE    = 0
   let g:mines_losecntE       = 0
   let g:mines_timeE          = 0

   let g:mines_wincntM        = 0
   let g:mines_curwinstreakM  = 0
   let g:mines_curlosestreakM = 0
   let g:mines_winstreakM     = 0
   let g:mines_losestreakM    = 0
   let g:mines_losecntM       = 0
   let g:mines_timeM          = 0

   let g:mines_wincntH        = 0
   let g:mines_curwinstreakH  = 0
   let g:mines_curlosestreakH = 0
   let g:mines_winstreakH     = 0
   let g:mines_losestreakH    = 0
   let g:mines_losecntH       = 0
   let g:mines_timeH          = 0
  endif

  " write statistics to $HOME/.vimMines
  exe "silent! vsp ".$HOME."/.vimMines"
  setlocal bh=wipe
  silent! %d

  put ='let g:mines_wincntE       ='.g:mines_wincntE
  put ='let g:mines_curwinstreakE ='.g:mines_curwinstreakE
  put ='let g:mines_curlosestreakE='.g:mines_curlosestreakE
  put ='let g:mines_winstreakE    ='.g:mines_winstreakE
  put ='let g:mines_losestreakE   ='.g:mines_losestreakE
  put ='let g:mines_losecntE      ='.g:mines_losecntE
  put ='let g:mines_timeE         ='.g:mines_timeE

  put ='let g:mines_wincntM       ='.g:mines_wincntM
  put ='let g:mines_curwinstreakM ='.g:mines_curwinstreakM
  put ='let g:mines_curlosestreakM='.g:mines_curlosestreakM
  put ='let g:mines_winstreakM    ='.g:mines_winstreakM
  put ='let g:mines_losestreakM   ='.g:mines_losestreakM
  put ='let g:mines_losecntM      ='.g:mines_losecntM
  put ='let g:mines_timeM         ='.g:mines_timeM

  put ='let g:mines_wincntH       ='.g:mines_wincntH
  put ='let g:mines_curwinstreakH ='.g:mines_curwinstreakH
  put ='let g:mines_curlosestreakH='.g:mines_curlosestreakH
  put ='let g:mines_winstreakH    ='.g:mines_winstreakH
  put ='let g:mines_losestreakH   ='.g:mines_losestreakH
  put ='let g:mines_losecntH      ='.g:mines_losecntH
  put ='let g:mines_timeH         ='.g:mines_timeH

  silent! w!
  silent! q!

"  call Dret("SaveStatistics")
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker
