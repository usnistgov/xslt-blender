<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:metaschema="http://csrc.nist.gov/ns/metaschema/1.0"
    xmlns:xpmrm="http://csrc.nist.gov/ns/util/1.0" exclude-result-prefixes="xs math" version="1.0">

    <xsl:output method="text"/>

    <xsl:strip-space elements="*"/>

    <xsl:key name="step-by-name" match="*" use="@name"/>
    
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
    
    <xsl:param name="filename"/>
    
    <xsl:template match="/*">
        <xsl:if test="$filename">---&#xA;<xsl:value-of select="$filename"/>&#xA;---</xsl:if>
        <xsl:text xml:space="preserve">&#xA;%%{ init: {
  'flowchart': { 'curve': 'linear' },
  'themeVariables': {
    'primaryColor':       'whitesmoke',
    'secondaryColor':     'lavender',
    'tertiaryColor':      'gainsboro',
    'primaryTextColor':   'black',
    'primaryBorderColor': 'black',
    'lineColor':          'black' },
   'theme':'base' }
}%%</xsl:text>
        <xsl:text>&#xA;flowchart TB&#xA;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
        
    <xsl:template match="/*/p:input" priority="10">
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates mode="write-key" select="."/>
        <xsl:apply-templates mode="write-label" select="."/>
    </xsl:template>

    <xsl:template match="p:output" priority="10">
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates select="p:pipe" mode="write-key"/>
        <xsl:text> -. OUTPUT .-> </xsl:text>
        <xsl:apply-templates mode="write-key" select="."/>
        <xsl:apply-templates mode="write-label" select="."/>
    </xsl:template>

    <xsl:template match="p:identity | p:xslt | metaschema:*">
        <xsl:if test="not(p:input/@port = 'source')">
            <xsl:call-template name="write-implicit-source"/>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="p:input">
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates mode="write-key"/>
        <xsl:if test="not(p:pipe)">
            <xsl:apply-templates mode="write-label"/>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="@port='source'"> ==>|</xsl:when>
            <xsl:otherwise> -->|</xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="translate(@port,$lower,$upper)"/>
        <xsl:text>|</xsl:text>
        <xsl:apply-templates select=".." mode="write-key"/>
        <xsl:apply-templates select=".." mode="write-label"/>
    </xsl:template>

    <xsl:template name="write-implicit-source">
        <xsl:text>&#xA;</xsl:text>
        <xsl:variable name="previous-step" select="preceding-sibling::*[not(self::p:serialization|self::p:import|self::p:output|self::p:input[not(@primary='true')])][1]"/>
        <xsl:apply-templates mode="write-key" select="$previous-step"/>
        
        <xsl:text> ==>|SOURCE|</xsl:text>
        <xsl:apply-templates select="." mode="write-key"/>
        <xsl:apply-templates select="." mode="write-label"/>
    </xsl:template>


    <xsl:template mode="write-key" match="*" priority="-0.5">
        <xsl:value-of select="generate-id(.)"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
    <xsl:template mode="write-key" match="*[@name]" priority="-0.1">
        <xsl:value-of select="@name"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
    <xsl:template mode="write-key" match="*[@port]" priority="-0.1">
        <xsl:value-of select="@port"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
    <xsl:template mode="write-key" match="p:document">
        <xsl:value-of select="../../@name"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="../@port"/>
        <xsl:text>_document</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-key" match="p:input">
        <xsl:text>input_port_</xsl:text>
        <xsl:value-of select="@port"/>
    </xsl:template>
    
    <xsl:template mode="write-key" match="p:pipe">
        <xsl:apply-templates mode="write-key" select="key('step-by-name',@step)"/>
    </xsl:template>
    
    
    <xsl:template mode="write-label" match="p:input">
        <xsl:text>[(input port '</xsl:text>
        <xsl:value-of select="@port"/>
        <xsl:text>')]</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:output">
        <xsl:text>([output port '</xsl:text>
        <xsl:value-of select="@port"/>
        <xsl:text>'])</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:document">
        <xsl:text>[/document '</xsl:text>
        <xsl:value-of select="@href"/>
        <xsl:text>'/]</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:identity">
        <xsl:text>[IDENTITY '</xsl:text>
        <xsl:value-of select="@name | @port"/>
        <xsl:text>']</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:xslt">
        <xsl:text>[[XSLT '</xsl:text>
        <xsl:value-of select="@name | @port"/>
        <xsl:text>']]</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="*">
        <xsl:text>{{</xsl:text>
        <xsl:value-of select="translate(local-name(),$lower,$upper)"/><xsl:text> '</xsl:text>
        <xsl:value-of select="@name | @port"/>
        <xsl:text>'}}</xsl:text>
    </xsl:template>
    
    
</xsl:stylesheet>
