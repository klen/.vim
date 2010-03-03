python << EOL
import vim, os, sys
sys.path.append(vim.eval('$HOME') + '/.vim/plugin')
from zen import zen

# vim.command - execute a vim command
# vim.eval - evaluate a vim expression and return the result
# vim.current.window.cursor - get the cursor position as (row, col) (row is 1-based, col is 0-based)
# vim.current.buffer - a list of the lines in the current buffer (0-based, unfortunately)

def ExpandCurrentLine(line):
    row, col = vim.current.window.cursor
    abbr = zen.expand_abbr(vim.current.line, vim.eval('&ft'), 'xml')
    return abbr
EOL

fun! Zen()
endfun

command! -narg=* Zen py ExpandCurrentLine()
imap <S-Z> <ESC>:py ExpandCurrentLine()<CR>
