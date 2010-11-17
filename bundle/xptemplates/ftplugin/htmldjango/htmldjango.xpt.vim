XPTemplate priority=lang-

let s:f = g:XPTfuncs()



XPTinclude
      \ _common/common
      \ html/html

XPT _simpletag hidden " {% $_xSnipName %}
{% `$_xSnipName^ %}
..XP}

XPT _tag hidden " {% $_xSnipName params %}
{% `$_xSnipName^ `params^ %}
..XP}

XPT _simpleblock hidden " {% $_xSnipName %}..{% end$_xSnipName %}
{% `$_xSnipName^ %}`content^{% end`$_xSnipName^ %}
..XPT

XPT _block hidden " {% $_xSnipName  params %}..{% end$_xSnipName %} 
{% `$_xSnipName^ `params^ %}
    `content^
{% end`$_xSnipName^ %}
..XPT

XPT _if " $_xSnipName .. else .. end$_xSnipName
{% `$_xSnipName^ `param^ %}
    `content^
`else...{{^{% else %}
    `content^`}}^
{% end`$_xSnipName^ %}
..XPT

XPT autoescape alias=_block
XPT block alias=_block
XPT comment alias=_simpleblock
XPT csrf_token alias=_simpletag
XPT cycle alias=_tag
XPT debug alias=_simpletag
XPT extends alias=_tag
XPT filter alias=_block
XPT firstof alias=_tag
XPT for alias=_block
XPT empty alias=_simpletag
XPT else alias=_simpletag
XPT if alias=_if
XPT ifchanged alias=_if
XPT ifequal alias=_if
XPT ifnotequal alias=_if
XPT include alias=_tag
XPT load alias=_tag
XPT now alias=_tag
