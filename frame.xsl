<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns="http://www.w3.org/1999/xhtml" >
    
    <xsl:output method="html"/>

    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
     <xsl:template match="*[@id='nist-page-header']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:call-template name="nist-page-header"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="nist-page-header">
        
    </xsl:template>
    
</xsl:stylesheet>    
