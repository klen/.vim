#!/usr/bin/env python
#-*- coding: utf-8 -*-

settings =  {
    'extends': 'common,html',
    'filters': 'html, xsl',
    'abbreviations': {
        'tm': 'xsl:template[match mode]',
        'tmatch': 'xsl:template[match mode]',
        'tn': 'xsl:template[name]',
        'tname': 'tn',
        'xsl:when': 'xsl:when[test]',
        'wh': 'xsl:when',
        'var': 'xsl:variable[name]',
        'vare': 'xsl:variable[name select]',
        'if': '<xsl:if test=""></xsl:if>',
        'call': '<xsl:call-template name=""/>',
        'attr': '<xsl:attribute name=""></xsl:attribute>',
        'wp': 'xsl:with-param[name select]',
        'par': '<xsl:param name="" select=""/>',
        'val': '<xsl:value-of select=""/>',
        'co': '<xsl:copy-of select=""/>',
        'each': '<xsl:for-each select=""></xsl:for-each>',
        'ap': 'xsl:apply-templates[select mode]',
        'choose+': 'xsl:choose>xsl:when+xsl:otherwise'
    },
    'element_types': {
        'empty' : 'xsl:apply-templates,xsl:with-param,xsl:variable',
        'block_level' : '',
        'inline_level' : ''
    }
}
