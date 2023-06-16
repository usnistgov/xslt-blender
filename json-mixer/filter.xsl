<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
    
    <xsl:output method="html"/>
    
    <xsl:template match="/*">
        <div>
        <xsl:call-template name="report-processor"/>
        <xsl:call-template name="make-div"/>
        </div>
    </xsl:template>
    
    <xsl:template match="*" name="make-div">
        <div class="{local-name()}">
            <xsl:for-each select="@key">
                <xsl:attribute name="title">
                    <xsl:value-of select="."/>
                </xsl:attribute>
                <xsl:text> </xsl:text>    
            </xsl:for-each>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template name="report-processor">
        <p>
            <xsl:text>XSLT processed with </xsl:text>
            
            
            <xsl:text> </xsl:text>
            <a href="{ system-property('xsl:vendor-url') }">
                <xsl:value-of select="system-property('xsl:vendor')"/>
            </a>
            <xsl:text>, version </xsl:text>
            <xsl:value-of select="system-property('xsl:version')"/>
        </p>
    </xsl:template>
</xsl:stylesheet>