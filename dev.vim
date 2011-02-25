""" Общий конфигурационный файл для всех файлов, которые имеют какое-либо отношение к программированию.

	setlocal nowrap
	setlocal number
	setlocal foldlevelstart=99
	setlocal foldlevel=99
	setlocal foldmethod=indent

	" Complete option
	setlocal complete=""
	setlocal complete+=.
	setlocal complete+=k
	setlocal complete+=b
	setlocal completeopt-=preview
	setlocal completeopt+=longest
        setlocal tabstop=4
        setlocal softtabstop=4
