XPTemplate priority=personal

XPT debugger " Debugger
debugger; // XXX DEBUG

XPT log synonym=console " Console.log
XSET arg*|post=ExpandIfNotEmpty(', ', 'arg*')
console.log(`arg*^);

XPT t " this.
this.

XPT fun synonym=function " function ..( .. ) {..}
XSET arg*|post=ExpandIfNotEmpty(', ', 'arg*')
function `name?^(`arg*^) {
    `cursor^
}

XPT module " ( .. function () {} () );
(function (`arg*^) {
    `"use strict";^
    `cursor^
}(`arg*^));

XPT global " Jslint global
XSET arg*|post=ExpandIfNotEmpty(', ', 'arg*')
/*global `arg*^ */

XPT var " var
var `name^` = `value?^`...^,
`name^` = `value?^`...^;


XPT get " Getter
get `name^() {
    `cursor^
},

set `name^(value) { throw "Not allowed"; }

XPT method " Method
`name^: `:function:^

