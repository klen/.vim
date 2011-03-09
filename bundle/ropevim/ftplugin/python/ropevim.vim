if !exists( 'g:ropevim_loaded' )
python << EOF
import sys, os
sys.path.append(os.environ['HOME'] + '/.vim/bundle/ropevim/libs')
import ropevim
EOF
let g:ropevim_loaded = 1
endif

" RopeVim settings
"
let g:ropevim_codeassist_maxfixes=10
let g:ropevim_guess_project=1
let g:ropevim_vim_completion=1
let g:ropevim_enable_autoimport=1
let g:ropevim_autoimport_modules = ["os", "shutil"]

imap <buffer><Nul> <M-/>
imap <buffer><C-Space> <M-/>
map <C-c>rd :RopeShowDoc<CR>
