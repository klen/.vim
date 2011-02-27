" ================================
" .vimrc klen <horneds@gmail.com>
" ================================

" Setup
" ======

    if !exists('s:loaded_my_vimrc') " Don't reset twice on reloading

        set nocompatible  " to use many extensions of Vim.

        set backupdir=$HOME/.cache/vim/backup      " where to put backup file 
        set backup                                 " make backup file and leave it around 
        set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp

        set directory=$HOME/.cache/vim/swap        " where to put swap file 
        let g:SESSION_DIR   = $HOME.'/.cache/vim/sessions'

        " Create system vim dirs
        if finddir(&backupdir) == ''
            silent call mkdir(&backupdir, "p")
        endif

        if finddir(&directory) == ''
            silent call mkdir(&directory, "p")
        endif

        if finddir(g:SESSION_DIR) == ''
            silent call mkdir(g:SESSION_DIR, "p")
        endif

        " Pathogen load
        filetype off
        call pathogen#helptags()
        call pathogen#runtime_append_all_bundles()

        syntax on

    endif

    set hidden                  " не требовать сохранения буфера
    set title                   " показывать имя файла в заголовке окна
    set autoread                " отслеживать изменения файлов
    set visualbell              " ошибки без писка

    set autoindent              " копирует отступ от предыдущей строки
    set smartindent             " включаем 'умную' автоматическую расстановку отступов
    set expandtab               " tab with spaces
    set smarttab
    set shiftwidth=4            " Number of spaces to use for each step of indent
    set softtabstop=4           " Tab like 4 spaces
    set shiftround              " удалять лишние пробелы при отступе

    " Backup and swap files
    set history=400             " history length
    set viminfo+=h              " save history
    set ssop-=blank             " dont save blank vindow
    set ssop-=options           " dont save options

    " Search options
    set hlsearch                " Highlight search results
    set ignorecase              " Ignore case in search patterns
    set smartcase               " Override the 'ignorecase' option if the search pattern contains upper case characters
    set incsearch               " While typing a search command, show where the pattern

    " Localization
    set langmenu=none            " Always use english menu
    set keymap=russian-jcukenwin " Переключение раскладок клавиатуры по <C-^>
    set iminsert=0               " Раскладка по умолчанию - английская
    set imsearch=0               " Раскладка по умолчанию при поиске - английская
    set spelllang=en,ru          " Языки для проверки правописания
    set encoding=utf-8
    set fileencodings=utf-8,cp1251,koi8-r,cp866
    set termencoding=utf-8

    set shortmess=atToOI

    set wildmenu                " использовать wildmenu ...
    set wildcharm=<TAB>         " ... с авто-дополнением
    set wildignore=*.pyc        " Игнорировать pyc файлы
    set cmdheight=2             " Command line height 2

    " Display
    set foldclose=all
    set foldmethod=syntax
    set foldnestmax=3           "deepest fold is 3 levels
    set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo    " This commands open folds
    set listchars=eol:$,tab:>-,trail:·,nbsp:~,extends:>,precedes:<
    set linebreak               " перенос строк по словам, а не по буквам
    set showmatch               " подсвечивать скобки
    set winminheight=0          " минимальная высота окна
    set winminwidth=0           " минимальная ширина окна
    set lazyredraw              " перерисовывать буфер менее плавно
    set shortmess=fimnrxoOtTI   " использовать сокращённые диалоги
    set confirm

    " if exists('+colorcolumn')
        " hi ColorColumn ctermbg=8 guibg=gray
        " set colorcolumn=+1
    " else
        " au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
    " endif

    " Edit
    set backspace=indent,eol,start
    set clipboard+=unnamed      " включаем X clipboard
    set virtualedit=all         " On virtualedit for all mode
    set go+=a                   " выделение в виме копирует в буфер системы

    set scrolloff=4             " 4 символа минимум под курсором
    set sidescroll=4
    set sidescrolloff=10        " 10 символов минимум под курсором при скролле

    " Enable mouse
    if &term =~ "xterm"
        set t_Co=256            " set 256 colors
        set background=dark     " set background color to dark
        colorscheme wombat256
        set ttyfast

        set mouse=a
        set mousemodel=popup
    endif
    set mousehide		" Hide the mouse when typing text

    " Autocomplete
    set completeopt=menu
    set infercase               " предлагать авто-дополнение на основе уже введённого регистра

    " Перемещать курсор на следующую строку при нажатии на клавиши вправо-влево и пр.
    set whichwrap=b,s,<,>,[,],l,h

    set modelines=0

    " set custom map leader to ','
    let mapleader = ","


" Plugins setup
" ==============

    " Taglist
    let Tlist_Compact_Format          = 1   " Do not show help
    let Tlist_Enable_Fold_Column      = 0   " Don't Show the fold indicator column
    let Tlist_Exit_OnlyWindow         = 1   " If you are last kill your self
    let Tlist_GainFocus_On_ToggleOpen = 1   " Jump to taglist window to open
    let Tlist_Show_One_File           = 1   " Displaying tags for only one file
    let Tlist_Use_Right_Window        = 1   " Split to rigt side of the screen
    let Tlist_Use_SingleClick         = 1   " Single mouse click open tag
    let Tlist_WinWidth                = 30  " Taglist win width
    let Tlist_Display_Tag_Scope       = 1   " Show tag scope next to the tag name
    let tlist_xslt_settings           = 'xslt;m:match;n:name;a:apply;c:call'
    let tlist_javascript_settings     = 'javascript;s:string;a:array;o:object;f:function'

    " XPTemplates
    let g:xptemplate_key = '<Tab>'
    let g:xptemplate_highlight = 'following'

    " NERDCommenter
    let NERDSpaceDelims = 1

    " NERDTree
    let NERDTreeWinSize = 30

    " Pylint compiler
    let g:pylint_show_rate = 0

    " Enable extended matchit
    runtime macros/matchit.vim

    " Chapa
    let g:chapa_default_mappings = 1


" Functions
" ==========

    " Keymap highlighter
    fun! rc#KeyMapHighlight()
        if &iminsert == 0
            hi StatusLine ctermbg=DarkBlue guibg=DarkBlue
        else
            hi StatusLine ctermbg=DarkRed guibg=DarkRed
        endif
    endfun
    call rc#KeyMapHighlight()

    " Key bind helper
    fun! rc#Map_ex_cmd(key, cmd)
      execute "nmap ".a:key." " . ":".a:cmd."<CR>"
      execute "cmap ".a:key." " . "<C-C>:".a:cmd."<CR>"
      execute "imap ".a:key." " . "<C-O>:".a:cmd."<CR>"
      execute "vmap ".a:key." " . "<Esc>:".a:cmd."<CR>gv"
    endfun

    " Option switcher helper
    fun! rc#Toggle_option(key, opt)
      call rc#Map_ex_cmd(a:key, "set ".a:opt."! ".a:opt."?")
    endfun

    " Sessions
    fun! rc#SessionRead(name)
        let s:name = g:SESSION_DIR.'/'.a:name.'.session'
        if getfsize(s:name) >= 0
            echo "Reading " s:name
            exe 'source '.s:name
            exe 'silent! source '.getcwd().'/.vim/.vimrc'
        else
            echo 'Not find session: '.a:name
        endif
    endfun

    fun! rc#SessionInput(type)
        let s:name = input(a:type.' session name? ')
        if a:type == 'Save'
            call rc#SessionSave(s:name)
        else
            call rc#SessionRead(s:name)
        endif
    endfun

    fun! rc#SessionSave(name)
        exe "mks! " g:SESSION_DIR.'/'.a:name.'.session'
        echo "Session" a:name "saved"
    endfun

    " Omni and dict completition
    fun! rc#AddWrapper()
        if exists('&omnifunc') && &omnifunc != ''
            return "\<C-X>\<C-o>\<C-p>"
        else
            return "\<C-N>"
        endif
    endfun

    " Recursive vimgrep
    fun! rc#RGrep()
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

        execute 'noautocmd vimgrep /'.pattern.'/gj '.startdir.'/**/'.filepattern | copen
    endfun

    " Shell command with buffer output
    command! -complete=shellcmd -nargs=+ Shell call rc#RunShellCommand(<q-args>)
    function! rc#RunShellCommand(cmdline)
        let isfirst = 1
        let words = []
        for word in split(a:cmdline)
            if isfirst
            let isfirst = 0  " don't change first word (shell command)
            else
            if word[0] =~ '\v[%#<]'
                let word = expand(word)
            endif
            let word = shellescape(word, 1)
            endif
            call add(words, word)
        endfor
        let expanded_cmdline = join(words)
        botright new
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
        call setline(1, 'You entered:  ' . a:cmdline)
        call setline(2, 'Expanded to:  ' . expanded_cmdline)
        call append(line('$'), substitute(getline(2), '.', '=', 'g'))
        silent execute '$read !'. expanded_cmdline
        1
    endfunction


" Autocommands
" =============

    if has("autocmd")

        filetype plugin indent on
  
        augroup vimrcEx
        au!

            " Auto reload vim settins
            au! bufwritepost rc.vim source ~/.vimrc

            " Highlight insert mode
            au InsertEnter * set cursorline
            au InsertLeave * set nocursorline
            
            " New file templates
            au BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl

            " Autosave last session
            if has('mksession') 
                au VimLeavePre * :call rc#SessionSave('last')
            endif

            " When editing a file, always jump to the last known cursor position.
            " Don't do it when the position is invalid or when inside an event handler
            " (happens when dropping a file on gvim).
            " Also don't do it when the mark is in the first line, that is the default
            " position when opening a file.
            autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

            au FocusLost * call rc#SaveBuffer()   " save current open file when wimdow focus is lost
            fun! rc#SaveBuffer() "{{{
                if filewritable(expand( '%' ))
                    exe "w"
                endif
            endfunction "}}}

            " Filetypes
            au BufRead,BufNewFile /etc/nginx/* set ft=nginx

        augroup END

    endif


" Hot keys 
" ==========

    " Insert mode
    " ------------

        " Omni and dict completition on space
        inoremap <Nul> <C-R>=rc#AddWrapper()<CR>
        inoremap <C-Space> <C-R>=rc#AddWrapper()<CR>

        " emacs style jump to end of line
        inoremap <C-E> <C-o>A
        inoremap <C-A> <C-o>I
    
    " Normal mode
    " ------------

        " Nice scrolling if line wrap
        noremap j gj
        noremap k gk

        " Set paste mode for paste from terminal
        nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

        " Split line in current cursor position
        map     <S-O>       i<CR><ESC>

        " Drop hightlight search result
        noremap <leader><space> :nohls<CR>
        noremap <space> za

        " Fast scrool
        nnoremap <C-e> 3<C-e>
        nnoremap <C-y> 3<C-y>

        " Select all
        map vA ggVG

        " Close cwindow
        noremap <silent> ,ll :ccl<CR>

        " Display next error"
        noremap <silent> ,nn :cn<CR>

        " Window commands
        noremap <silent> ,h :wincmd h<CR>
        noremap <silent> ,j :wincmd j<CR>
        noremap <silent> ,k :wincmd k<CR>
        noremap <silent> ,l :wincmd l<CR>
        noremap <silent> ,+ :wincmd +<CR>
        noremap <silent> ,- :wincmd -<CR>
        noremap <silent> ,sb :wincmd p<CR>
        noremap <silent> ,cj :wincmd j<CR>:close<CR>
        noremap <silent> ,ck :wincmd k<CR>:close<CR>
        noremap <silent> ,ch :wincmd h<CR>:close<CR>
        noremap <silent> ,cl :wincmd l<CR>:close<CR>
        noremap <silent> ,cw :close<CR>

        " Buffer commands
        noremap <silent> ,bp :bp<CR>
        noremap <silent> ,bn :bn<CR>
        noremap <silent> ,bw :w<CR>
        noremap <silent> ,bd :bd<CR>
        noremap <silent> ,ls :ls<CR>

        " Delete all buffers
        nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

        " Search the current file for the word under the cursor and display matches
        nmap <silent> ,gw :call rc#RGrep()<CR>

        " Open new tab
        call rc#Map_ex_cmd("<C-W>t", ":tabnew")

        " Tab navigation
        map <A-1> 1gt
        map <A-2> 2gt
        map <A-3> 3gt
        map <A-4> 4gt
        map <A-5> 5gt
        map <A-6> 6gt
        map <A-7> 7gt
        map <A-8> 8gt
        map <A-9> 9gt

        " первая вкладка
        call rc#Map_ex_cmd("<A-UP>", ":tabfirst")
        " последняя вкладка
        call rc#Map_ex_cmd("<A-DOWN>", ":tablast")
        " переместить вкладку в начало
        nmap Q :tabmove 0<cr>
        " переместить вкладку в конец
        call rc#Map_ex_cmd("<C-DOWN>", ":tabmove")

        " Переключение раскладок будет производиться по <C-F>
        cmap <silent> <C-F> <C-^>
        imap <silent> <C-F> <C-^>X<Esc>:call rc#KeyMapHighlight()<CR>a<C-H>
        nmap <silent> <C-F> a<C-^><Esc>:call rc#KeyMapHighlight()<CR>
        vmap <silent> <C-F> <Esc>a<C-^><Esc>:call rc#KeyMapHighlight()<CR>gv
    
        " Запуск/сокрытие плагина NERDTree
        call rc#Map_ex_cmd("<F1>", "NERDTree")

        " Toggle cwindow
        call rc#Map_ex_cmd("<F2>", "cw")
        
        " Запуск/сокрытие плагина Tlist
        call rc#Map_ex_cmd("<F3>", "TlistToggle")

        call rc#Toggle_option("<F6>", "list")      " Переключение подсветки невидимых символов
        call rc#Toggle_option("<F7>", "wrap")      " Переключение переноса слов

        " Git fugitive menu
        map <F9> :emenu G.<TAB>
        menu G.Diff :Gdiff<CR>
        menu G.Status :Gstatus<CR>
        menu G.Log :Glog<CR>
        menu G.Write :Gwrite<CR>
        menu G.Blame :Gblame<CR>
        menu G.Move :Gmove<CR>
        menu G.Remove :Gremove<CR>
        menu G.Grep :Ggrep<CR>
        menu G.Split :Gsplit<CR>

        " Закрытие файла
        call rc#Map_ex_cmd("<F10>", "qall")
        call rc#Map_ex_cmd("<S-F10>", "qall!")

        " Список регистров 
        call rc#Map_ex_cmd("<F11>", "reg")

        " Список меток
        call rc#Map_ex_cmd("<F12>", "marks")

        " Session UI
        nmap <Leader>ss :call rc#SessionInput('Save')<CR>
        nmap <Leader>sr :call rc#SessionInput('Read')<CR>
        nmap <Leader>sl :call rc#SessionRead('last')<CR>

    " Command mode
    " ------------

        " Allow command line editing like emacs
        cnoremap <C-A>      <Home>
        cnoremap <C-B>      <Left>
        cnoremap <C-E>      <End>
        cnoremap <C-F>      <Right>
        cnoremap <C-N>      <Down>
        cnoremap <C-P>      <Up>


" GUI settings
" ============

    " Some gui settings
    if has("gui_running")
        " Set up the gui cursor to look nice
        set guicursor=n-v-c:block-Cursor-blinkon0
        set guicursor+=ve:ver35-Cursor
        set guicursor+=o:hor50-Cursor
        set guicursor+=i-ci:ver25-Cursor
        set guicursor+=r-cr:hor20-Cursor
        set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
        set guioptions=ac
        set guifont=Monaco\ 11
        colorscheme wombat256
        if !exists("g:vimrcloaded")
            winpos 0 0
            if ! &diff
                winsize 130 90
            else
                winsize 227 90
            endif
            let g:vimrcloaded = 1
        endif
    endif


" Project settings
" ================

    if !exists('s:loaded_my_vimrc')
        " auto load .vim/.vimrc from current directory
        exe 'silent! source '.getcwd().'/.vim/.vimrc'
        let s:loaded_my_vimrc = 1
    endif


set secure  " must be written at the last.  see :help 'secure'.
