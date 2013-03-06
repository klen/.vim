" ================================
" .vimrc klen <horneds@gmail.com>
" ================================

" Setup {{{
" ======

    if !exists('s:loaded_my_vimrc')                " don't reset twice on reloading

        set nocompatible                           " enable vim features

        set backupdir=$HOME/.cache/vim/backup      " where to put backup file 
        set backup                                 " make backup file and leave it around 
        set backupskip+=svn-commit.tmp,svn-commit.[0-9]*.tmp

        set directory=/tmp                         " where to put swap file
        let g:SESSION_DIR   = $HOME.'/.cache/vim/sessions'

        " Create system vim dirs
        if finddir(&backupdir) == ''
            silent call mkdir(&backupdir, "p")
        endif

        if finddir(g:SESSION_DIR) == ''
            silent call mkdir(g:SESSION_DIR, "p")
        endif

        " Pathogen load
        filetype off

        call pathogen#infect()
        call pathogen#helptags()

        filetype plugin indent on
        syntax on

    endif

" }}}
    

" Options {{{
" =======

    " Buffer options
    set hidden                  " hide buffers when they are abandoned
    set autoread                " auto reload changed files
    set autowrite               " automatically save before commands like :next and :make

    " Display options
    set title                   " show file name in window title
    set visualbell              " mute error bell
    set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:$,nbsp:~
    set linebreak               " break lines by words
    set winminheight=0          " minimal window height
    set winminwidth=0           " minimal window width
    set scrolloff=4             " min 4 symbols bellow cursor
    set sidescroll=4
    set sidescrolloff=10
    set showcmd
    set whichwrap=b,s,<,>,[,],l,h
    set completeopt=menu,preview
    set infercase
    set cmdheight=2

    " Tab options
    set autoindent              " copy indent from previous line
    set smartindent             " enable nice indent
    set expandtab               " tab with spaces
    set smarttab                " indent using shiftwidth"
    set shiftwidth=4            " number of spaces to use for each step of indent
    set softtabstop=4           " tab like 4 spaces
    set shiftround              " drop unused spaces

    " Backup and swap files
    set history=400             " history length
    set viminfo+=h              " save history
    set ssop-=blank             " dont save blank vindow
    set ssop-=options           " dont save options

    " Search options
    set hlsearch                " Highlight search results
    set ignorecase              " Ignore case in search patterns
    set smartcase               " Override the 'ignorecase' option if the search pattern contains upper case characters
    set incsearch               " While typing a search command, show where the pattern

    " Matching characters
    set showmatch               " Show matching brackets
    set matchpairs+=<:>         " Make < and > match as well

    " Localization
    set langmenu=none            " Always use english menu
    set keymap=russian-jcukenwin " Alternative keymap
    set iminsert=0               " English by default
    set imsearch=-1              " Search keymap from insert mode
    set spelllang=en,ru          " Languages
    set encoding=utf-8           " Default encoding
    set fileencodings=utf-8,cp1251,koi8-r,cp866
    set termencoding=utf-8

    " Wildmenu
    set wildmenu                " use wildmenu ...
    set wildcharm=<TAB>
    set wildignore=*.pyc        " ignore file pattern

    " Undo
    if has('persistent_undo')
        set undofile            " enable persistent undo
        set undodir=/tmp/       " store undofiles in a tmp dir
    endif

    " Folding
    if has('folding')
        set foldmethod=marker   " Fold on marker
        set foldlevel=999       " High default so folds are shown to start
    endif

    " X-clipboard support
    if has('unnamedplus')
        set clipboard+=unnamed     " enable x-clipboard
    endif

    " Term
    if &term =~ "xterm"
        set t_Co=256            " set 256 colors
    endif

    " Color theme
    let g:solarized_termcolors=256
    let g:solarized_contrast = "high"
    let g:solarized_termtrans = 1

    colo wombat256
    " colo solarized

    " Edit
    set backspace=indent,eol,start " Allow backspace to remove indents, newlines and old tex"
    set virtualedit=all         " on virtualedit for all mode

    set confirm
    set numberwidth=1              " Keep line numbers small if it's shown

    " Open help in a vsplit rather than a split
    command! -nargs=? -complete=help Help :vertical help <args>
    cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>
                                            
    set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" }}}


" Functions {{{
" ==========

    " Key bind helper
    fun! rc#Map_ex_cmd(key, cmd) "{{{ 
      execute "nmap ".a:key." " . ":".a:cmd."<CR>"
      execute "cmap ".a:key." " . "<C-C>:".a:cmd."<CR>"
      execute "imap ".a:key." " . "<C-O>:".a:cmd."<CR>"
      execute "vmap ".a:key." " . "<Esc>:".a:cmd."<CR>gv"
    endfun "}}} 

    " Option switcher helper
    fun! rc#Toggle_option(key, opt) "{{{ 
      call rc#Map_ex_cmd(a:key, "set ".a:opt."! ".a:opt."?")
    endfun "}}} 

    " Sessions
    fun! rc#SessionRead(name) "{{{ 
        let s:name = g:SESSION_DIR.'/'.a:name.'.session'
        if getfsize(s:name) >= 0
            echo "Reading " s:name
            exe 'source '.s:name
            exe 'silent! source '.getcwd().'/.vim/.vimrc'
        else
            echo 'Not find session: '.a:name
        endif
    endfun "}}} 

    fun! rc#SessionInput(type) "{{{ 
        let s:name = input(a:type.' session name? ')
        if a:type == 'Save'
            call rc#SessionSave(s:name)
        else
            call rc#SessionRead(s:name)
        endif
    endfun "}}} 

    fun! rc#SessionSave(name) "{{{ 
        exe "mks! " g:SESSION_DIR.'/'.a:name.'.session'
        echo "Session" a:name "saved"
    endfun "}}} 

    " Omni and dict completition
    fun! rc#AddWrapper() "{{{ 
        if exists('&omnifunc') && &omnifunc != ''
            return "\<C-X>\<C-o>\<C-p>"
        else
            return "\<C-N>"
        endif
    endfun "}}} 

    " Recursive vimgrep
    fun! rc#RGrep() "{{{ 
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif

        let cwd = getcwd()
        let startdir = input("Start searching from directory: ", cwd, "dir")
        if startdir == ""
            return
        endif

        let filepattern = input("Search in files matching pattern: ", "*.*") 
        if filepattern == ""
            return
        endif

        try
            execute 'noautocmd vimgrep /'.pattern.'/gj '.startdir.'/**/'.filepattern
            botright copen
        catch /.*/
            echohl WarningMsg | echo "Not found: ".pattern | echohl None
        endtry
    endfun "}}} 

    " Restore cursor position
    fun! rc#restore_cursor() "{{{
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction "}}}

    " Templates
    fun! rc#load_template() "{{{
        let dir_tpl = $HOME . "/.vim/templates/"

        if exists("g:tpl_prefix")
            let dir_tpl = l:dir_tpl . g:tpl_prefix . "/"
        endif

        let template = ''

        let path = expand('%:p:~:gs?\\?/?')
        let path = strpart(l:path, len(fnamemodify(l:path, ':h:h:h')), len(l:path))
        let parts = split(l:path, '/')

        while len(l:parts) && !filereadable(l:template)
            let template = l:dir_tpl . join(l:parts, '/')
            let l:parts = l:parts[1:]
        endwhile

        if !filereadable(l:template)
            let l:template = l:dir_tpl . &ft
        endif

        if filereadable(l:template)
            exe "0r " . l:template
        endif
    endfunction "}}}

" }}}


" Autocommands {{{
" =============

    if has("autocmd")

        augroup vimrc
        au!

            " Auto reload vim settins
            au! BufWritePost *.vim source ~/.vimrc

            " Highlight insert mode
            au InsertEnter * set cursorline
            au InsertLeave * set nocursorline
            
            " New file templates
            au BufNewFile * silent! call rc#load_template()

            " Restore cursor position
            au BufWinEnter * call rc#restore_cursor()

            " Autosave last session
            if has('mksession') 
                au VimLeavePre * :call rc#SessionSave('last')
            endif

            " Save current open file when window focus is lost
            au FocusLost * if &modifiable && &modified | write | endif

            " Filetypes {{{
            " ---------
            
                au BufNewFile,BufRead *.json setf javascript

            " }}}
            
            " Auto close preview window
            autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
            autocmd InsertLeave * if pumvisible() == 0|pclose|endif


        augroup END

    endif

" }}}


" Plugins setup {{{
" ==============

    let g:changelog_username = $USER

    let mapleader = ","         " set custom map leader to ','

    " Tagbar
    let g:tagbar_width = 30
    let g:tagbar_foldlevel = 1
    let g:tagbar_type_rst = {
        \ 'ctagstype': 'rst',
        \ 'kinds': [
            \ 'r:references',
            \ 'h:headers'
        \ ],
        \ 'sort': 0,
        \ 'sro': '..',
        \ 'kind2scope': { 'h': 'header' },
        \ 'scope2kind': { 'header': 'h' }
    \ }

    " XPTemplates
    let g:xptemplate_key = '<Tab>'
    let g:xptemplate_key_pum_only = '<S-Tab>'
    let g:xptemplate_highlight = 'following'
    let g:xptemplate_vars = 'author=Kirill Klenov&email=horneds@gmail.com&SPfun=&SParg='
    let g:xptemplate_brace_complete = 1

    " NERDCommenter
    let NERDSpaceDelims = 1

    " NERDTree
    let NERDTreeWinSize = 30
    " files/dirs to ignore in NERDTree (mostly the same as my svn ignores)
    let NERDTreeIgnore=[
        \'\~$',
        \'\.AppleDouble$',
        \'\.beam$',
        \'build$',
        \'dist$',
        \'\.DS_Store$',
        \'\.egg$',
        \'\.egg-info$',
        \'\.la$',
        \'\.lo$',
        \'\.\~lock.*#$',
        \'\.mo$',
        \'\.o$',
        \'\.pt.cache$',
        \'\.pyc$',
        \'\.pyo$',
        \'__pycache__$',
        \'\.Python$',
        \'\..*.rej$',
        \'\.rej$',
        \'\.ropeproject$',
        \'\.svn$',
        \'\.tags$'
    \]

    " Enable extended matchit
    runtime macros/matchit.vim

    " Vimerl
    let g:erlangCompleteFile  = $HOME."/.vim/bundle/vimerl.git/autoload/erlang_complete.erl"
    let g:erlangCheckFile     = $HOME."/.vim/bundle/vimerl.git/compiler/erlang_check.erl"
    let g:erlangHighlightBIFs = 1
    let g:erlangCompletionGrep="zgrep"
    let g:erlangManSuffix="erl\.gz"

    " Pymode
    let g:pymode_lint_hold = 0
    let g:pymode_syntax_builtin_objs = 0
    let g:pymode_syntax_builtin_funcs = 0
    let g:pymode_rope_goto_def_newwin = "new"
    let g:pymode_syntax_builtin_funcs = 1
    let g:pymode_syntax_print_as_function = 1

    " Fugitive
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>ga :Gwrite<CR>
    nnoremap <leader>gc :Gcommit %<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>gl :Glog<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gr :Gremove<CR>
    nnoremap <leader>go :Gread<CR>
    nnoremap <leader>gpl :Git pull origin master<CR>
    nnoremap <leader>gpp :Git push<CR>
    nnoremap <leader>gpm :Git push origin master<CR>

    " VimWiki
    let g:vimwiki_folding = 1
    let g:vimwiki_fold_lists = 1
    let g:vimwiki_list = [
        \ {"path" : "~/Dropbox/wiki"},
        \ {"path" : "~/Dropbox/wiki/english"}
    \ ]
    nmap <Leader>wv <Plug>VimwikiIndex

" }}}


" Hot keys {{{
" ==========

    " Insert mode {{{
    " ------------

        " Omni and dict completition on space
        inoremap <Nul> <C-R>=rc#AddWrapper()<CR>
        inoremap <C-Space> <C-R>=rc#AddWrapper()<CR>

        " emacs style jump to end of line
        inoremap <C-E> <C-o>A
        inoremap <C-A> <C-o>I

    " }}}
    
    " Normal mode {{{
    " ------------

        " Nice scrolling if line wrap
        noremap j gj
        noremap k gk

        " Toggle paste mode
        noremap <silent> ,p :set invpaste<CR>:set paste?<CR>

        " Not jump on star, only highlight
        nnoremap * *N

        " Split line in current cursor position
        noremap <S-O>       i<CR><ESC>

        " Drop hightlight search result
        noremap <leader><space> :nohls<CR>

        " Unfold
        noremap <space> za

        " Fast scrool
        nnoremap <C-e> 3<C-e>
        nnoremap <C-y> 3<C-y>

        " Select all
        map vA ggVG

        " Close cwindow
        nnoremap <silent> ,ll :ccl<CR>

        " Quickfix fast navigation
        nnoremap <silent> ,nn :cwindow<CR>:cn<CR>
        nnoremap <silent> ,pp :cwindow<CR>:cp<CR>

        " Window commands
        nnoremap <silent> ,h :wincmd h<CR>
        nnoremap <silent> ,j :wincmd j<CR>
        nnoremap <silent> ,k :wincmd k<CR>
        nnoremap <silent> ,l :wincmd l<CR>
        nnoremap <silent> ,+ :wincmd +<CR>
        nnoremap <silent> ,- :wincmd -<CR>
        nnoremap <silent> ,cj :wincmd j<CR>:close<CR>
        nnoremap <silent> ,ck :wincmd k<CR>:close<CR>
        nnoremap <silent> ,ch :wincmd h<CR>:close<CR>
        nnoremap <silent> ,cl :wincmd l<CR>:close<CR>
        nnoremap <silent> ,cw :close<CR>

        " Buffer commands
        noremap <silent> ,bp :bp<CR>
        noremap <silent> ,bn :bn<CR>
        noremap <silent> ,ww :w<CR>
        noremap <silent> ,bd :bd<CR>
        noremap <silent> ,ls :Bufferlist<CR>

        " Delete all buffers
        nnoremap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

        " Search the current file for the word under the cursor and display matches
        nnoremap <silent> ,gw :call rc#RGrep()<CR>

        " Open new tab
        call rc#Map_ex_cmd("<C-W>t", ":tabnew")

        " Tab navigation
        map <A-1> 1gt
        map <A-2> 2gt
        map <A-3> 3gt
        map <A-4> 4gt
        map <A-5> 5gt
        map <A-6> 6gt
        map <A-7> 7gt
        map <A-8> 8gt
        map <A-9> 9gt

        " первая вкладка
        call rc#Map_ex_cmd("<A-UP>", ":tabfirst")
        " последняя вкладка
        call rc#Map_ex_cmd("<A-DOWN>", ":tablast")
        " переместить вкладку в начало
        nmap Q :tabmove 0<cr>
        " переместить вкладку в конец
        call rc#Map_ex_cmd("<C-DOWN>", ":tabmove")

        " Keymap switch <C-F>
        cnoremap <silent> <C-F> <C-^>
        inoremap <silent> <C-F> <C-^>
        nnoremap <silent> <C-F> a<C-^><Esc>
        vnoremap <silent> <C-F> <Esc>a<C-^><Esc>gv
    
        " NERDTree keys
        call rc#Map_ex_cmd("<leader>t", "NERDTreeToggle")
        nnoremap <silent> <leader>f :NERDTreeFind<CR>
        
        " Toggle tagbar
        call rc#Map_ex_cmd("<F3>", "TagbarToggle")

        call rc#Toggle_option("<leader>ol", "list")      " Переключение подсветки невидимых символов
        call rc#Toggle_option("<leader>or", "wrap")      " Переключение переноса слов

        " Close files
        call rc#Map_ex_cmd("<leader>qq", "qa")

        " Session UI
        nnoremap <Leader>ss :call rc#SessionInput('Save')<CR>
        nnoremap <Leader>sr :call rc#SessionInput('Read')<CR>
        nnoremap <Leader>sl :call rc#SessionRead('last')<CR>

        " Show syntax highlighting groups for word under cursor
        nmap <C-S-P> :call <SID>SynStack()<CR>
        function! <SID>SynStack()
            if !exists("*synstack")
                return
            endif
            echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
        endfunc
  
    " }}}

    " Command mode {{{
    " ------------

        " Allow command line editing like emacs
        cnoremap <C-A>      <Home>
        cnoremap <C-B>      <Left>
        cnoremap <C-E>      <End>
        cnoremap <C-F>      <Right>
        cnoremap <C-N>      <Down>
        cnoremap <C-P>      <Up>

    " }}}

    " Visual mode {{{
    " ------------

    " }}}

" }}}


" GUI settings {{{
" ============

    " Some gui settings
    if has("gui_running")
        set guioptions=agimP
        set guifont=Monaco\ 11
    endif

" }}}


" Local settings
" ================
if filereadable($HOME . "/.vim_local")
    source $HOME/.vim_local
endif


" Project settings
" ================

    " enables the reading of .vimrc, .exrc and .gvimrc in the current directory.
    set exrc

    " must be written at the last.  see :help 'secure'.
    set secure  
