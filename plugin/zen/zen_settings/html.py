#!/usr/bin/env python
#-*- coding: utf-8 -*-

settings = {
    'extends': 'common',
    'filters': 'html',
    'snippets': {
        'cc:ie6': '<!--[if lte IE 6]>\n\t${child}|\n<![endif]-->',
        'cc:ie': '<!--[if IE]>\n\t${child}|\n<![endif]-->',
        'cc:noie': '<!--[if !IE]><!-->\n\t${child}|\n<!--<![endif]-->',
        'html:4t': '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n' +
            '<html lang="${lang}">\n' +
            '<head>\n' +
            '	<meta http-equiv="Content-Type" content="text/html;charset=${charset}">\n' +
            '	<title></title>\n' +
            '</head>\n' +
            '<body>\n\t${child}|\n</body>\n' +
            '</html>',

        'html:4s': '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">\n' +
            '<html lang="${lang}">\n' +
            '<head>\n' +
            '	<meta http-equiv="Content-Type" content="text/html;charset=${charset}">\n' +
            '	<title></title>\n' +
            '</head>\n' +
            '<body>\n\t${child}|\n</body>\n' +
            '</html>',

        'html:xt': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n' +
            '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="${lang}">\n' +
            '<head>\n' +
            '	<meta http-equiv="Content-Type" content="text/html;charset=${charset}" />\n' +
            '	<title></title>\n' +
            '</head>\n' +
            '<body>\n\t${child}|\n</body>\n' +
            '</html>',

        'html:xs': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">\n' +
            '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="${lang}">\n' +
            '<head>\n' +
            '	<meta http-equiv="Content-Type" content="text/html;charset=${charset}" />\n' +
            '	<title></title>\n' +
            '</head>\n' +
            '<body>\n\t${child}|\n</body>\n' +
            '</html>',

        'html:xxs': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">\n' +
            '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="${lang}">\n' +
            '<head>\n' +
            '	<meta http-equiv="Content-Type" content="text/html;charset=${charset}" />\n' +
            '	<title></title>\n' +
            '</head>\n' +
            '<body>\n\t${child}|\n</body>\n' +
            '</html>',

        'html:5': '<!DOCTYPE HTML>\n' +
            '<html lang="${locale}">\n' +
            '<head>\n' +
            '	<meta charset="${charset}">\n' +
            '	<title></title>\n' +
            '</head>\n' +
            '<body>\n\t${child}|\n</body>\n' +
            '</html>'
    },

    'abbreviations': {
        'a': 'a[href]',
        'a:link': 'a[href="http://|"]',
        'a:mail': 'a[href="mailto:|"]',
        'abbr': 'abbr[title]',
        'acronym': 'acronym[title]',
        'base': 'base[href]',
        'bdo': 'bdo[dir]',
        'bdo:r': 'bdo[dir=rtl]',
        'bdo:l': 'bdo[dir=ltr]',
        'link': 'link[rel=stylesheet href]',
        'link:css': 'link[rel=stylesheet type=text/css href=|style.css media=all]',
        'link:print': 'link[rel=stylesheet type=text/css href=|print.css media=print]',
        'link:favicon': 'link[rel="shortcut icon" type=image/x-icon href=|favicon.ico]',
        'link:touch': 'link[rel=apple-touch-icon href=|favicon.png]',
        'link:rss': 'link[rel=alternate type=application/rss+xml title=RSS href=|rss.xml]',
        'link:atom': 'link[rel=alternate type=application/atom+xml title=Atom href=atom.xml]',
        'meta:utf': 'meta[http-equiv=Content-Type content=text/html;charset=UTF-8]',
        'meta:win': 'meta[http-equiv=Content-Type content=text/html;charset=Win-1251]',
        'meta:compat': 'meta[http-equiv=X-UA-Compatible content="IE=7"]',
        'style': 'style[type=text/css]',
        'script': 'script[type=text/javascript]',
        'script:src': 'script[type=text/javascript src]',
        'img': 'img[src alt]',
        'iframe': 'iframe[src frameborder=0]',
        'embed': 'embed[src type]',
        'object': 'object[data type]',
        'param': 'param[name value]',
        'map': 'map[name]',
        'area': 'area[shape coords href alt]',
        'area:d': 'area[shape=default href alt]',
        'area:c': 'area[shape=circle coords href alt]',
        'area:r': 'area[shape=rect coords href alt]',
        'area:p': 'area[shape=poly coords href alt]',
        'form': 'form[action]',
        'form:get': 'form[action method=get]',
        'form:post': 'form[action method=post]',
        'label': 'label[for]',
        'input': 'input[type]',
        'input:hidden': 'input[type=hidden name]',
        'input:h': 'input[type=hidden name]',
        'input:text': 'input[type=text name id]',
        'input:t': 'input[type=text name id]',
        'input:search': 'input[type=search name id]',
        'input:email': 'input[type=email name id]',
        'input:url': 'input[type=url name id]',
        'input:password': 'input[type=password name id]',
        'input:p': 'input[type=password name id]',
        'input:datetime': 'input[type=datetime name id]',
        'input:date': 'input[type=date name id]',
        'input:datetime-local': 'input[type=datetime-local name id]',
        'input:month': 'input[type=month name id]',
        'input:week': 'input[type=week name id]',
        'input:time': 'input[type=time name id]',
        'input:number': 'input[type=number name id]',
        'input:color': 'input[type=color name id]',
        'input:checkbox': 'input[type=checkbox name id]',
        'input:c': 'input[type=checkbox name id]',
        'input:radio': 'input[type=radio name id]',
        'input:r': 'input[type=radio name id]',
        'input:range': 'input[type=range name id]',
        'input:file': 'input[type=file name id]',
        'input:f': 'input[type=file name id]',
        'input:submit': 'input[type=submit value]',
        'input:s': 'input[type=submit value]',
        'input:image': 'input[type=image src alt]',
        'input:i': 'input[type=image src alt]',
        'input:reset': 'input[type=reset value]',
        'input:button': 'input[type=button value]',
        'input:b': 'input[type=button value]',
        'select': 'select[name id]',
        'option': 'option[value]',
        'textarea': 'textarea[name id cols=30 rows=10]',
        'menu:context': 'menu[type=context]',
        'menu:c': 'menu[type=context]',
        'menu:toolbar': 'menu:t',
        'menu:t': 'menu[type=toolbar]',
        'video': 'video[src]',
        'audio': 'audio[src]',
        'html:xml': 'html[xmlns=http://www.w3.org/1999/xhtml]',
        'bq': 'blockquote',
        'acr': 'acronym',
        'fig': 'figure',
        'ifr': 'iframe',
        'emb': 'embed',
        'obj': 'object',
        'src': 'source',
        'cap': 'caption',
        'colg': 'colgroup',
        'fst': 'fieldset',
        'btn': 'button',
        'optg': 'optgroup',
        'opt': 'option',
        'tarea': 'textarea',
        'leg': 'legend',
        'sect': 'section',
        'art': 'article',
        'hdr': 'header',
        'ftr': 'footer',
        'adr': 'address',
        'dlg': 'dialog',
        'str': 'strong',
        'prog': 'progress',
        'fset': 'fieldset',
        'datag': 'datagrid',
        'datal': 'datalist',
        'kg': 'keygen',
        'out': 'output',
        'det': 'details',
        'cmd': 'command',
        'ol+': 'ol>li',
        'ul+': 'ul>li',
        'dl+': 'dl>dt+dd',
        'map+': 'map>area',
        'table+': 'table>tr>td',
        'colgroup+': 'colgroup>col',
        'colg+': 'colgroup>col',
        'tr+': 'tr>td',
        'select+': 'select>option',
        'optg+': 'optgroup>option',
        'optgroup+': 'optg+'
    },

    'element_types': {
        'empty': 'area,base,basefont,br,col,frame,hr,img,input,isindex,link,meta,param,embed,keygen,command',
        'block_level': 'address,applet,blockquote,button,center,dd,del,dir,div,dl,dt,fieldset,form,frameset,hr,iframe,ins,isindex,li,map,menu,noframes,noscript,object,ol,p,pre,script,table,tbody,td,tfoot,th,thead,tr,ul,h1,h2,h3,h4,h5,h6',
        'inline_level': 'a,abbr,acronym,applet,b,basefont,bdo,big,br,button,cite,code,del,dfn,font,i,iframe,ins,kbd,label,map,object,q,s,samp,small,span,strike,strong,sub,sup,textarea,tt,u,var'
    }
}
