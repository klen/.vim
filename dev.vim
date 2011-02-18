""" Общий конфигурационный файл для всех файлов, которые имеют какое-либо отношение к программированию.

	" Отключаем перенос строк
	setlocal nowrap
	
	" Уровень сокрытия по умолчанию для вновь открытых файлов
	setlocal foldlevelstart=1
	
	" Метод фолдинга - по отступам
	setlocal foldmethod=indent
	
	" Включаем отображение номеров строк
	setlocal number

	" Complete option
	set complete=""
	set complete+=.
	set complete+=k
	set complete+=b
	set completeopt-=preview
	set completeopt+=longest
