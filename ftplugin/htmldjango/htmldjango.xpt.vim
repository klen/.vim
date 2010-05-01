" These snippets work only in html context of django template file
" by proft [http://proft.com.ua]

XPTemplate priority=lang

XPTemplateDef

XPT tag " tag
{% `cursor^ %}

XPT btag " block tag
{% `btag^ %}
`cursor^
{% `btag^end %}

XPT var " template var
{{ `cursor^ }}

XPT block
{% block `name^ %}
`cursor^
{% endblock %}

XPT lcomment
{# `cursor^ #}

XPT bcomment
{% comment %}
`cursor^
{% endcomment %}

XPT for
{% for `name^ in `range^ %}
`cursor^
{% endfor %}

XPT if
{% if `condition^ %}
`cursor^
{% endif %}

XPT else
{% else %}

XPT ifchanged
{% ifchanged %}`cursor^{% endifchanged %}

XPT ifequal
{% ifequal `condition1^ `condition2^ %}
`cursor^
{% endifequal %}

XPT ifnotequal
{% ifnotequal `condition1^ `condition2^ %}
`cursor^
{% endifnotequal %}

XPT include
{% include `name^ %}

XPT load
{% load `name^ %}

XPT trans
{% trans "`string^" %}
