<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:math="http://www.w3.org/2005/xpath-functions/math"
                xmlns:xh="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="xs math"
                version="1.0">
    
<!-- Purpose: strip almost everything from HTML leaving only the safest and most innocuous code -->
<!--    Input: an XML-well-formed HTML file -->
<!--    Output: An XML-well-formed HTML file, scrubbed -->

    <xsl:param name="report-cleanup">no</xsl:param>
    
    <xsl:variable name="noisy" select="$report-cleanup = 'yes'"/>
    
    <xsl:strip-space elements="*"/>
    
<!-- TODO: acquire list of HTML text-containing elements for preserve-space -->
    <xsl:preserve-space elements="p li td th a i b q u span strong em"/>
    
    <xsl:template match="/*">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="head | style | script"/>
    <xsl:template match="xh:head | xh:style | xh:script"/>
    
    <xsl:template match="comment() | processing-instruction()"/>
    
    <xsl:template match="*">
        <xsl:if test="$noisy">
            <xsl:message>
                <xsl:text>Dropping </xsl:text>
                <xsl:value-of select="local-name()"/>
            </xsl:message>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="h1 | h2 | h3 | h4 | h5 | h6 | 
                         p | ol | ul | li | pre | table | tr | th | td |
                         i | b | strong | em | q | code |
                         xh:h1 | xh:h2 | xh:h3 | xh:h4 | xh:h5 | xh:h6 | 
                         xh:p | xh:ol | xh:ul | xh:li | xh:pre | xh:table | xh:tr | xh:th | xh:td |
                         xh:i | xh:b | xh:strong | xh:em | xh:q | xh:code">
        <xsl:element name="{ local-name() }" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>