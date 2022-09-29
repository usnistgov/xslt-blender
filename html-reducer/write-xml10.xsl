<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:math="http://www.w3.org/2005/xpath-functions/math"
                xmlns:xh="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="xs math"
                version="1.0">
    
    <!--very crude serializer relies on XML output method for escaping at the character level -->
    <xsl:output method="xml"/>
    
    <xsl:template match="/*">
        <pre style="white-space: pre-line">
          <xsl:apply-templates/>
        </pre>
    </xsl:template>

    <xsl:template match="*">
        <xsl:call-template name="start-tag"/>
        <xsl:apply-templates/>
        <xsl:text>&#10;</xsl:text>
        <xsl:call-template name="end-tag"/>
    </xsl:template>
    
    <xsl:template match="p | h1 | h2 | h3 | h4 |h5 | h6">
        <xsl:call-template name="lf-and-indent"/>
        <xsl:call-template name="start-tag"/>
        <xsl:apply-templates/>
        <xsl:call-template name="end-tag"/>
    </xsl:template>
    
    <xsl:template match="ul | ol | li">
        <xsl:call-template name="lf-and-indent"/>
        <xsl:call-template name="start-tag"/>
        <xsl:apply-templates/>
        <xsl:for-each select="self::ol | self::ul">
            <xsl:call-template name="lf-and-indent"/>
        </xsl:for-each>
        <xsl:call-template name="end-tag"/>
    </xsl:template>
    
    <xsl:template name="lf-and-indent">
        <xsl:text>&#10;</xsl:text>
        <xsl:for-each select="ancestor::*">
            <xsl:text>  </xsl:text>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="start-tag">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:apply-templates select="@*" mode="tag"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:text> </xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>="</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template name="end-tag">
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="h1//* | h2//* | h3//* | h4//* | h5//* | h6//* | p//* | li//* | td//* | td//*" priority="2">
        <xsl:call-template name="start-tag"/>
        <xsl:apply-templates/>
        <xsl:call-template name="end-tag"/>
    </xsl:template>
    
</xsl:stylesheet>