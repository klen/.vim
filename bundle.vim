" Bundles
" =======

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

    nnoremap <leader>gL :Gitv --all<CR>
    nnoremap <leader>ga :Gadd<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gc :Gcommit %<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>gl :Gitv! --all<CR>
    nnoremap <leader>go :Gread<CR>
    nnoremap <leader>gpl :Git pull origin master<CR>
    nnoremap <leader>gpm :Git push origin master<CR>
    nnoremap <leader>gpp :Git push<CR>
    nnoremap <leader>gr :Gremove<CR>
    nnoremap <leader>gs :Gstatus<CR>

    let g:Gitv_WipeAllOnClose = 1
    let g:Gitv_DoNotMapCtrlKey = 1

" }}}

" Airline {{{
" =======

    " lean & mean statusline for vim that's light as air
    NeoBundle 'bling/vim-airline'

    let g:airline_detect_iminsert = 1
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

" Python-mode {{{
" ===========

    NeoBundle "python-mode"

    let g:pymode_breakpoint_bind = '<leader>bb'
    let g:pymode_syntax_highlight_equal_operator = 0
    let g:pymode_lint_checkers = ['pylint', 'pep8', 'pep257', 'pyflakes', 'mccabe']
    let g:pymode_lint_ignore = 'C0111'
    let g:pymode_lint_unmodified = 1
    " let g:pymode_debug = 1
    let g:pymode_rope_lookup_project = 0
    let g:pymode_completion_provider = 'jedi'

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

NeoBundle 'dahu/LearnVim'
NeoBundle 'kien/ctrlp.vim'

let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
let g:ctrlp_extensions = ['tag']

let g:ctrlp_map = '<leader>,'
nnoremap <leader>. :CtrlPTag<cr>

let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<s-tab>'],
\ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
\ 'PrtHistory(-1)':       ['<c-n>'],
\ 'PrtHistory(1)':        ['<c-p>'],
\ 'ToggleFocus()':        ['<c-tab>'],
\ }

let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ "deploy/|lib/|classes/|libs/|deploy/vendor/|.git/|.hg/|.svn/|.*migrations/|docs/build/" .
    \ ")'"

let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
    \ ctrlp_filter_greps

let my_ctrlp_git_command = "" .
    \ "cd %s && git ls-files --exclude-standard -co | " .
    \ ctrlp_filter_greps

" git-slides {{{
" ==========

    " Testing framework for Vim script
    " NeoBundle 'gelisam/git-slides'

" }}}

NeoBundle "gcmt/wildfire.vim"

NeoBundle "tommcdo/vim-exchange"


" Install bundles
" ================
NeoBundleCheck
