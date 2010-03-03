#!/usr/bin/env python
#-*- coding: utf-8 -*-

__version__ = '0.01'

import zen_settings as settings
from zen_core import ZenStream, ZenNode, ZenRoot

ATTR_CTRL = '.#[]'
TREE_CTRL = '+<>*()'
DATA = None


def extract_abbr(line):
    source = ''
    if line.find('<') >= 0 and (line.find('<') < line.find('>')):
        source = line[:line.find('>')+1]
        line = line[len(source):]

    if line.find(' ') > 0 and (line.find('[') > line.find(' ')
                               or line.find('[') == -1):
        source = line[:line.find(' ')+1]
        line = line[len(source):]

    return line


def parse_profile(profile):
    if profile == 'plain':
        ZenNode.carret_sym = ZenNode.indent_sym = ZenNode.nl = ''
    else:
        ZenNode.carret_sym = '|'
        ZenNode.indent_sym = '\t'
        ZenNode.nl = '\n'


def expand_abbr(string, mode="html", profile="plain"):
    parse_profile(profile)
    global DATA
    DATA = settings.get(mode)
    try: return DATA['snippets'][string]
    except: pass

    stream = ZenStream(string)
    tree = parse_tree(stream)
    return str(tree)


def _check_root(root, abbr):
    if not len(root): root.appendNode(parse_node(abbr))
    return ''


def _check_expand(abbr):
    if DATA['abbreviations'].get(abbr):
        return DATA['abbreviations'].get(abbr)
    return False


def parse_tree(stream, group = False):

    abbr = stream.readOut(TREE_CTRL)
    expand = _check_expand(abbr)
    if expand and not expand.find('[') > -1:
        stream.push(expand)
        return parse_tree(stream, group)

    root = ZenRoot()
    for ch in stream:

        if ch == ')':
            if not group:
                stream.push(')')
            break
        
        elif ch == '(':
            root.appendNode(parse_tree(stream, True))

        elif ch == "+":

            if _check_expand(abbr + '+'):
                stream.push(_check_expand(abbr + '+'))
                abbr = ''
                continue

            abbr = _check_root(root, abbr)
            root.appendNode(parse_tree(stream))

        elif ch == '>':
            abbr = _check_root(root, abbr)
            root.lastNode().appendNode(parse_tree(stream))

        elif ch == "*":
            abbr = _check_root(root, abbr)
            count = int(stream.next()) -1

            if stream.current == '>':
                stream.next()
                root.lastNode().appendNode(parse_tree(stream))

            for i in range(count):
                root.appendNode(root.lastNode().copy())

        else: abbr += ch

    if abbr: root.appendNode(parse_node(abbr))
    
    return root


def parse_node(string):
    stream2 = ''
    stream = ZenStream(string)
    name = stream.readOut(ATTR_CTRL)
    if name == '': name = 'div'
    try:
        name = DATA['abbreviations'][name]
        stream2 = ZenStream(name)
        name = stream2.readOut(ATTR_CTRL)
        result = ZenNode(name, DATA['element_types'].get(name, 'block'))
        if len(stream2): parse_attributes(stream2, result)
    except:
        result = ZenNode(name, DATA['element_types'].get(name, 'block'))
    parse_attributes(stream, result)
    return result


def parse_attributes(stream, node):
    while len(stream):

        if stream.current == '.':
            cls = ''
            while len(stream) and stream.current == '.':
                stream.next()
                cls += stream.readOut(ATTR_CTRL) + ' '
            node.appendAttribute('class', cls.rstrip())

        elif stream.current == '#':
            stream.next()
            node.appendAttribute('id', stream.readOut(ATTR_CTRL))

        elif stream.current == '[':
            stream.next()
            while len(stream):
                name = stream.readOut(' =]')

                if stream.current == ' ':
                    node.appendAttribute(name)

                elif stream.current == '=':
                    stream.next()
                    if stream.current in '"\'':
                        stream.next()
                        value = stream.readOut('"\'')
                    else:
                        value = stream.readOut(' ]')
                    node.appendAttribute(name, value)

                elif stream.current == ']':
                    node.appendAttribute(name)
                    stream.next()
                    break

                try: stream.next()
                except StopIteration: pass 

def main():

    import optparse

    p = optparse.OptionParser(
        version=__version__,
        usage="%prog [--profile=PROFILE] [--mode=MODE] LINE",
        description="""Parse line in zen codding""")

    p.add_option(
        '-p', '--profile', default='plain', metavar='PROFILE',
        help="Use zen profile")

    p.add_option(
        '-m', '--mode', default='html', metavar='MODE',
        help="Use zen mode")

    options, args = p.parse_args()
    if len(args) != 1:
        p.error("Wrong number of arguments. See --help")

    print expand_abbr(args[0], options.mode, options.profile)


if __name__ == '__main__':
    main()
