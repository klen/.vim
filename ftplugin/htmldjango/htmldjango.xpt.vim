XPTemplate priority=lang-

XPTinclude
      \ _common/common
      \ xml/xml
      \ html/html


XPT _tag hidden " {% $_xSnipName %}..{% end$_xSnipName %}
{% `$_xSnipName^ %}`cursor^{% end`$_xSnipName^ %}
..XPT

XPT _short_tag hidden " {% $_xSnipName .. %}
{% `$_xSnipName^ `cursor^ %}

XPT _simple_tag hidden " {% $_xSnipName %}
{% `$_xSnipName^ %}

XPT _filter hidden " |filter
|`filter^


" ========================= Snippets =============================

XPT autoescape alias=_short_tag " Control the current auto-escaping behavior

XPT block " Define a block that can be overridden by child templates
{% block `name^ %}
    `cursor^
{%endblock `name^ %}

XPT comment alias=_tag " Ignore everything between

XPT csrf_token alias=_short_tag " It is used for CSRF protection

XPT cycle alias=_short_tag " Cycle among the given strings or variables each time this tag is encountered

XPT debug alias=_simple_tag " Output a whole load of debugging information

XPT extends " Signal that this template extends a parent template
{% extends '`template_path^' %}

XPT filter " Outputs the first variable passed that is not False, without escaping.
{% filter `filters_set^ %}
{% endfilter %}

XPT firstof alias=_short_tag " Outputs the first variable passed that is not False, without escaping

XPT for " Loop over each item in an array
{% for `item^ in `range^ %}
    {{ `item^`cursor^ }}
{% endfor %}

XPT for " for ... empty
{% for `item^ in `range^ %}
    {{ `item^`cursor^ }}
{% empty %}
    `empty_range^
{% endfor %}

XPT if
{% if `condition^ %}
    `so^
`else...{{^`:else:^`}}^
{% endif %}

XPT else " else
{% else %}
    `cursor^

XPT ifchanged alias=_tag " Check if a value has changed from the last iteration of a loop

XPT ifequal alias=_tag " Output the contents of the block if the two arguments equal each othe

XPT ifnotequal alias=_tag " Just like ifequal, except it tests that the two arguments are not equal

XPT include " Loads a template and renders it with the current context
{% include '`cursor^' %}

XPT load alias=_short_tag " Load a custom template tag set.

XPT now alias=_short_tag " Display the date, formatted according to the given string.

XPT regroup " Regroup a list of alike objects by a common attribute.
{% regroup `item^ by `key^ as `list_name^ %}

XPT spaceless alias=_tag " Removes whitespace between HTML tags. This includes tab characters and newlines.

XPT ssi alias=_short_tag " Output the contents of a given file into the page.

XPT templatetag alias=_simple_tag " Output one of the syntax characters used to compose template tags.

XPT url " Returns an resolved absolute URL
{% url `view_path^ `params?^ %}

XPT var " Django template variable
{{ `var^`|filters...{{^`:_filter:^`}}^ }}

XPT widthratio " Width calculator
{% widthratio `this_value^ `max_value^ `ratio^ %}

XPT with " Caches a complex variable under a simpler name.
{% with `complex_name^ as `simple_name^ %}
    `expression^    
{% endwith %}

XPT trans
{% trans "`cursor^" %}

