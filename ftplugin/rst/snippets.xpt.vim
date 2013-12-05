XPTemplate priority=personal mark=~^

XPTinclude
        \ rst/rst

XPTvar $DATE_FMT     '%Y-%m-%d'

XPT bold wrap=text " **..**
**~text^**

XPT quote wrap=text " ``..``
``~text^``

XPT term wrap=TERM " :term:`...`
:term:`~term^~<...^`~cursor^
XSETm <...|post
 <~term2^>
XSETm END

XPT ref " :ref:`...`
:ref:`~ref^`

XPT image " :image:...
.. image:: ~source^

XPT param " :param:...
:param ~param^:

XPT return " :return...
:returns: ~return^

XPT type " :type:...
:type ~type^:

XPT rtype " :rtype:...
:rtype: ~return^

XPT include " .. include
.. include:: ~include^
