XPTemplate priority=personal

XPTinclude
      \ rst/snippets
      \ python/python

XPT class " class .. : def __init__ ...
XSET a=arg*
XSET a|post=Build( V() == 'arg*' ? '' : VS() . AutoCmpl( 1, 'self' ) . '`:_args2:^' )
class `ClassName^`$SPfun^(`$SParg`object`$SParg^):

    """ `Class description^. """

    def __init__(`a^python_sp_arg()^``a^`a^AutoCmpl(0,'self')^`a^python_sp_arg()^):
        `pass^

XPT def " def ..( .. ): ...
XSET a=arg*
XSET a|post=Build( V() == 'arg*' ? '' : VS() . AutoCmpl( 1, 'self' ) . '`:_args2:^' )
def `name^`$SPfun^(`a^python_sp_arg()^``a^`a^AutoCmpl(0,'self')^`a^python_sp_arg()^):
    """ `Function description^. """

    `cursor^
