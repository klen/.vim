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
    set scrolloff=5
    set sidescroll=4
    set sidescrolloff=10

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

    " Подсветка текущей раскладки
    function! MyKeyMapHighlight()
        if &iminsert == 0
            hi StatusLine ctermfg=Blue guifg=Blue
        else
            hi StatusLine ctermfg=Green guifg=Green
        endif
    endfunction

    call MyKeyMapHighlight()

    au WinEnter * :call MyKeyMapHighlight()

    " Биндинг клавиш"
    function! Map_ex_cmd(key, cmd)
      execute "nmap ".a:key." " . ":".a:cmd."<CR>"
      execute "cmap ".a:key." " . "<C-C>:".a:cmd."<CR>"
      execute "imap ".a:key." " . "<C-O>:".a:cmd."<CR>"
      execute "vmap ".a:key." " . "<Esc>:".a:cmd."<CR>gv"
    endfunction

    function! Toggle_option(key, opt)
      call Map_ex_cmd(a:key, "set ".a:opt."! ".a:opt."?")
    endfunction

" ------------------------------
" Горячие клавиши 
"
    " Пробел пролистывает страницы
    map     <Space>     <PageDown>
    " Выход из режима вставки
    imap    jj          <Esc>
    " Новая строка и выход из режима вставки
    map     <S-O>       i<CR><ESC>
    " Вставить новую строку без переключения режима
    nmap    <CR>        o<ESC>k
    " Дерево файлов
    map     <Leader>f   :find<CR>
    " Перегрузка настроек
    map     <Leader>s   :source ~/.vimrc<CR>
    " Быстрое редактирование настроек
    map     <Leader>e   :e! ~/.vimrc<CR>

    " Автоматическая перезагрузка настроек после редактирования
    autocmd! bufwritepost rc.vim source ~/.vimrc

    " Клавиши для быстрой смены синтаксиса
    map     <Leader>1   :set syntax=cheetah<CR>
    map     <Leader>2   :set syntax=xhtml<CR>
    map     <Leader>3   :set syntax=python<CR>
    map     <Leader>4   :set ft=javascript<CR>
    map     <Leader>5   :syntax sync fromstart<CR>

    autocmd BufEnter * :syntax sync fromstart

    " Работа с вкладками
    " новая вкладка
    call Map_ex_cmd("<C-W>t", ":tabnew")
    " предыдущая вкладка
    call Map_ex_cmd("<silent><A-LEFT>", ":call TabJump('left')")
    " следующая вкладка
    call Map_ex_cmd("<silent><A-RIGHT>", ":call TabJump('right')")
    " первая вкладка
    call Map_ex_cmd("<A-UP>", ":tabfirst")
    " последняя вкладка
    call Map_ex_cmd("<A-DOWN>", ":tablast")
    " переместить вкладку в начало
    call Map_ex_cmd("<C-UP>", ":tabmove 0")
    " переместить вкладку в конец
    call Map_ex_cmd("<C-DOWN>", ":tabmove")
    " переместить вкладку назад
    call Map_ex_cmd("<silent><C-LEFT>", ":call TabMove('left')")
    " переместить вкладку вперёд
    call Map_ex_cmd("<silent><C-RIGHT>", ":call TabMove('right')")
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

    " Переключение раскладок будет производиться по <C-F>
    cmap <silent> <C-F> <C-^>
    imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
    nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
    vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
 
    " Автозакрытие скобок
    imap ( ()<ESC>:let leavechar=")"<CR>i
    imap [ []<ESC>:let leavechar="]"<CR>i
    imap { {}<ESC>:let leavechar="}"<CR>i
    imap ,, <ESC>:exec "normal f" . leavechar<CR>a

    " Запуск/сокрытие плагина Tlist
    call Map_ex_cmd("<silent><F1>", "TlistToggle")

    " Сохранение файла
    call Map_ex_cmd("<F2>", "write")

    " Запуск/сокрытие плагина NERDTree
    call Map_ex_cmd("<silent><F3>", "NERDTreeToggle")

    
    call Map_ex_cmd("<F5>", "nohlsearch")   " Выключить подсветку результатов поиска
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

    " Твиттер, куда же без него :)
    fu! LoginTwitter()
        let a:user=input("Your twitter login: ")
        let a:pswd=inputsecret(a:user."'s password: ")
        let g:twitvim_login=a:user.':'.a:pswd
        echo "Credentials are saved"
    endf
    command! Twil :call LoginTwitter()
    " Twitter mappings
    nmap <C-T>p :PosttoTwitter<cr>
    nmap <C-T>f :FriendsTwitter<cr>
    nmap <C-T>l :Twil<cr>

    " Автоматическое сохранение последней сессии
    autocmd VimLeavePre * silent mksession! ~/.lastVimSession

    " Автоматическая загрузка последней сессии
    "autocmd VimEnter * silent source! ~/.lastVimSession

    " Подсветка режима вставки
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline
    autocmd InsertEnter * highlight StatusLine ctermbg=52
    autocmd InsertLeave * highlight StatusLine ctermbg=236
    autocmd CmdwinEnter * highlight StatusLine ctermbg=22
    autocmd CmdwinLeave * highlight StatusLine ctermbg=236

    function! BufNewFile_PY()
        0put = '#!/usr/bin/env python'
        1put = '#-*- coding: utf-8 -*-'
        3put = ''
        4put = ''
        normal G
    endfunction

    autocmd BufNewFile *.py call BufNewFile_PY()

    " Работа с клипбордом для вима собранного без опции clipboard
    map <C-V> <Esc>:let @c = system('xclip -o')<CR>"cp
