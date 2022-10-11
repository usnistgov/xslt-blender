<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="1.0">
    
    <xsl:template match="projects">
        <div class="project-directory">
            <xsl:apply-templates/>
        </div>
        <div style="margin: auto 0em; text-align: center; margin-top: 1em">
        <button id="main-edit-directory" onclick="window.location.href='https://github.com/usnistgov/xslt-blender/tree/main/directory.xml'">Edit the directory</button>
      </div>

    </xsl:template>
    
    <xsl:template match="project">
        <section class="project {@status}">
            <xsl:for-each select="@entry">
                <button onclick="window.open('{ string(.) }');" class="jump">Open</button>    
            </xsl:for-each>
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    
    <xsl:template match="project/name">
        <h3>
            <xsl:apply-templates/>
            <xsl:if test="parent::project/@status='planned'">&#xA0;<small>(planned)</small></xsl:if>
        </h3>
    </xsl:template>
    
    <xsl:template match="project/line">
        <p class="highlight">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="project/description">
        <section class="description">
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    
    <xsl:template match="link">
        <p class="link">
            <a href="{@href}" class="external">
                <xsl:apply-templates/>
            </a>
        </p>
    </xsl:template>
    
    <xsl:template match="p | ul | ol">
        <xsl:apply-templates select="." mode="cast-to-html"/>
    </xsl:template>
    
    <xsl:template match="*" mode="cast-to-html">
        <xsl:element name="{ local-name() }" namespace="http://www.w3.org/1999/xhtml">
            <xsl:copy-of select="attribute::*"/>
            <xsl:apply-templates mode="cast-to-html"/>
        </xsl:element>
    </xsl:template>
    
    
</xsl:stylesheet>