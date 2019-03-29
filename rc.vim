" ================================
" .vimrc klen <horneds@gmail.com>
" ================================

scriptencoding utf-8

" Setup {{{
" ======

    if has('vim_starting')

        set nocompatible                           " enable vim features

        set backup                                 " make backup file and leave it around 

        set backupdir=/tmp/vim/backup              " where to put backup files
        set directory=/tmp/vim/swap                " where to put swap files
        let g:SESSION_DIR='/tmp/vim/sessions'      " where to keep sessions

        " Create directories
        if finddir(&backupdir) == ''
            silent call mkdir(&backupdir, "p")
        endif

        if finddir(&directory) == ''
            silent call mkdir(&directory, "p")
        endif

        if finddir(g:SESSION_DIR) == ''
            silent call mkdir(g:SESSION_DIR, "p")
        endif

        " Setup Bundler {{{
        " =================

        set rtp+=$HOME/.vim/bundle/neobundle.vim/
        let g:neobundle#types#git#clone_depth = 2
        call neobundle#begin($HOME . '/.vim/bundle')

        filetype plugin indent on
        syntax on

    endif

" }}}
    

" Options {{{
" =======

    " Buffer (File) options
    set hidden                  " Edit multiple unsaved files at the same time
    set confirm                 " Prompt to save unsaved changes when exiting

    " Keep various histories between edits
    set viminfo='1000,f1,<500,:100,/100,h

    set autoread                " auto reload changed files

    " Display options
    set title                   " show file name in window title
    set visualbell              " mute error bell
    set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:$,nbsp:~
    set fillchars=fold:·
    set linebreak               " break lines by words
    set winminheight=0          " minimal window height
    set winminwidth=0           " minimal window width
    set scrolloff=4             " min 4 symbols bellow cursor
    set sidescroll=4
    set sidescrolloff=10
    set showcmd                 " Show commands
    set whichwrap=b,s,<,>,[,],l,h
    set completeopt=menu,longest
    set laststatus=2            " Always show a statusline
    " Don't try to highlight lines longer than 1000 characters.
    set synmaxcol=1000

    " Tab options
    set autoindent              " copy indent from previous line
    set smartindent             " enable nice indent
    set expandtab               " tab with spaces
    set smarttab                " indent using shiftwidth"
    set shiftwidth=4            " number of spaces to use for each step of indent
    set softtabstop=4           " tab like 4 spaces
    set shiftround              " drop unused spaces

    " Search options
    set hlsearch                " Highlight search results
    set ignorecase              " Ignore case in search patterns
    set infercase               " Enable case-sensetive search for non lower-case string
    set smartcase               " Override the 'ignorecase' option if the search pattern contains upper case characters
    set incsearch               " While typing a search command, show where the pattern

    " Insert (Edit)
    set backspace=indent,eol,start " Allow backspace to remove indents, newlines and old tex"
    set nostartofline           " Emulate typical editor navigation behaviour
    set nopaste                 " Start in normal (non-paste) mode
    set virtualedit=all         " on virtualedit for all mode
    set nrformats=              " dont use octal and hex in number operations

    " Matching characters
    set showmatch               " Show matching brackets
    set matchpairs+=<:>         " Make < and > match as well

    " Backup and swap files
    set history=400             " history length
    set ssop-=blank             " dont save blank vindow
    set ssop-=options           " dont save options

    " Localization
    set langmenu=none            " Always use english menu
    set keymap=russian-jcukenwin " Alternative keymap
    set iminsert=0               " English by default
    set imsearch=-1              " Search keymap from insert mode
    set spelllang=en,ru          " Languages
    set encoding=utf-8           " Default encoding
    set fileencodings=utf-8,cp1251,koi8-r,cp866
    set termencoding=utf-8

    " Tab completion in command line mode
    set wildmenu                   " Better commandline completion
    set wildmode=longest:full,full " Expand match on first Tab complete
    set wildcharm=<TAB>
    set wildignore+=.hg,.git,.svn                    " Version control
    set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
    set wildignore+=*.spl                            " compiled spelling word lists
    set wildignore+=*.sw?                            " Vim swap files
    set wildignore+=*.DS_Store                       " OSX bullshit

    set wildignore+=*.luac                           " Lua byte code

    set wildignore+=migrations                       " Django migrations
    set wildignore+=*.pyc                            " Python byte code

    set wildignore+=*.orig                           " Merge resolution files

    set numberwidth=1              " Keep line numbers small if it's shown

    set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

    " Undo
    if has('persistent_undo')
        set undofile            " enable persistent undo
        set undodir=/tmp/       " store undofiles in a tmp dir
    endif

    " Folding
    if has('folding')
        set foldmethod=marker   " Fold on marker
        set foldlevel=999       " High default so folds are shown to start
        set foldlevelstart=999  " High default so folds are shown to start
    endif

    " X-clipboard support
    if has('unnamedplus')
        set clipboard+=unnamed     " enable x-clipboard
    endif

    " Term
    set mouse=                     " Disable mouse usage (all modes) in terminals
    " Quickly time out on keycodes, but never time out on mappings
    set notimeout ttimeout ttimeoutlen=200
    if &term =~ "xterm"
        set t_Co=256            " set 256 colors
    endif

    let g:changelog_username = $USER
    let mapleader = ","
    let maplocalleader = " "

    " Color themes
    if !exists('g:colors_name')
        colorscheme jellybeans
    endif

    " Highlight VCS conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " Open help in a vsplit rather than a split
    command! -nargs=? -complete=help Help :vertical help <args>
    cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

    " quick shortcut to outer make
    cabbrev m m<C-\>esubstitute(getcmdline(), '^m\>', '!make', '')<CR>

    " Some gui settings
    if has("gui_running")
        set guioptions=agimP
        set guifont=Monaco\ 12
        set mouse=a
    endif

    " Enable extended matchit
    runtime macros/matchit.vim

" }}}


" Functions {{{
" ==========

    " Recursive vimgrep
    fun! rc#RGrep() "{{{ 
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif

        let cwd = getcwd()
        let startdir = input("Start searching from directory: ", cwd, "dir")
        if startdir == ""
            return
        endif

        let filepattern = input("Search in files matching pattern: ", "*.*") 
        if filepattern == ""
            return
        endif

        try
            execute 'noautocmd vimgrep /'.pattern.'/gj '.startdir.'/**/'.filepattern
            botright copen
        catch /.*/
            echohl WarningMsg | echo "Not found: ".pattern | echohl None
        endtry
    endfun "}}} 

    " Restore cursor position
    fun! rc#restore_cursor() "{{{
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction "}}}

    " Templates
    fun! rc#load_template() "{{{
        let dir_tpl = $HOME . "/.vim/templates/"

        if exists("g:tpl_prefix")
            let dir_tpl = l:dir_tpl . g:tpl_prefix . "/"
        endif

        let template = ''

        let path = expand('%:p:~:gs?\\?/?')
        let path = strpart(l:path, len(fnamemodify(l:path, ':h:h:h')), len(l:path))
        let parts = split(l:path, '/')

        while len(l:parts) && !filereadable(l:template)
            let template = l:dir_tpl . join(l:parts, '/')
            let l:parts = l:parts[1:]
        endwhile

        if !filereadable(l:template)
            let l:template = l:dir_tpl . &ft
        endif

        if filereadable(l:template)
            exe "0r " . l:template
        endif
    endfunction "}}}

" }}}


" Autocommands {{{
" =============

    if has("autocmd")

        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        
        autocmd FileType crontab setlocal nobackup nowritebackup

        augroup vimrc
        au!

            " Auto reload vim settins
            " au! BufWritePost rc.vim source ~/.vimrc
            au! BufWritePost ~/.vim/*.vim source ~/.vimrc

            " Only show cursorline in the current window and in normal mode.
            au WinLeave,InsertEnter * set nocursorline
            au WinEnter,InsertLeave * set cursorline

            au BufRead * :set cpoptions+=J

            au InsertEnter * :set listchars-=trail:⌴
            au InsertLeave * :set listchars+=trail:⌴

            " New file templates
            au BufNewFile * silent! call rc#load_template()

            " Restore cursor position
            au BufWinEnter * call rc#restore_cursor()

            " Autosave last session
            if has('mksession') 
                au VimLeavePre * exe "mks! " g:SESSION_DIR.'/last.vim'
            endif

            " Filetypes {{{
            " ---------
            
                au BufNewFile,BufRead *.json setf javascript
                au BufNewFile,BufRead *.tag  setf coffee

            " }}}
            
            " Auto close preview window
            autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
            autocmd InsertLeave * if pumvisible() == 0|pclose|endif

            " Unset paste on InsertLeave
            au InsertLeave * silent! set nopaste

        augroup END

    endif

" }}}


" Maps
source $HOME/.vim/map.vim


" Bundles
source $HOME/.vim/bundle.vim


" Commands {{{

" Typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" }}}


" Local settings
" ================
if filereadable($HOME . "/.vim_local")
    source $HOME/.vim_local
endif


" Project settings
" ================

" enables the reading of .vimrc, .exrc and .gvimrc in the current directory.
set exrc

" must be written at the last.  see :help 'secure'.
set secure

call neobundle#end()
