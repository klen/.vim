#!/usr/bin/env python
#-*- coding: utf-8 -*-


CACHE = {}


def get(mode):
    if not CACHE.has_key(mode): CACHE[mode] = parse(mode)
    return CACHE[mode]


def parse(mode):
    data = { 'element_types' : {}, 'abbreviations': {} }
    s = 'from %s import settings' % mode
    try: exec(s)
    except: return data
    for k in settings.keys(): update(settings, data, k)
    if settings.has_key('element_types'):
        data['element_types'] = parse_types(settings['element_types'])
    if settings.has_key('extends'):
        for mode in settings['extends'].split(','):
            d = get(mode)
            for k in d.keys(): update(d, data, k)

    return data


def update(d, r, key):
    if d.has_key(key) and isinstance(d[key], dict):
        if not r.has_key(key): r[key] = dict()
        d[key].update(r[key])
        r[key] = d[key]


def parse_types(types):
    result = []
    for k,v in types.items():
        result += [(x,k) for x in v.split(',')]
    return dict(result)
