" ------------------------------
" .vimrc klen <horneds@gmail.com>


" ------------------------------
" Setup

    if !exists('s:loaded_my_vimrc')
    " Don't reset twice on reloading - 'compatible' has SO many side effects.
        set nocompatible  " to use many extensions of Vim.
        " Create special directory for backup and swap
        if finddir($HOME.'/.data/') == ''
            silent call mkdir($HOME.'/.data/')
        endif

        if finddir($HOME.'/.data/backup') == ''
            silent call mkdir($HOME.'/.data/backup')
        endif
        set backup                  " make backup file and leave it around 
        set backupdir=$HOME/.data/backup    " where to put backup file 
        set backupskip&
        set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp

        if finddir($HOME.'/.data/swap') == ''
            silent call mkdir($HOME.'/.data/swap')
        endif
        set directory=$HOME/.data/swap      " where to put swap file 

        if finddir($HOME.'/.data/sessions') == ''
            silent call mkdir($HOME.'/.data/sessions')
        endif
        let g:session_dir = $HOME.'/.data/sessions'

    endif

    set hidden                  " не требовать сохранения буфера
    set title                   " показывать имя файла в заголовке окна
    set autoread                " отслеживать изменения файлов
    set visualbell              " ошибки без писка
    set modeline                " читать параметры конфигурации из открытого файла
    set magic                   " добавим магии

    " Indent and tabulation
    set autoindent              " копирует отступ от предыдущей строки
    set smartindent             " включаем 'умную' автоматическую расстановку отступов
    set expandtab
    set smarttab
    set shiftwidth=4            " Размер сдвига при нажатии на клавиши << и >>
    set softtabstop=4           " Табуляция 4 пробела
    set shiftround              " удалять лишние пробелы при отступе

    " Backup and swap files
    set history=400                     " history length
    set viminfo+=h                      " save history

    " Search options
    set hlsearch                " Подсветка результатов
    set ignorecase              " Игнорировать регистр букв при поиске
    set incsearch               " При поиске перескакивать на найденный текст в процессе набора строки
    set smartcase               " Игнорировать предыдущую опцию если в строке поиска есть буквы разного регистра

    " Localization
    set langmenu=none            " Always use english menu
    set keymap=russian-jcukenwin " Переключение раскладок клавиатуры по <C-^>
    set iminsert=0               " Раскладка по умолчанию - английская
    set imsearch=0               " Раскладка по умолчанию при поиске - английская
    set spelllang=en,ru          " Языки для проверки правописания
    set encoding=utf-8
    set fileencodings=utf-8,cp1251,koi8-r,cp866
    set termencoding=utf-8

    " Строка статуса и командная строка
    set laststatus=2            " всегда отображать статусную строку для каждого окна
    set showtabline=2           " показывать строку вкладок всегда
    set shortmess=tToOI
    set showcmd                 " show command
    set showmode                " show mode
    set statusline=%<%f%h%m
    set statusline+=%#Error#%r%*%=
    set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*\ type=%Y\ format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
    set wildmenu                " использовать wildmenu ...
    set wildcharm=<TAB>         " ... с авто-дополнением
    set wildignore=*.pyc        " Игнорировать pyc файлы

    " Отображение
    set foldenable
    set foldclose=all
    set foldmethod=syntax
    set foldnestmax=3           "deepest fold is 3 levels
    set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo    " This commands open folds
    set listchars+=tab:>-,trail:-,extends:>,precedes:<,nbsp:~
    set wrap                    " перенос строк
    set linebreak               " перенос строк по словам, а не по буквам
    set showmatch               " подсвечивать скобки
    set winminheight=0          " минимальная высота окна
    set winminwidth=0           " минимальная ширина окна
    set lazyredraw              " перерисовывать буфер менее плавно
    set confirm                 " использовать диалоги вместо сообщений об ошибках
    set shortmess=fimnrxoOtTI   " использовать сокращённые диалоги

    " Редактирование
    set backspace=indent,eol,start
    set clipboard+=unnamed      " включаем X clipboard
    set virtualedit=block
    set go+=a                   " выделение в виме копирует в буфер системы

    " Скролл
    set scrolloff=8             " 4 символа минимум под курсором
    set sidescroll=8
    set sidescrolloff=10        " 10 символов минимум под курсором при скролле

    " Подсветка синтаксиса и прочее
    syntax on

    " Customization
    set t_Co=256                " set 256 colors
    set background=dark         " set background color to dark
    colorscheme wombat256       " set default theme

    " enable mouse
    if &term =~ "xterm"
        set mouse=a
        set mousemodel=popup
    endif
    set mousehide		" Hide the mouse when typing text

    " Опции автодополнения
    set completeopt=menu
    set infercase               " предлагать авто-дополнение на основе уже введённого регистра

    " Перемещать курсор на следующую строку при нажатии на клавиши вправо-влево и пр.
    set whichwrap=b,s,<,>,[,],l,h

    " Подключение тег файла
    set tags=tags


    " Plugins setup
    " Taglist
    let Tlist_GainFocus_On_ToggleOpen = 1   " Jump to taglist window to open
    let Tlist_Close_On_Select         = 0   " Close taglist when a file or tag selected
    let Tlist_Exit_OnlyWindow         = 1   " If you are last kill your self
    let Tlist_Show_One_File           = 1   " Displaying tags for only one file
    let Tlist_Use_Right_Window        = 1   " split to rigt side of the screen
    let Tlist_Compart_Format          = 1   " Remove extra information and blank lines from taglist window
    let Tlist_Compact_Format          = 1   " Do not show help
    let Tlist_Enable_Fold_Column      = 0   " Don't Show the fold indicator column
    let Tlist_WinWidth                = 30  " Taglist win width
    let Tlist_Display_Tag_Scope       = 1   " Show tag scope next to the tag name
    let Tlist_BackToEditBuffer        = 0   " If no close on select, let the user choose back to edit buffer or not

    let Grep_Skip_Dirs                = 'RCS CVS SCCS .svn'
    let Grep_Cygwin_Find              = 1

    " Syntastic
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1

    " Comment with space
    let NERDSpaceDelims = 1

" ------------------------------
" Функции

    " Подсветка текущей раскладки
    fun! MyKeyMapHighlight()
        if &iminsert == 0
            hi StatusLine ctermfg=White
            hi StatusLine ctermbg=Blue
        else
            hi StatusLine ctermbg=Red
        endif
    endfun
    call MyKeyMapHighlight()

    " Биндинг клавиш"
    fun! Map_ex_cmd(key, cmd)
      execute "nmap ".a:key." " . ":".a:cmd."<CR>"
      execute "cmap ".a:key." " . "<C-C>:".a:cmd."<CR>"
      execute "imap ".a:key." " . "<C-O>:".a:cmd."<CR>"
      execute "vmap ".a:key." " . "<Esc>:".a:cmd."<CR>gv"
    endfun

    " Биндинг переключалки опций
    fun! Toggle_option(key, opt)
      call Map_ex_cmd(a:key, "set ".a:opt."! ".a:opt."?")
    endfun

    " передвигаемся по вкладкам
    fun! TabJump(direction)
        let l:tablen=tabpagenr('$')
        let l:tabcur=tabpagenr()
        if a:direction=='left'
            if l:tabcur>1
                execute 'tabprevious'
            endif
        else
            if l:tabcur!=l:tablen
                execute 'tabnext'
            endif
        endif
    endfun

" ------------------------------
" Автокоманды

    if has("autocmd")

        filetype plugin indent on
  
        augroup vimrcEx
        au!

        " Подсветка раскладки
        au WinEnter * :call MyKeyMapHighlight()

        " Auto reload vim settins
        au! bufwritepost rc.vim source ~/.vimrc

        " Highlight insert mode
        au InsertEnter * set cursorline
        au InsertLeave * set nocursorline
        au InsertEnter * highlight CursorLine ctermbg=DarkBlue
        au InsertLeave * highlight CursorLine ctermbg=236

        " New file templates
        au BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl

        "Omni complete settings
        au FileType python set omnifunc=pythoncomplete#Complete
        au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        au FileType html set omnifunc=htmlcomplete#CompleteTags
        au FileType css set omnifunc=csscomplete#CompleteCSS

        if has('mksession') 
            au VimLeavePre * :call SessionSave('last')
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

        augroup END

    endif

" ------------------------------
" Горячие клавиши 
"
    " Выход из режима вставки
    imap    jj          <Esc>
    "uses space to toggle folding
    nnoremap <space> za
    vnoremap <space> zf
    " Новая строка и выход из режима вставки
    map     <S-O>       i<CR><ESC>
    " Вставить новую строку без переключения режима
    nmap    <CR>        o<ESC>k
    " Поиск по файлам
    map     <Leader>f   :vimgrep /.*\<<c-r>=expand("<cword>")<CR>\> ../**/*<CR>
    inoremap <Nul> <C-x><C-o>

    " Работа с вкладками
    " новая вкладка
    call Map_ex_cmd("<C-W>t", ":tabnew")
    " предыдущая вкладка
    nmap Z :call TabJump('left')<cr>
    " следующая вкладка
    nmap X :call TabJump('right')<cr>
    " первая вкладка
    call Map_ex_cmd("<A-UP>", ":tabfirst")
    " последняя вкладка
    call Map_ex_cmd("<A-DOWN>", ":tablast")
    " переместить вкладку в начало
    nmap Q :tabmove 0<cr>
    " переместить вкладку в конец
    call Map_ex_cmd("<C-DOWN>", ":tabmove")

    " Переключение раскладок будет производиться по <C-F>
    cmap <silent> <C-F> <C-^>
    imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
    nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
    vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
 
    " Запуск/сокрытие плагина Tlist
    call Map_ex_cmd("<silent><F1>", "TlistToggle")

    " Сохранение файла
    call Map_ex_cmd("<F2>", "write")

    " Рекурсивный поиск строки в файлах
    call Map_ex_cmd("<F3>", "Rgrep")

    " Запуск/сокрытие плагина NERDTree
    call Map_ex_cmd("<silent><F4>", "NERDTreeToggle")
    
    call Map_ex_cmd("<F5>", "nohls")   " Выключить подсветку результатов поиска
    call Toggle_option("<F6>", "list")      " Переключение подсветки невидимых символов
    call Toggle_option("<F7>", "wrap")      " Переключение переноса слов

    " Меню работы с (VCS plugin
    map <F9> :emenu VCS.<TAB>
    menu VCS.VimDiff :VCSVimDiff<CR>
    menu VCS.Commit :VCSCommit<CR>
    menu VCS.Revert :VCSRevert<CR>
    menu VCS.Add :VCSAdd<CR>
    menu VCS.Delete :VCSDelete<CR>
    menu VCS.Log :VCSLog<CR>
    menu VCS.Update :VCSUpdate<CR>

    " Закрытие файла
    call Map_ex_cmd("<F10>", "qall")
    call Map_ex_cmd("<S-F10>", "qall!")

    " Список регистров 
    call Map_ex_cmd("<F11>", "reg")

    " Список меток
    call Map_ex_cmd("<F12>", "marks")

    " Sessions
    fun! SessionRead(name)
        let s:name = g:session_dir.'/'.a:name.'.session'
        if getfsize(s:name) >= 0
            echo "Reading " s:name
            exe 'source '.s:name
        endif
    endfun

    fun! SessionSave(name)
        exe "mks! " g:session_dir.'/'.a:name.'.session'
        echo "Session" a:name "saved"
    endfun

    com! Ssave :call SessionSave(<args>)
    com! Sread :call SessionRead(<args>)

    " Загрузка настроек VIM (.vimrc) из рабочей директории
    fun! s:LoadDirVimSettings(path)
        let s:filename = a:path.'/.vim/.vimrc'
        if filereadable(s:filename) != 0
            exe 'source '.s:filename
        endif
    endfun

    if !exists('s:loaded_my_vimrc')
        call s:LoadDirVimSettings(getcwd())
    endif

    let s:loaded_my_vimrc = 1       " Fin
    set secure  " must be written at the last.  see :help 'secure'.

