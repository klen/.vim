#!/usr/bin/env python
#-*- coding: utf-8 -*-


from copy import copy


class ZenStream:

    def __init__(self, string):
        self.stream = list(string)
        self.current = self.stream[0]

    def next(self):
        if not len(self.stream): raise StopIteration
        result = self.stream.pop(0)
        self.current = self.stream[0] if len(self.stream) else None
        return result

    def readOut(self, sym):
        result = ''
        while len(self.stream) and not self.current in sym:
            result += self.next()
        return result

    def push(self, string):
        self.stream[0:0] = list(string)
        self.current = self.stream[0]

    def __len__(self):
        return len(self.stream)

    def __iter__(self):
        return self


class ZenNode:

    def __init__(self, name, type='block', count=1):
        self.name = name.lower()
        self.indent = ''
        self.type = type
        self.count = self.copies = count
        self.attributes = []
        self.childNodes = []
        self.root = False

    def appendNode(self, node):
        self.childNodes.append(node)
        node.indent = self.indent + self.indent_sym if not node.root else self.indent
        node.parent = self

    def appendAttribute(self, attr, value=''):
        if not attr: return False
        for k in range(len(self.attributes)):
            if self.attributes[k][0] == attr: del self.attributes[k]
        self.attributes.append((attr,value))

    def copy(self):
        node = ZenNode(self.name, self.type, self.copies+1)
        node.attributes = copy(self.attributes)
        node.childNodes = copy(self.childNodes)
        self.copies += 1
        return node

    def lastNode(self):
        return self.childNodes[-1] if len(self.childNodes) else None

    def __len__(self):
        return len(self.childNodes)

    def __replaceValue(self, value):
        result, holder = '', ''
        for c in value:
            if c == '$':
                holder += '$'
            else:
                if holder:
                    result += str(self.count).zfill(len(holder))
                    holder = ''
                result += c
        if holder: result += str(self.count).zfill(len(holder))
        return result

    def __str__(self):

        result = '<' + self.name

        for k,v in self.attributes:
            v = self.__replaceValue(v) if v else self.carret_sym
            result += ' %s="%s"' % (k,v)

        if self.type == 'empty' and not len(self.childNodes):
            result += ' />'
            return result

        result += '>'
        if len(self.childNodes):
            s = self.nl + self.indent
            result += s + s.join([str(node) for node in self.childNodes ]) + self.nl
        else: result += self.carret_sym

        result += '</%s>' % self.name
        return result


class ZenRoot(ZenNode):

    def __init__(self):
        self.childNodes = []
        self.indent = ''
        self.root = True

    def __str__(self):
        s = self.nl + self.indent
        return s.join([str(node) for node in self.childNodes ])
