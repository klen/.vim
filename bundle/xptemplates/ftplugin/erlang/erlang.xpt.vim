XPTemplate priority=lang

let s:f = g:XPTfuncs()

XPTinclude
    \ _common/common


" ========================= Function and Variables =============================

XPTvar $SParg         ' '
XPTvar $SPfun         ' '

fun! s:f.year(...)
  return strftime( '%Y' )
endfun

" ================================= Snippets ===================================

XPT module " -module ..
-module`$SPfun^(`$SParg^`expand('%:t:r')^`$SParg^).

XPT author " -author ..
-author`$SPfun^(`$SParg^'`$author^ <`$email^>'`$SParg^).

XPT include " -include ..
-include`$SPfun^(`$SParg^"`cursor^.hrl"`$SParg^).

XPT include_lib " -include_lib ..
-include_lib`$SPfun^(`$SParg^"`cursor^.hrl"`$SParg^).

XPT export " -export ...
-export`$SPfun^([
    `name0^/`0^` `...^,
    `namen^/`0^` `...^
    ]).

XPT comp " -compile ...
-compile(`export_all^).

XPT behavior " -behavior ..
-behavior`$SPfun^(`$SParg^`gen_server^`$SParg^).

XPT define " -define ..
-define`$SPfun^(`$SParg^`what^, `?MODULE^`$SParg^).

XPT ifdef " -ifdef ..\-endif..
-ifdef`$SPfun^("`$SParg^`what^"`$SParg^).
    `thenmacro^
``else...`
{{^-else.
    `cursor^
`}}^-endif().

XPT ifndef " -ifndef ..\-endif
-ifndef`$SPfun^("`$SParg^`what^"`$SParg^).
    `thenmacro^
``else...`
{{^-else.
    `cursor^
`}}^-endif().

XPT record " -record ..,{..}
-record`$SPfun^(`$SParg^`recordName^, {
    `key0^`=value0^` `...^,
    `keyn^`=valuen^` `...^
    }`$SParg^).

XPT if " if .. -> .. end
if
    `cond^ ->
        `body^ `...^;
    `cond2^ ->
        `bodyn^ `...^
end

XPT case " case .. of .. -> .. end
case `matched^ of
    `pattern^ ->
        `body^` `...^;
    `patternn^ ->
        `bodyn^` `...^
end

XPT receive " receive .. -> .. end
receive
    `pattern^ ->
        `body^` `...^;
    `patternn^ ->
        `body^` `...^`
   `after...{{^
    after
    `afterBody^`}}^
end

XPT fun " fun .. -> .. end
fun (`params^) `_^ -> `body^`
    `more...{{^;
    (`params^) `_^ -> `body^`
    `...{{^;
    (`params^) `_^ -> `body^`
    `...^`}}^`}}^
end

XPT try wrap=what " try .. catch .. end
try `what^
catch
    `except^ -> `toRet^`
    `...^;
    `except^ -> `toRet^`
    `...^`
`after...{{^
after
    `afterBody^`}}^
end

XPT tryof " try .. of ..
try `what^ of
    `pattern^ ->
        `body^` `more...^;
    `patternn^ ->
        `body^` `more...^
catch
    `excep^ -> `toRet^` `...^;
    `except^ -> `toRet^` `...^`
`after...{{^
after
    `afterBody^`}}^
end

XPT function " f \( .. \) -> ..
`funName^`$SPfun^(`$SParg^`args0^`$SParg^) `when^->
    `body0^ `...^;
`name^R('funName')^`$SPfun^(`$SParg^`argsn^`$SParg^) `when^->
    `bodyn^ `...^
.

XPT head " head of file
%% -------------------------------------------------------------------
%%  @author `$author^ <`$email^>
%%          `[`url^]^
%% 
%%  @copyright `year()^ `$email^   
%% 
%%  @doc `description^
%%  @end                      
%% -------------------------------------------------------------------

..XPT

XPT doc synonym=spec " documentation
%% @spec `name^(`args^) -> `{ ok, Term }^ `...^| `{ Other }^ `...^
%% @doc  `description^

" ================================= Lib Snippets ===================================

XPT format " io:format ...
io:format`$SPfun^(`$SParg^"`message^"`, Params...{{^, [`params^]`}}^`$SParg^)

XPT logger_info synonym=info " error_logger info
error_logger:info_msg`$SPfun^(`$SParg^"`message^"`, Params...{{^, [`params^]`}}^`$SParg^)

XPT logger_error synonym=error " error_logger info
error_logger:error_msg`$SPfun^(`$SParg^"`message^"`, Params...{{^, [`params^]`}}^`$SParg^)

XPT application_start " application:start
application:start`$SPfun^(`$SParg^`expand('%:t:r')^`$SParg^)

XPT application_stop " application:stop
application:stop`$SPfun^(`$SParg^`expand('%:t:r')^`$SParg^)

XPT application_unload " application:unload
application:unload`$SPfun^(`$SParg^`expand('%:t:r')^`$SParg^)

XPT gen_server_cast " gen_server cast
gen_server:cast`$SPfun^(`$SParg^`?SERVER^, `Request^`$SParg^)

XPT gen_server_call " gen_server call
gen_server:call`$SPfun^(`$SParg^`?SERVER^, `Request^`, Timeout...{{^, `5000^`}}^`$SParg^)

XPT gen_server_start " gen_server start_link
gen_server:start_link`$SPfun^(`$SParg^{ `local^, `?SERVER^ }, `?MODULE^, `[]^, `[]^`$SParg^)

" ================================= OTP Snippets ===================================

XPT stop " stop -> ok
stop`$SPfun^(`$SParg^_State`$SParg^) ->
    ok
.

..XPT
