""" Конфигурационный файл для python files

    setlocal foldlevelstart=1
    setlocal foldlevel=1
    setlocal foldmethod=syntax

    " Набор слов для переносов
    setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
    set cindent

    " Поиск по документаци
    " setlocal keywordprg=pydoc

    setlocal textwidth=79
    setlocal formatoptions-=t

    "Trim trailing whitespace
    au FileType python autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

    " Улучшенная подсветка синтаксиса для питона
    let python_highlight_all = 1	

    " Запуск скрипта
    map <buffer> <leader>r :!python %<cr>

    setlocal complete+=t

    " PyLint
    compiler pylint

