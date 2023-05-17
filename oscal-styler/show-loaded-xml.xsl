<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0">
    
    <xsl:template match="/*">
        <xsl:variable name="class">
            <xsl:choose>
                <xsl:when test="self::oscal:*">oscal</xsl:when>
                <xsl:otherwise>unknown</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <h4>XML document loaded: <tt><xsl:value-of select="name()"/></tt></h4>
        <div class="{ $class }">
            <xsl:for-each select="/*/oscal:metadata/oscal:title">
                <h5><xsl:apply-templates/></h5>
            </xsl:for-each>
            <xsl:if test="$class='unknown'"><h5>not an OSCAL document</h5></xsl:if>
            <p>
                <xsl:value-of select="count(//*)"/>
                <xsl:choose>
                    <xsl:when test="count(//*) &gt; 1"> elements; </xsl:when>
                    <xsl:otherwise> element; </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="count(//@*)"/>
                <xsl:choose>
                    <xsl:when test="count(//@*) &gt; 1"> attributes</xsl:when>
                    <xsl:otherwise> attribute</xsl:otherwise>
                </xsl:choose>
            </p>
            
        </div>
    </xsl:template>
    
    
</xsl:stylesheet>