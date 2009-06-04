" ------------------------------
" .vimrc klen <horneds@gmail.com>


" ------------------------------
" Настройки

    " Разное
    set nocompatible            " Отключаем совместимость с vi
    set hidden                  " Не требовать сохранения буфера
    set title                   " Показывать имя файла в заголовке окна
    set autoread                " Отслеживать изменения файлов
    set visualbell              " Ошибки без писка
    set magic                   " Добавим магии

    " Отступы
    set autoindent              " Копирует отступ от предыдущей строки
    set smartindent             " Включаем 'умную' автоматическую расстановку отступов

    " Бэкап и своп файлы
    set nobackup                " Отключаем создание бэкапов
    set noswapfile              " Отключаем создание swap файлов
    set history=400             " История командной строки
    set viminfo+=h              " Хранить историю

    " Табуляция
    set expandtab
    set smarttab
    set shiftwidth=4            " Размер сдвига при нажатии на клавиши << и >>
    set softtabstop=4           " Табуляция 4 пробела

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
    set laststatus=2            " Всегда отображать статусную строку для каждого окна
    set shortmess=tToOI
    set showcmd                 " Отображение команд
    set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
    set wildmenu

    " Отображение
    set foldenable
    set foldclose=all
    set foldmethod=syntax
    set listchars+=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
    set noequalalways
    set wrap                    " Перенос строк
    set linebreak               " Перенос строк по словам, а не по буквам
    set showmatch               " Подсвечивать скобки
    set winminheight=0          " Минимальная высота окна
    set winminwidth=0           " Минимальная ширина окна

    " Редактирование
    set backspace=indent,eol,start
    set clipboard+=unnamed      " Включаем X clipboard
    set virtualedit=block
    set go+=a                   " Выделение в виме копирует в буфер системы

    " Скролл
    set scrolloff=5
    set sidescroll=4
    set sidescrolloff=10

    " Подсветка синтаксиса и прочее
    syntax on
    filetype on
    filetype plugin on
    filetype indent on

    " Настройка цветовой схемы
    set t_Co=256
    set background=dark         " Говорим виму, что наш цвет терминала темный
    colorscheme wombat256

    " Включаем мышку даже в текстовом режиме
    if &term =~ "xterm"
        set mouse=a
        set mousemodel=popup
    endif

    " Опции автодополнения
    set completeopt=menu

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
    function MyKeyMapHighlight()
        if &iminsert == 0
            hi StatusLine ctermfg=DarkBlue guifg=DarkBlue
        else
            hi StatusLine ctermfg=DarkGreen guifg=DarkGreen
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
    " Новая вкладка
    map     <C-W>t      :tabnew<CR>
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

    " Запуск/сокрытие плагина MiniBufExplorer
    call Map_ex_cmd("<silent><F4>", "TMiniBufExplorer")

    
    call Map_ex_cmd("<F5>", "nohlsearch")   " Выключить подсветку результатов поиска
    call Toggle_option("<F6>", "list")      " Переключение подсветки невидимых символов
    call Toggle_option("<F7>", "wrap")      " Переключение переноса слов

    " Меню работы с (VCS plugin
    map <F9> :emenu VCS.<TAB>
    menu VCS.Add :VCSAdd<CR>
    menu VCS.Annotate :VCSAnnotate<CR>
    menu VCS.Commit :VCSCommit<CR>
    menu VCS.Delete :VCSDelete<CR>
    menu VCS.Diff :VCSDiff<CR>
    menu VCS.Log :VCSLog<CR>
    menu VCS.Revert :VCSRevert<CR>
    menu VCS.Status :VCSStatus<CR>
    menu VCS.Update :VCSUpdate<CR>
    menu VCS.VimDiff :VCSVimDiff<CR>

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

