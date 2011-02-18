""" Python config file

    if exists("b:did_ftfile") | finish | endif
    let b:did_ftfile = 1

    setlocal foldlevel=1
    setlocal foldmethod=syntax
    setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
    setlocal cindent
    setlocal textwidth=79
    setlocal formatoptions-=t
    setlocal complete+=t

    " Trim trailing whitespace
    au BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
    " Match long line
    " au BufWinEnter *.py let w:m1=matchadd('Search', '\%<111v.\%>107v', -1)
    " au BufWinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>110v.\+', -1)

    " Best syntax highlight
    let python_highlight_all = 1	

    " Run python script
    map <buffer> <leader>r :!python %<cr>

    " PyLint
    compiler pylint

    " Debug shortcut
python << EOF
import vim

def breakpoint():
    n_line = cur_n_line = int( vim.eval( 'line(".")'))
    indent = ""

    while cur_n_line and indent == "":
        line = vim.current.buffer[cur_n_line-1]
        rest = line.lstrip()
        if rest:
            indent = line[:-len(rest)]
        cur_n_line -= 1

    if vim.current.line.lstrip().startswith( 'import ipdb' ):
        vim.command( 'normal dd')
    else:
        vim.current.buffer.append(
            "%simport ipdb; ipdb.set_trace() ### XXX Breakpoint ###" % indent, n_line - 1)
            
vim.command( 'map <f8> :py breakpoint()<cr>')
EOF
