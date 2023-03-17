<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Purpose: Convert XML to markdown. Note that namespace bindings must be given. -->

    <xsl:output omit-xml-declaration="yes" method="text"/>

    <xsl:strip-space elements="*"/>

    <xsl:preserve-space elements="pre p h1 h2 h3 h4 h5 h6 li th td 
        xh:pre xh:p xh:h1 xh:h2 xh:h3 xh:h4 xh:h5 xh:h6 xh:li xh:th xh:td"/>

    <xsl:template match="/">
        <xsl:apply-templates mode="md"/>
    </xsl:template>

    <xsl:template name="lf">
        <!-- A trick to avoid the LFs for the first one -->
        <!-- nb depends on inputs being flat -->
        <xsl:for-each select="preceding-sibling::*[1]">
          <xsl:text>&#xA;&#xA;</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <!--<xsl:template name="conditional-lf">
        <xsl:variable name="predecessor" select="
                preceding-sibling::p | preceding-sibling::ul | preceding-sibling::ol | preceding-sibling::table | preceding-sibling::pre |
                preceding-sibling::xh:p | preceding-sibling::xh:ul | preceding-sibling::xh:ol | preceding-sibling::xh:table | preceding-sibling::xh:pre"/>
        <xsl:if test="$predecessor">
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>-->

    <!-- rewriting loose text as a paragraph   -->
    <xsl:template mode="md" match="xh:div/text() | div/text()">
        <!--<xsl:call-template name="conditional-lf"/>-->
        <xsl:call-template name="lf"/>
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template mode="md" match="xh:p | p">
        <!--<xsl:call-template name="conditional-lf"/>-->
        <xsl:call-template name="lf"/>
        <xsl:variable name="out">
          <xsl:apply-templates mode="md"/>
        </xsl:variable>
        <xsl:value-of select="normalize-space($out)"/>
    </xsl:template>
    
    <xsl:template mode="md" match="
            h1 | h2 | h3 | h4 | h5 | h6 |
            xh:h1 | xh:h2 | xh:h3 | xh:h4 | xh:h5 | xh:h6">
        <xsl:call-template name="lf"/>
        <xsl:apply-templates select="." mode="mark"/>
        <xsl:apply-templates mode="md"/>
    </xsl:template>

    <xsl:template mode="mark" match="xh:h1 | h1"># </xsl:template>
    <xsl:template mode="mark" match="xh:h2 | h2">## </xsl:template>
    <xsl:template mode="mark" match="xh:h3 | h3">### </xsl:template>
    <xsl:template mode="mark" match="xh:h4 | h4">#### </xsl:template>
    <xsl:template mode="mark" match="xh:h5 | h5">##### </xsl:template>
    <xsl:template mode="mark" match="xh:h6 | h6">###### </xsl:template>

    <xsl:template mode="md" match="xh:table | table">
        <xsl:call-template name="lf"/>
        <xsl:apply-templates select="*" mode="md"/>
    </xsl:template>

    <xsl:template mode="md" match="xh:tr | tr">
        <xsl:call-template name="lf"/>
        <string>
            <xsl:apply-templates select="*" mode="md"/>
        </string>
        <xsl:if test="not(preceding-sibling::tr | preceding-sibling::xh:tr)">
            <xsl:call-template name="lf"/>
            <xsl:text>|</xsl:text>
            <xsl:for-each select="xh:th | xh:td | th | td">
                <xsl:text> --- |</xsl:text>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template mode="md" match="th | td | xh:th | xh:td">
        <xsl:if test="not(preceding-sibling::*)">|</xsl:if>
        <xsl:text> </xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text> |</xsl:text>
    </xsl:template>

    <xsl:template mode="md" priority="1" match="xh:pre | pre">
        <xsl:call-template name="lf"/>
        <xsl:text>```&#10;</xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text>&#10;```&#10;</xsl:text>
    </xsl:template>

    <xsl:template mode="md" priority="1" match="xh:ul | xh:ol | ul | ol">
        <xsl:call-template name="lf"/>
        <xsl:apply-templates mode="md"/>
    </xsl:template>

    <xsl:template mode="md" match="
            xh:ul//xh:ul | xh:ol//xh:ol | xh:ol//xh:ul | xh:ul//xh:ol |
            ul//ul | ol//ol | ol//ul | ul//ol">
        <xsl:apply-templates mode="md"/>
    </xsl:template>

    <xsl:template mode="md" match="xh:li | li">
        <xsl:call-template name="lf"/>
        <xsl:call-template name="listitem-indent"/>
        <xsl:text>* </xsl:text>
        <xsl:apply-templates mode="md"/>
    </xsl:template>

    <xsl:template name="listitem-indent">
        <xsl:for-each
            select="../ancestor::xh:ul | ../ancestor::ul | ../ancestor::xh:ol | ../ancestor::ol">
            <xsl:text>&#32;&#32;</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <!-- Since XProc doesn't support character maps we do this in XSLT -   -->

    <xsl:template mode="md" match="xh:ol/xh:li | ol/li">
        <xsl:call-template name="lf"/>
        <xsl:call-template name="lf"/>
        <xsl:call-template name="listitem-indent"/>
        <xsl:text>1. </xsl:text>
        <xsl:apply-templates mode="md"/>
    </xsl:template>
    <!-- Since XProc doesn't support character maps we do this in XSLT -   -->



    <xsl:template mode="md" match="xh:code | code">
        <xsl:text>`</xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text>`</xsl:text>
    </xsl:template>

    <xsl:template mode="md" match="xh:em | xh:i | em | i">
        <xsl:text>*</xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text>*</xsl:text>
    </xsl:template>

    <xsl:template mode="md" match="xh:strong | xh:b | strong | b">
        <xsl:text>**</xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text>**</xsl:text>
    </xsl:template>

    <xsl:template mode="md" match="xh:q | q">
        <xsl:text>"</xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text>"</xsl:text>
    </xsl:template>

    <!-- in case a random OSCALish `insert` creeps in -->
    <!-- <insert type="param" id-ref="ac-1_prm_1"/> -->
    <xsl:template mode="md" match="xh:insert | insert">
        <xsl:text>{{ insert: </xsl:text>
        <xsl:value-of select="@type"/>
        <xsl:if test="@type and @id-ref">, </xsl:if>
        <xsl:value-of select="@id-ref"/>
        <xsl:text> }}</xsl:text>
    </xsl:template>

    <xsl:key name="element-by-id" match="*[@id]" use="@id"/>

    <xsl:template mode="md" match="xh:a | a">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>]</xsl:text>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="@href"/>
        <xsl:text>)</xsl:text>
    </xsl:template>

    <!-- See top level template match="/" for XSLT:template match="text()" mode="md" -->


</xsl:stylesheet>