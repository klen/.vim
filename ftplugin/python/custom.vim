""" Конфигурационный файл для python files

	function! BufNewFile_PY()
		0put = '#!/usr/bin/env python'
		1put = '#-*- coding: utf-8 -*-'
		3put = ''
		4put = ''
		normal G
	endfunction

        setlocal foldlevelstart=1
        setlocal foldlevel=1

	" Набор слов для переносов
	setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

	" Поиск по документаци
	setlocal keywordprg=pydoc

        setlocal textwidth=79
        setlocal formatoptions-=t
        match Error /\%>79v.\+/

        set cindent

	" Улучшенная подсветка синтаксиса для питона
	let python_highlight_all = 1	

	" Set Python dic
	set dictionary+=~/.vim/dic/pydiction

        " Запуск скрипта
        map <buffer> <leader>r :!python %<cr>
