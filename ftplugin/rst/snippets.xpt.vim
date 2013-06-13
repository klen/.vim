XPTemplate priority=personal mark=~^

XPTinclude _common/common

XPTvar $DATE_FMT     '%Y-%m-%d'

XPT term wrap=TERM " :term:`...`
:term:`~term^~<...^`~cursor^
XSETm <...|post
 <~term2^>
XSETm END

XPT ref " :ref:`...`
:ref:`~ref^`

XPT class " :class:`...`
:class:`~class^`

XPT image " :image:...
.. image:: ~source^

XPT param " :param:...
:param ~param^:

XPT type " :type:...
:type ~type^:

XPT rtype " :rtype:...
:rtype: ~return^

XPT include " .. include
.. include:: ~include^
