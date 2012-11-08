XPTemplate priority=personal

XPT htmltag_ hidden wrap=content " <$_xSnipName >\n .. \n</$_xSnipName>
XSET content|def=Echo( R( 't' ) =~ '\v/\s*$' ? Finish() : '' )
XSET content|ontype=html_cont_ontype()
<`$_xSnipName^` `...^ `name^='`value^'`...^>`content^`content^html_cont_helper()^</`$_xSnipName^>

XPT div alias=htmltag_
XPT p   alias=htmltag_
XPT ul  alias=htmltag_
XPT ol  alias=htmltag_
XPT li  alias=htmltag_

XPT table alias=htmltag_
XPT thead alias=htmltag_
XPT tbody alias=htmltag_
XPT tr    alias=htmltag_
XPT td    alias=htmltag_
XPT th    alias=htmltag_

XPT h1 alias=htmltag_
XPT h2 alias=htmltag_
XPT h3 alias=htmltag_
XPT h4 alias=htmltag_
XPT h5 alias=htmltag_
XPT h6 alias=htmltag_
