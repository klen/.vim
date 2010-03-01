""" Конфигурационный файл для python files

    setlocal foldlevelstart=1
    setlocal foldlevel=1
    setlocal foldmethod=syntax

    " Набор слов для переносов
    setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
    set cindent

    set tags+=$HOME/.vim/tags/python.ctags

    " Поиск по документаци
    setlocal keywordprg=pydoc

    setlocal textwidth=79
    setlocal formatoptions-=t
    match Error /\%>79v.\+/

    "Trim trailing whitespace
    au FileType python autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

    " Улучшенная подсветка синтаксиса для питона
    let python_highlight_all = 1	

    " Set Python dic
    set dictionary+=~/.vim/dic/pydiction

    " Запуск скрипта
    map <buffer> <leader>r :!python %<cr>
    map <buffer> <leader>i :!ipython<cr>

    setlocal complete+=t

    "let g:syntastic_quiet_warnings=1

