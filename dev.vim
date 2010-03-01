""" Общий конфигурационный файл для всех файлов, которые имеют какое-либо отношение к программированию.

	" Отключаем перенос строк
	setlocal nowrap
	
	" Уровень сокрытия по умолчанию для вновь открытых файлов
	setlocal foldlevelstart=0
	
	" Метод фолдинга - по синтаксису
	setlocal foldmethod=indent
	
	" Включаем отображение номеров строк
	setlocal number

	" Поддержка xslt тегов
	let tlist_xslt_settings = 'xslt;m:match;n:name;a:apply;c:call'

	" Complete option
	set complete=""
	set complete+=.
	set complete+=k
	set complete+=b
	set completeopt-=preview
	set completeopt+=longest

