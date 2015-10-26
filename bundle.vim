let s:darwin = has('mac')

" Utils {{{
" =========

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

    NeoBundle 'mattn/webapi-vim'

    " a Git wrapper so awesome, it should be illegal
    NeoBundle 'tpope/vim-fugitive'
    cabbrev git Git

    " Browse Git history
    NeoBundle 'gregsexton/gitv', {
        \ 'lazy': 1,
        \ 'depends': ['tpope/vim-fugitive'],
        \ 'autoload': {'commands': 'Gitv'}}

    nnoremap <leader>gL :Gitv --all<CR>
    nnoremap <leader>ga :Gadd<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gc :Gcommit %<CR>
    nnoremap <leader>gd :Gvdiff<CR>
    nnoremap <leader>gl :Gitv! --all<CR>
    nnoremap <leader>go :Gread<CR>
    nnoremap <leader>gpl :Git pull origin master<CR>
    nnoremap <leader>gpm :Git push origin master<CR>
    nnoremap <leader>gpp :Git push<CR>
    nnoremap <leader>gr :Gremove<CR>
    nnoremap <leader>gs :Gstatus<CR>

    let g:Gitv_WipeAllOnClose = 1
    let g:Gitv_DoNotMapCtrlKey = 1

    " vimscript for gist
    NeoBundle 'mattn/gist-vim', {
        \ 'lazy': 1,
        \ 'autoload': {'commands': 'Gist'}}

    NeoBundle 'junegunn/vim-github-dashboard', {
        \ 'lazy': 1,
        \ 'autoload': {'commands': ['GHDashboard', 'GHActivity']}}

" }}}


" Configuration {{{
" =================

    " Disable plugins for LargeFile
    NeoBundle 'LargeFile'

    " Fetch clipboard
    NeoBundle "unphased/vim-fakeclip"

    " browse the vim undo tree
    NeoBundle 'mbbill/undotree', { 
        \ 'lazy': 1,
        \ 'autoload' : {'commands': 'UndotreeToggle'}}
    let g:undotree_WindowLayout = 3
    nnoremap <leader>uu :UndotreeToggle<CR>

" }}}


" Browse {{{
" ==========

    " A tree explorer plugin for vim.
    NeoBundle 'scrooloose/nerdtree', { 
        \ 'lazy': 1,
        \ 'autoload' : {'commands': ['NERDTreeToggle', 'NERDTreeFind']}} 

    let NERDTreeWinSize = 30

    " files/dirs to ignore in NERDTree (mostly the same as my svn ignores)
    let NERDTreeIgnore=['\~$', '\.AppleDouble$', '\.beam$', 'build$',
    \'dist$', '\.DS_Store$', '\.egg$', '\.egg-info$', '\.la$',
    \'\.lo$', '\.\~lock.*#$', '\.mo$', '\.o$', '\.pt.cache$',
    \'\.pyc$', '\.pyo$', '__pycache__$', '\.Python$', '\..*.rej$',
    \'\.rej$', '\.ropeproject$', '\.svn$', '\.tags$' ]

    nnoremap <silent> <leader>dd :NERDTreeToggle<CR>
    nnoremap <silent> <leader>f :NERDTreeFind<CR>

    " Find files
    NeoBundle 'kien/ctrlp.vim'

    let g:ctrlp_dont_split = 'NERD_tree_2'
    let g:ctrlp_map = '<leader>,'

    " Vim plugin that displays tags in a window, ordered by class etc.
    NeoBundle "majutsushi/tagbar", {
        \ 'lazy': 1,
        \ 'autoload' : {'commands': 'TagbarToggle'}} 

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

    " if s:darwin
        " NeoBundle "rizzatti/dash.vim", {
            " \ 'lazy': 1,
            " \ 'autoload' : {'commands': ['Dash', 'DashKeywords']}} 
        " nnoremap <silent> <leader>dd :Dash<CR>
    " endif

" }}}


" Status line {{{
" ===============

    " lean & mean statusline for vim that's light as air
    NeoBundle 'bling/vim-airline'

    let g:airline_detect_iminsert = 1
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_theme = 'wombat'

" }}}


" Motion and operators {{{
" ========================

    " Simple selection
    NeoBundle "gcmt/wildfire.vim"
    let g:wildfire_fuel_map = "="
    let g:wildfire_water_map = "-"

    " Quoting/parenthesizing made simple
    NeoBundle 'tpope/vim-repeat'
    NeoBundle 'tpope/vim-surround', {
        \ 'depends': ['tpope/vim-repeat']}

    " Exchange objects
    NeoBundle "tommcdo/vim-exchange"

    " NeoBundle "tpope/vim-rsi"

" }}}   


" Languages {{{
" =============

    NeoBundle 'othree/html5.vim', {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['html', 'xhtml', 'css']}}

    NeoBundle 'mattn/emmet-vim', {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['html', 'xhtml', 'css', 'xml', 'xls', 'markdown']}}
    autocmd BufNewFile,BufRead *.md setf markdown

    NeoBundle 'groenewege/vim-less', {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['less']}}
    autocmd BufNewFile,BufRead *.less setf less

    NeoBundle "kchmck/vim-coffee-script", {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['coffee']}}

    NeoBundle "python-mode", {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['python']}}
    let g:pymode_breakpoint_bind = '<leader>bb'
    let g:pymode_completion_provider = 'jedi'
    let g:pymode_lint_checkers = ['pylint', 'pep8', 'pep257', 'pyflakes', 'mccabe']
    let g:pymode_lint_ignore = 'C0111'
    let g:pymode_lint_sort = ['E', 'C', 'W', 'R', 'I', 'F', 'D']
    let g:pymode_lint_unmodified = 1
    let g:pymode_options_max_line_length = 99
    let g:pymode_rope_lookup_project = 0
    let g:pymode_syntax_highlight_equal_operator = 0
    " let g:pymode_debug = 1
    " let g:pymode_python = 'python3'

    NeoBundle "fatih/vim-go", {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['go']}}
    au BufNewFile,BufRead *.go set ft=go nu
    au FileType go nnoremap <buffer><leader>r :GoRun<CR>
    au FileType go nnoremap <buffer><C-c>d :GoDef<CR>
    au FileType go setlocal tabstop=4
    au FileType go setlocal softtabstop=4
    let g:go_disable_autoinstall = 1

    NeoBundle "chase/vim-ansible-yaml", {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['yaml', 'ansible']}}

    NeoBundle "mitsuhiko/vim-jinja", {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['jinja']}}
    au BufNewFile,BufRead *.j2 set ft=jinja
    let g:htmljinja_disable_html_upgrade = 1


    NeoBundle "wavded/vim-stylus", {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['styl']}}
    au BufNewFile,BufRead *.styl set ft=stylus nu

    NeoBundle "pangloss/vim-javascript", {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['javascript']}}
    au BufNewFile,BufRead *.js setf javascript
    au BufNewFile,BufRead *.jsm setf javascript
    au BufNewFile,BufRead Jakefile setf javascript

    NeoBundle "digitaltoad/vim-jade", {
        \ 'lazy': 1,
        \ 'autoload': {'filetypes': ['jade']}}
    au BufNewFile,BufRead *.jade setf jade
    au BufNewFile,BufRead *.jade set sw=2 ts=2 sts=2

    NeoBundle "sudar/vim-arduino-syntax"
    " NeoBundle "klen/vim-jsmode"
    " NeoBundle 'saltstack/salt-vim'

" }}}


" Templates {{{
" =============

    " Code snippets engine for Vim, with snippets library
    NeoBundle 'drmingdrmer/xptemplate'

    let g:xptemplate_key = '<Tab>'
    let g:xptemplate_key_pum_only = '<S-Tab>'
    " let g:xptemplate_highlight = 'following'
    let g:xptemplate_vars = 'author=Kirill Klenov&email=horneds@gmail.com&SPfun=&SParg=&PYTHON_EXP_SYM= as '
    let g:xptemplate_brace_complete = 1

" }}}


" Syntax checkers {{{
" ===================

    NeoBundle 'scrooloose/syntastic'

    " Disable syntastic for python (managed by python-mode)
    let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': [],
        \ 'passive_filetypes': ['python'] }

" }}}


" Show reports from coverage.py
" NeoBundleLazy 'alfredodeza/coveragepy.vim', {'autoload': {'filetypes': ['python']}}


" NERDCommenter {{{
" =============

    " Vim plugin for intensely orgasmic commenting
    NeoBundle 'scrooloose/nerdcommenter'
    let NERDSpaceDelims = 1
    let g:NERDCustomDelimiters = { 'ansible': { 'left': '#'} }

" }}}

" Startify {{{
" ========

    " A fancy start screen for Vim.
    NeoBundle 'mhinz/vim-startify'

    let g:startify_session_dir = g:SESSION_DIR
    let g:startify_change_to_vcs_root = 1
    let g:startify_list_order = [
        \ ['   Last recently opened files:'],
        \ 'files',
        \ ['   My sessions:'],
        \ 'sessions',
    \ ]
    " let g:startify_change_to_dir = 0
    let g:startify_custom_header = [
        \ '           ______________________________________           ',
        \ '  ________|                                      |_______   ',
        \ '  \       |         VIM ' . v:version . ' - www.vim.org        |      /   ',
        \ '   \      |                                      |     /    ',
        \ '   /      |______________________________________|     \    ',
        \ '  /__________)                                (_________\   ',
        \ '']
" }}}

" WIKI {{{
" ====

    NeoBundle "vimwiki/vimwiki", 'dev'
    let g:vimwiki_folding = 1
    let g:vimwiki_fold_lists = 1
    let g:vimwiki_list = [{"path" : "~/Dropbox/wiki"}, {"path" : "~/Dropbox/wiki/english"}]
    nmap <Leader>wv <Plug>VimwikiIndex

" }}}

" NeoBundle 'dahu/LearnVim'

" NeoBundle 'tpope/vim-characterize'
NeoBundle 'janko-m/vim-test'
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tt :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>


" git-slides {{{
" ==========

    " NeoBundle 'gelisam/git-slides'

" }}}


" Unite {{{
" =====

    " source $HOME/.vim/unite.vim

" }}}


" Install bundles
" ================
NeoBundleCheck
