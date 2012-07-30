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

XPT image " :image:...
.. image:: ~source^
