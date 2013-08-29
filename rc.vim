" ================================
" .vimrc klen <horneds@gmail.com>
" ================================

" Setup {{{
" ======

    if has('vim_starting')

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

        " Setup Bundler {{{
        " =================

        set rtp+=$HOME/.vim/bundle/neobundle.vim/
        call neobundle#rc($HOME . '/.vim/bundle')
        NeoBundleFetch 'Shougo/neobundle.vim'

        " Interactive command execution in Vim
        NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }

        " }}}

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
    set showcmd                 " Show commands
    set whichwrap=b,s,<,>,[,],l,h
    set completeopt=menu,preview
    set infercase
    set nojoinspaces
    set laststatus=2            " Always show a statusline

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

    " Tab completion in command line mode
    set wildmenu                " use wildmenu ...
    set wildmode=full
    set wildcharm=<TAB>
    set wildignore=*.pyc,*.pdf  " ignore file pattern

    " Edit
    set backspace=indent,eol,start " Allow backspace to remove indents, newlines and old tex"
    set virtualedit=all         " on virtualedit for all mode
    set nrformats=              " dont use octal and hex in number operations

    set confirm
    set numberwidth=1              " Keep line numbers small if it's shown

    set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

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

    let g:changelog_username = $USER
    let mapleader = ","
    let maplocalleader = " "

    " Color themes
    colo jellybeans
    let g:jellybeans_background_color_256 = 234

    " Open help in a vsplit rather than a split
    command! -nargs=? -complete=help Help :vertical help <args>
    cabbrev h h<C-\>esubstitute(getcmdline(), '^h\>', 'Help', '')<CR>

    " Some gui settings
    if has("gui_running")
        set guioptions=agimP
        set guifont=Monaco\ 11
    endif

" }}}


" Functions {{{
" ==========

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
                au VimLeavePre * exe "mks! " g:SESSION_DIR.'/last.vim'
            endif

            " Save current open file when window focus is lost
            au FocusLost * if &modifiable && &modified | write | endif

            " Filetypes {{{
            " ---------
            
                au BufNewFile,BufRead *.json setf javascript
                au BufNewFile,BufRead *.py setl colorcolumn=80

            " }}}
            
            " Auto close preview window
            autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
            autocmd InsertLeave * if pumvisible() == 0|pclose|endif


        augroup END

    endif

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

        nnoremap Y y$

        " Switch folding in current line
        noremap \ za

        " Toggle paste mode
        noremap <silent> ,p :set invpaste<CR>:set paste?<CR>

        " Not jump on star, only highlight
        nnoremap * *N

        " Drop hightlight search result
        noremap <leader><space> :set invhlsearch<CR>

        " Fast scrool
        nnoremap <C-e> 3<C-e>
        nnoremap <C-y> 3<C-y>

        " Select all
        map vA ggVG

        " QuickFix {{{
        "
            function! s:QuickfixToggle()
                for i in range(1, winnr('$'))
                    let bnum = winbufnr(i)
                    if getbufvar(bnum, '&buftype') == 'quickfix'
                        cclose
                        lclose
                        return
                    endif
                endfor
                copen
            endfunction

            command! ToggleQuickfix call <SID>QuickfixToggle()
            nnoremap <silent> <leader>ll :ToggleQuickfix <CR>
            nnoremap <silent> <leader>ln :cwindow<CR>:cn<CR>
            nnoremap <silent> <leader>lp :cwindow<CR>:cp<CR>

        " }}}

        " Window commands
        nnoremap <silent> <leader>h :wincmd h<CR>
        nnoremap <silent> <leader>j :wincmd j<CR>
        nnoremap <silent> <leader>k :wincmd k<CR>
        nnoremap <silent> <leader>l :wincmd l<CR>
        nnoremap <silent> <leader>+ :wincmd +<CR>
        nnoremap <silent> <leader>- :wincmd -<CR>
        nnoremap <silent> <leader>cj :wincmd j<CR>:close<CR>
        nnoremap <silent> <leader>ck :wincmd k<CR>:close<CR>
        nnoremap <silent> <leader>ch :wincmd h<CR>:close<CR>
        nnoremap <silent> <leader>cl :wincmd l<CR>:close<CR>
        nnoremap <silent> <leader>cw :close<CR>

        " Buffer commands
        noremap <silent> <leader>bp :bp<CR>
        noremap <silent> <leader>bn :bn<CR>
        noremap <silent> <leader>ww :w<CR>
        noremap <silent> <leader>bd :bd<CR>

        " Delete all buffers
        nnoremap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

        " Search the current file for the word under the cursor and display matches
        nnoremap <silent> <leader>gw :call rc#RGrep()<CR>

        " Open new tab
        nnoremap <silent> <C-W>t :tabnew<CR>

        " Keymap switch <C-F>
        " cnoremap <silent> <C-F> <C-^>
        inoremap <silent> <C-F> <C-^>
        nnoremap <silent> <C-F> a<C-^><Esc>
        vnoremap <silent> <C-F> <Esc>a<C-^><Esc>gv
    
        nnoremap <silent> <leader>ol :set list! list?<CR>
        nnoremap <silent> <leader>or :set wrap! wrap?<CR>
        nnoremap <silent> <leader>on :call ToggleRelativeAbsoluteNumber()<CR>
        function! ToggleRelativeAbsoluteNumber()
            if !&number && !&relativenumber
                set number
                set relativenumber
            elseif &relativenumber
                set norelativenumber
                set number
            elseif &number
                set nonumber
            endif
        endfunction

        " Close files
        nnoremap <silent> <leader>qq :q<CR>

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
        cnoremap <C-E>      <End>
        cnoremap <C-N>      <Down>
        cnoremap <C-P>      <Up>

        " Write as sudo
        command! W %!sudo tee > /dev/null %

    " }}}

" }}}


" Bundles {{{
" ===========

    " Enable extended matchit
    runtime macros/matchit.vim

    " quoting/parenthesizing made simple
    NeoBundle 'tpope/vim-surround'

    " vimscript for gist
    NeoBundle 'mattn/webapi-vim'
    NeoBundle 'mattn/gist-vim'

    " Support for SALT
    NeoBundle 'saltstack/salt-vim'

    " Disable plugins for LargeFile
    NeoBundle 'LargeFile'

    " Show reports from coverage.py
    NeoBundleLazy 'alfredodeza/coveragepy.vim', {'autoload': {'filetypes': ['python']}}

    " HTML/CSS
    NeoBundleLazy 'othree/html5.vim', {'autoload':
        \ {'filetypes': ['html', 'xhttml', 'css']}}

    NeoBundleLazy 'mattn/emmet-vim', {'autoload':
        \ {'filetypes': ['html', 'xhttml', 'css', 'xml', 'xls', 'markdown']}}

    " NERDTree {{{
    " ========

        " A tree explorer plugin for vim.
        NeoBundle 'scrooloose/nerdtree'

        let NERDTreeWinSize = 30

        " files/dirs to ignore in NERDTree (mostly the same as my svn ignores)
        let NERDTreeIgnore=['\~$', '\.AppleDouble$', '\.beam$', 'build$',
            \'dist$', '\.DS_Store$', '\.egg$', '\.egg-info$', '\.la$',
            \'\.lo$', '\.\~lock.*#$', '\.mo$', '\.o$', '\.pt.cache$',
            \'\.pyc$', '\.pyo$', '__pycache__$', '\.Python$', '\..*.rej$',
            \'\.rej$', '\.ropeproject$', '\.svn$', '\.tags$' ]

        nnoremap <silent> <leader>t :NERDTreeToggle<CR>
        nnoremap <silent> <leader>f :NERDTreeFind<CR>

    " }}}

    " NERDCommenter {{{
    " =============

        " Vim plugin for intensely orgasmic commenting
        NeoBundle 'scrooloose/nerdcommenter'

        let NERDSpaceDelims = 1
    
    " }}}

    " Fugitive {{{
    " ========

        " a Git wrapper so awesome, it should be illegal
        NeoBundle 'tpope/vim-fugitive'

        " Browse Git history
        NeoBundleLazy 'gregsexton/gitv', {'depends':['tpope/vim-fugitive'],
            \ 'autoload':{'commands':'Gitv'}}

        nnoremap <leader>gs :Gstatus<CR>
        nnoremap <leader>ga :Gwrite<CR>
        nnoremap <leader>gc :Gcommit %<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gb :Gblame<CR>
        nnoremap <leader>gr :Gremove<CR>
        nnoremap <leader>go :Gread<CR>
        nnoremap <leader>gpl :Git pull origin master<CR>
        nnoremap <leader>gpp :Git push<CR>
        nnoremap <leader>gpm :Git push origin master<CR>
        nnoremap <leader>gl :Gitv! --all<CR>
        nnoremap <leader>gL :Gitv --all<CR>

        let g:Gitv_WipeAllOnClose = 1
        let g:Gitv_DoNotMapCtrlKey = 1
    
    " }}}

    " Airline {{{
    " =======

        " lean & mean statusline for vim that's light as air
        NeoBundle 'bling/vim-airline'

        let g:airline_detect_iminsert = 1
        let g:airline_exclude_preview = 1
        let g:airline_left_sep = ''
        let g:airline_right_sep = ''
        let g:airline_theme = 'wombat'
    
    " }}}

    " TagBar {{{
    " ======

        " Vim plugin that displays tags in a window, ordered by class etc.
        NeoBundle "majutsushi/tagbar"

        let g:tagbar_width = 30
        let g:tagbar_foldlevel = 1
        let g:tagbar_type_rst = {
            \ 'ctagstype': 'rst',
            \ 'kinds': [ 'r:references', 'h:headers' ],
            \ 'sort': 0,
            \ 'sro': '..',
            \ 'kind2scope': { 'h': 'header' },
            \ 'scope2kind': { 'header': 'h' }
        \ }

        " Toggle tagbar
        nnoremap <silent> <F3> :TagbarToggle<CR>

    
    " }}}

    " XPTemplate {{{
    " ==========

        " Code snippets engine for Vim, with snippets library
        NeoBundle 'drmingdrmer/xptemplate'

        let g:xptemplate_key = '<Tab>'
        let g:xptemplate_key_pum_only = '<S-Tab>'
        let g:xptemplate_highlight = 'following'
        let g:xptemplate_vars = 'author=Kirill Klenov&email=horneds@gmail.com&SPfun=&SParg=&PYTHON_EXP_SYM= as '
        let g:xptemplate_brace_complete = 1
    
    " }}}

    " Startify {{{
    " ========

        " A fancy start screen for Vim.
	NeoBundle 'mhinz/vim-startify'

        let g:startify_session_dir = g:SESSION_DIR
        let g:startify_custom_header = [
            \ '           ______________________________________           ',
            \ '  ________|                                      |_______   ',
            \ '  \       |         VIM ' . v:version . ' - www.vim.org        |      /   ',
            \ '   \      |                                      |     /    ',
            \ '   /      |______________________________________|     \    ',
            \ '  /__________)                                (_________\   ',
            \ '']
    " }}}

    " Python-mode {{{
    " ===========

        NeoBundle "python-mode"

        let g:pymode_lint_hold = 0
        let g:pymode_syntax_builtin_objs = 0
        let g:pymode_syntax_builtin_funcs = 0
        let g:pymode_rope_goto_def_newwin = "new"
        let g:pymode_syntax_builtin_funcs = 1
        let g:pymode_syntax_print_as_function = 1
        let g:pymode_lint_mccabe_complexity = 10
        let g:pymode_lint_checker = "pylint,pep8,pyflakes,mccabe,pep257"
    
    " }}}

    " WIKI {{{
    " ====

        NeoBundle "vimwiki/vimwiki", "dev"
        
        let g:vimwiki_folding = 1
        let g:vimwiki_fold_lists = 1
        let g:vimwiki_list = [{"path" : "~/Dropbox/wiki"}, {"path" : "~/Dropbox/wiki/english"}]

        nmap <Leader>wv <Plug>VimwikiIndex

    " }}}

    " Fakeclip {{{
    " ========

        NeoBundle "unphased/vim-fakeclip"
    
    " }}}

    " JSMode {{{
    " ========

        NeoBundle "klen/vim-jsmode"
    
    " }}}

    " Unite {{{
    " =====

        NeoBundle "Shougo/unite.vim"

        NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}

        NeoBundleLazy 'Shougo/unite-session', {'autoload':{'unite_sources':'session', 'commands': ['UniteSessionSave', 'UniteSessionLoad']}}

        NeoBundleLazy 'osyo-manga/unite-quickfix', {'autoload':{'unite_sources': ['quickfix', 'location_list']}}

        NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : { 'unite_sources' : ['history/command', 'history/search']}}

        NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources': 'colorscheme'}}

        NeoBundleLazy 'tsukkee/unite-help', {'autoload':{'unite_sources':'help'}}

        NeoBundleLazy 'klen/unite-radio.vim', {'autoload':{'unite_sources':'radio'}}

        source $HOME/.vim/unite.vim

  
    " }}}

    " GUndo {{{
    " =====

        " browse the vim undo tree
        NeoBundleLazy 'sjl/gundo.vim', { 'autoload' : {'commands': 'GundoToggle'}}

        nnoremap <leader>uu :GundoToggle<CR>
    
    " }}}

    " VimSpec {{{
    " =======

        " Testing framework for Vim script
        NeoBundle 'kana/vim-vspec'
    
    " }}}


" }}}


" Local settings
" ================
if filereadable($HOME . "/.vim_local")
    source $HOME/.vim_local
endif


" Install bundles
" ================
NeoBundleCheck


" Project settings
" ================

" enables the reading of .vimrc, .exrc and .gvimrc in the current directory.
set exrc

" must be written at the last.  see :help 'secure'.
set secure
