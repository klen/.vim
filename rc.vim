" ------------------------------
" .vimrc klen <horneds@gmail.com>


" ------------------------------
" Setup

    if !exists('s:loaded_my_vimrc')
    " Don't reset twice on reloading - 'compatible' has SO many side effects.
        set nocompatible  " to use many extensions of Vim.
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
    set backup                  " make backup file and leave it around 
    if finddir($HOME.'/.data/') == ''
        silent call mkdir($HOME.'/.data/')
    endif
    if finddir($HOME.'/.data/backup') == ''
        silent call mkdir($HOME.'/.data/backup')
    endif
    if finddir($HOME.'/.data/swap') == ''
        silent call mkdir($HOME.'/.data/swap')
    endif
    set backupdir=$HOME/.data/backup    " where to put backup file 
    set backupskip&
    set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp
    set directory=$HOME/.data/swap      " where to put swap file 
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
    set statusline=%<%f%h%m%r%=%#warningmsg#%{SyntasticStatuslineFlag()}%*\ format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
    set wildmenu                " использовать wildmenu ...
    set wildcharm=<TAB>         " ... с авто-дополнением
    set wildignore=*.pyc        " Игнорировать pyc файлы

    " Отображение
    set foldenable
    set foldclose=all
    set foldmethod=syntax
    set foldnestmax=3           "deepest fold is 3 levels
    set nofoldenable            "dont fold by default
    set listchars+=tab:>-,trail:-,extends:>,precedes:<,nbsp:~
    set noequalalways
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
    set scrolloff=4             " 4 символа минимум под курсором
    set sidescroll=4
    set sidescrolloff=10        " 10 символов минимум под курсором при скролле

    " Подсветка синтаксиса и прочее
    syntax on
    filetype on
    filetype plugin on
    filetype indent on

    " Customization
    set t_Co=256                " set 256 colors
    set background=dark         " set background color to dark
    colorscheme wombat256       " set default theme

    " enable mouse
    if &term =~ "xterm"
        set mouse=a
        set mousemodel=popup
    endif

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

    " Supertab
    let g:SuperTabDefaultCompletionType    = 'context'

    let Grep_Skip_Dirs                = 'RCS CVS SCCS .svn'
    let Grep_Cygwin_Find              = 1

    " Syntastic
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1

" ------------------------------
" Функции

    " Подсветка текущей раскладки
    function! MyKeyMapHighlight()
        if &iminsert == 0
            hi StatusLine ctermfg=White
            hi StatusLine ctermbg=Blue
        else
            hi StatusLine ctermbg=Red
        endif
    endfunction
    call MyKeyMapHighlight()

    " Биндинг клавиш"
    function! Map_ex_cmd(key, cmd)
      execute "nmap ".a:key." " . ":".a:cmd."<CR>"
      execute "cmap ".a:key." " . "<C-C>:".a:cmd."<CR>"
      execute "imap ".a:key." " . "<C-O>:".a:cmd."<CR>"
      execute "vmap ".a:key." " . "<Esc>:".a:cmd."<CR>gv"
    endfunction

    " Биндинг переключалки опций
    function! Toggle_option(key, opt)
      call Map_ex_cmd(a:key, "set ".a:opt."! ".a:opt."?")
    endfunction

    " передвигаемся по вкладкам
    function! TabJump(direction)
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
    endfunction

    " передвигаем вкладки
    function! TabMove(direction)
        let l:tablen=tabpagenr('$')
        let l:tabcur=tabpagenr()
        if a:direction=='left'
            if l:tabcur>1
                execute 'tabmove' l:tabcur-2
            endif
        else
            if l:tabcur!=l:tablen
                execute 'tabmove' l:tabcur
            endif
        endif
    endfunction


" ------------------------------
" Автокоманды

    " Подсветка раскладки
    au WinEnter * :call MyKeyMapHighlight()

    " Auto reload vim settins
    au! bufwritepost rc.vim source ~/.vimrc

    " Auto load last session
    "au VimEnter * silent source! ~/.lastVimSession

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

" ------------------------------
" Горячие клавиши 
"
    " Выход из режима вставки
    imap    jj          <Esc>
    "uses space to toggle folding
    nnoremap <space> za
    vnoremap <space> zf
    "   ]t      -- Jump to beginning of block
    map  ]t   :PBoB<CR>
    vmap ]t   :<C-U>PBOB<CR>m'gv``
    "   ]e      -- Jump to end of block
    map  ]e   :PEoB<CR>
    vmap ]e   :<C-U>PEoB<CR>m'gv``
    "   ]v      -- Select (Visual Line Mode) block
    map  ]v   ]tV]e
    "   ]<      -- Shift block to left
    map  ]<   ]tV]e<
    vmap ]<   <
    "   ]>      -- Shift block to right
    map  ]>   ]tV]e>
    vmap ]>   >
    " Новая строка и выход из режима вставки
    map     <S-O>       i<CR><ESC>
    " Вставить новую строку без переключения режима
    nmap    <CR>        o<ESC>k
    " Поиск по файлам
    map     <Leader>f   :vimgrep /.*\<<c-r>=expand("<cword>")<CR>\> ../**/*<CR>

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
    " переместить вкладку назад
    call Map_ex_cmd("<silent><C-LEFT>", ":call TabMove('left')")
    " переместить вкладку вперёд
    call Map_ex_cmd("<silent><C-RIGHT>", ":call TabMove('right')")

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
    function! s:SID_PREFIX()
        return matchstr(expand('<sfile>'), '<SNR>\d\+_')
    endfunction

    function! s:gettabvar(tabpagenr, varname)  "{{{2
    " Wrapper for non standard (my own) built-in function gettabvar().
        return exists('*gettabvar') ? gettabvar(a:tabpagenr, a:varname) : ''
    endfunction

    function! s:my_tabline() 
    let s = ''
    
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let curbufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    
        let no = (i <= 10 ? i-1 : '#')  " display 0-origin tabpagenr.
        let mod = len(filter(bufnrs, 'getbufvar(v:val, "&modified")')) ? '+' : ' '
        let title = s:gettabvar(i, 'title')
        let title = len(title) ? title : fnamemodify(s:gettabvar(i, 'cwd'), ':t')
        let title = len(title) ? title : fnamemodify(bufname(curbufnr),':t')
        let title = len(title) ? title : '[No Name]'
    
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no
        let s .= mod
        let s .= title
        let s .= '%#TabLineFill#'
        let s .= '  '
    endfor
    
    let s .= '%#TabLineFill#%T'
    let s .= '%=%#TabLine#'
    let s .= '| '
    let s .= '%999X'
    return s
    endfunction "}}}
    let &tabline = '%!' . s:SID_PREFIX() . 'my_tabline()'

    " Fin.  "
    if !exists('s:loaded_my_vimrc')
        let s:loaded_my_vimrc = 1
    endif
 

    set secure  " must be written at the last.  see :help 'secure'.
