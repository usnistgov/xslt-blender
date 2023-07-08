<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:metaschema="http://csrc.nist.gov/ns/metaschema/1.0"
    xmlns:xpmrm="http://csrc.nist.gov/ns/util/1.0" exclude-result-prefixes="xs math" version="1.0">

    <xsl:output method="text"/>

    <xsl:strip-space elements="*"/>

    <xsl:key name="step-by-name" match="/*/*" use="@name"/>
    
    <xsl:key name="step-by-gi" match="/*/*" use="local-name()"/>

    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
    
    <xsl:param name="filename"/>


    <xsl:template match="/*">
        <xsl:if test="$filename">---&#xA;<xsl:value-of select="$filename"/>&#xA;---</xsl:if>
        <xsl:text>&#xA;stateDiagram-v2&#xA;</xsl:text>
        <xsl:apply-templates select="descendant::*" mode="step-styler"/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates mode="step-labeler"/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates mode="subpipelines"/>
        
        <xsl:apply-templates mode="edges">
            <!--<xsl:sort select="count(*) + position()"/>-->
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="*" mode="step-styler"/>
    
    <xsl:template mode="step-styler" match="p:sink" priority="101"/>
    
    
    <xsl:template mode="step-styler" match="*[generate-id()=generate-id(key('step-by-gi',local-name())[1])]">
        <xsl:apply-templates select="." mode="step-style"/>
    </xsl:template>
    
    <xsl:template match="*" mode="step-style">
        <xsl:text>&#xA;classDef </xsl:text>
        <xsl:value-of select="concat(translate(local-name(),'-','_'),'Class ')"/>
        <xsl:apply-templates select="." mode="style-class"/>
    </xsl:template>
    
    <xsl:template match="*" mode="style-class">
        <xsl:text>font-style:italic,font-weight:bold,fill:white,stroke:midnightblue</xsl:text>
    </xsl:template>
    
    <xsl:template match="p:input" mode="style-class">
        <xsl:text>font-weight:bold,fill:skyblue,stroke:midnightblue</xsl:text>
    </xsl:template>
    
    <xsl:template match="p:output" mode="style-class">
        <xsl:text>font-weight:bold,fill:lightgreen,stroke:forestgreen,stroke-dasharray:2</xsl:text>
    </xsl:template>
    
    <xsl:template match="p:identity" mode="style-class">
        <xsl:text>fill:gainsboro,stroke:black</xsl:text>
    </xsl:template>
    
    <xsl:template match="p:xslt" mode="style-class">
        <xsl:text>fill:lavender,stroke:purple</xsl:text>
    </xsl:template>
    
    <xsl:template mode="step-styler" match="p:serialization | p:import" priority="101"/>

    <xsl:template mode="step-labeler" match="p:serialization | p:import" priority="101"/>
    
    <xsl:template mode="step-labeler" match="p:sink" priority="101"/>
    

    <xsl:template match="*" mode="step-labeler">
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates mode="write-key" select="."/>
        <xsl:text>:::</xsl:text>
        <xsl:value-of select="concat(translate(local-name(),'-','_'),'Class:')"/>
        <!--<xsl:text> : </xsl:text>-->
        <xsl:apply-templates mode="write-label" select="."/>
        
        <xsl:apply-templates select="self::p:xslt/p:input[@port='stylesheet']" mode="step-labeler"/>
    </xsl:template>
    
    <xsl:template mode="subpipelines" match="*"/>
    
    <xsl:template mode="subpipelines" match="p:xslt">
        <xsl:text>&#xA;state </xsl:text>
        <xsl:apply-templates select="." mode="write-key"/>
        <xsl:text> {</xsl:text>
        <!--<xsl:apply-templates select="p:input[@port='stylesheet']" mode="step-labeler"/>-->
        <xsl:text xml:space="preserve">
    [*] --> [*]            
    </xsl:text>
        <xsl:apply-templates select="p:input[@port='stylesheet']" mode="write-key"/>
        <xsl:text xml:space="preserve"> --> [*]
}</xsl:text>
        
    </xsl:template>
    
    <xsl:template match="p:output/p:pipe" priority="10" mode="edges">
        <xsl:text>&#xA;</xsl:text>
        <!--write-key writes the key of the linked step -->
        <xsl:apply-templates select="." mode="write-key"/>
        <xsl:text> --> </xsl:text>
        <xsl:apply-templates mode="write-key" select=".."/>
    </xsl:template>

    <xsl:template match="* | p:identity | p:xslt | metaschema:*" mode="edges">
        <xsl:apply-templates mode="edges"/>
        <xsl:if test="not(p:input/@port = 'source')">
            <xsl:call-template name="write-implicit-source"/>
        </xsl:if>
    </xsl:template>

    <xsl:template mode="edges" match="p:sink" priority="5"/>
    
    <xsl:template mode="edges" match="p:input | p:output" priority="20">
        <xsl:apply-templates mode="edges"/>
    </xsl:template>
    
    <xsl:template mode="edges" match="p:stylesheet | p:with-param"/>
    
    <!-- while XSLTs are treated as subpipelines don't show this import -->
    <xsl:template mode="edges" match="p:input[@port='stylesheet']/p:document" priority="21"/>
    
    <xsl:template mode="edges" match="p:input/p:document">
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates select="." mode="write-key"/>
        <xsl:text> --> </xsl:text>
        <xsl:apply-templates mode="write-key" select="../.."/>
    </xsl:template>
    
    <xsl:template mode="edges" match="p:input[@port='source']/p:pipe">
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates select="key('step-by-name',@step)" mode="write-key"/>
        <xsl:text> --> </xsl:text>
        <xsl:apply-templates mode="write-key" select="../.."/>
    </xsl:template>
    
    <xsl:template mode="edges" match="/*/p:input | p:serialization | p:import" priority="99"/>
    
    <xsl:template match="*" mode="edges"/>
    <!--<xsl:template match="p:input" mode="edges">
        <xsl:text>&#xA;</xsl:text>
        <xsl:apply-templates mode="write-key"/>
        <xsl:text> -\-> </xsl:text>
        <xsl:apply-templates select=".." mode="write-key"/>
    </xsl:template>-->

    <xsl:template name="write-implicit-source">
        <xsl:text>&#xA;</xsl:text>
        <xsl:variable name="previous-step" select="preceding-sibling::*[not(self::p:serialization|self::p:import|self::p:output|self::p:input[not(@primary='true')])][1]"/>
        <xsl:apply-templates mode="write-key" select="$previous-step"/>
        <xsl:text> --> </xsl:text>
        <xsl:apply-templates select="." mode="write-key"/>
    </xsl:template>


    <xsl:template mode="write-key" match="*" priority="-0.5">
        <xsl:value-of select="translate(local-name(),'-','_')"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="translate((@name|@port),'-','_')"/>
        <xsl:text>_id</xsl:text>
        <xsl:number count="*" level="any" format="00001"/>
    </xsl:template>
   
    <xsl:template mode="write-key" match="p:pipe">
        <xsl:apply-templates mode="write-key" select="key('step-by-name',@step)"/>
    </xsl:template>
    
    
    <xsl:template mode="write-label" match="p:input">
        <xsl:text> Input port '</xsl:text>
        <xsl:value-of select="@port"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:output">
        <xsl:text> Output port '</xsl:text>
        <xsl:value-of select="@port"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:document">
        <xsl:text> Document '</xsl:text>
        <xsl:value-of select="@href"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:identity">
        <xsl:text> IDENTITY '</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:xslt">
        <xsl:text>XSLT Transformation '</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="p:xslt/p:input[@port='stylesheet'][p:document]">
        <xsl:text>stylesheet '</xsl:text>
        <xsl:apply-templates select="p:document/@href"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="*[@name|@port]" priority="-0.1">
        <xsl:text> </xsl:text>
        <xsl:value-of select="translate(local-name(),$lower,$upper)"/><xsl:text> '</xsl:text>
        <xsl:value-of select="@name | @port"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
    
    <xsl:template mode="write-label" match="*">
        <xsl:text> </xsl:text>
        <xsl:value-of select="translate(local-name(),$lower,$upper)"/>
    </xsl:template>
    
    
</xsl:stylesheet>
