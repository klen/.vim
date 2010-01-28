" ------------------------------
" .vimrc klen <horneds@gmail.com>


" ------------------------------
" Настройки

    " Разное
    set nocompatible            " отключаем совместимость с vi
    set hidden                  " не требовать сохранения буфера
    set title                   " показывать имя файла в заголовке окна
    set autoread                " отслеживать изменения файлов
    set visualbell              " ошибки без писка
    set modeline                " читать параметры конфигурации из открытого файла
    set magic                   " добавим магии

    " Отступы
    set autoindent              " копирует отступ от предыдущей строки
    set smartindent             " включаем 'умную' автоматическую расстановку отступов

    " Бэкап и своп файлы
    set nobackup                " Отключаем создание бэкапов
    set directory=~/.vim/swap   " Хранить swap в отдельном каталоге
    set history=400             " История командной строки
    set viminfo+=h              " Хранить историю

    " Табуляция
    set expandtab
    set smarttab
    set shiftwidth=4            " Размер сдвига при нажатии на клавиши << и >>
    set softtabstop=4           " Табуляция 4 пробела
    set shiftround              " удалять лишние пробелы при отступе

    " Опции поиска
    set hlsearch                " Подсветка результатов
    set ignorecase              " Игнорировать регистр букв при поиске
    set incsearch               " При поиске перескакивать на найденный текст в процессе набора строки
    set smartcase               " Игнорировать предыдущую опцию если в строке поиска есть буквы разного регистра

    " Локализация
    set keymap=russian-jcukenwin " Переключение раскладок клавиатуры по <C-^>
    set iminsert=0              " Раскладка по умолчанию - английская
    set imsearch=0              " Раскладка по умолчанию при поиске - английская
    set spelllang=en,ru         " Языки для проверки правописания
    set encoding=utf-8
    set fileencodings=utf-8,cp1251,koi8-r,cp866
    set termencoding=utf-8

    " Строка статуса и командная строка
    set laststatus=2            " всегда отображать статусную строку для каждого окна
    set showtabline=2           " показывать строку вкладок всегда
    set shortmess=tToOI
    set showcmd                 " отображение команд
    set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
    set wildmenu                " использовать wildmenu ...
    set wildcharm=<TAB>         " ... с авто-дополнением

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
    filetype plugin on          " определять подсветку на основе кода файла
    filetype indent on

    " Настройка цветовой схемы
    set t_Co=256
    set background=dark         " говорим виму, что наш цвет терминала темный
    colorscheme wombat256

    " Включаем мышку даже в текстовом режиме
    if &term =~ "xterm"
        set mouse=a
        set mousemodel=popup
    endif

    " Опции автодополнения
    set completeopt=menu
    set infercase               " предлагать авто-дополнение на основе уже введённого регистра


    " Перемещать курсор на следующую строку при нажатии на клавиши вправо-влево и пр.
    set whichwrap=b,s,<,>,[,],l,h

    " Опции сессии
    set sessionoptions=curdir,buffers,tabpages

    " Подключение тег файла
    set tags=tags

    " Настройки для плагинов
    let Tlist_GainFocus_On_ToggleOpen = 1
    let Tlist_Close_On_Select         = 1
    let Tlist_Exit_OnlyWindow         = 1
    let Tlist_Show_One_File           = 1
    let Tlist_Use_Right_Window        = 1
    let Tlist_Compact_Format          = 1
    let Tlist_Enable_Fold_Column      = 0
    let Grep_Skip_Dirs                = 'RCS CVS SCCS .svn'
    let Grep_Cygwin_Find              = 1


" ------------------------------
" Функции

    let DisableI = 1
    function! DisableIndent()
        if g:DisableI == 1
            execute "set noautoindent nosmartindent"
            echo "Disable auto indent"
            let g:DisableI = 0
        else
            execute "set autoindent smartindent"
            let g:DisableI = 1
            echo "Enable auto indent"
        endif
    endfunction

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

    " Автоматическая перезагрузка настроек после редактирования
    au! bufwritepost rc.vim source ~/.vimrc

    " Автоматическое сохранение последней сессии
    autocmd VimLeavePre * silent mksession! ~/.lastVimSession

    " Автоматическая загрузка последней сессии
    "autocmd VimEnter * silent source! ~/.lastVimSession

    " Подсветка режима вставки
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline
    autocmd InsertEnter * highlight CursorLine ctermbg=DarkBlue
    autocmd InsertLeave * highlight CursorLine ctermbg=236
    "autocmd CmdwinEnter * highlight StatusLine ctermbg=52
    "autocmd CmdwinLeave * highlight StatusLine ctermbg=236


" ------------------------------
" Горячие клавиши 
"
    " Выход из режима вставки
    imap    jj          <Esc>
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
    map <F8> :call DisableIndent()<CR>

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

    function! BufNewFile_PY()
        0put = '#!/usr/bin/env python'
        1put = '#-*- coding: utf-8 -*-'
        3put = ''
        4put = ''
        normal G
    endfunction

    autocmd BufNewFile *.py call BufNewFile_PY()
