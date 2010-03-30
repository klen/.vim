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
    map <buffer> <leader>i :!ipython<cr>

    setlocal complete+=t

    " PyLint
    compiler pylint


    " RopeVim
    let ropevim_codeassist_maxfixes=10
    let ropevim_guess_project=1
    let ropevim_vim_completion=1
    let ropevim_enable_autoimport=1
    let ropevim_enable_shortcuts=1
    let ropevim_extended_complete=0 
    let ropevim_global_prefix="<C-c>p"

    imap <buffer><Nul> <M-/>
    imap <buffer><C-Space> <M-/>
    map <buffer><C-c>r :call RopeRename()<CR>
    map <buffer><C-c>u :call RopeUndo()<CR>
    map <buffer><C-c>c :call RopeProjectConfig()<CR>
