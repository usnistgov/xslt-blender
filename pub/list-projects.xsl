<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="1.0">
    
    
    <!--XSLT 1.0 stylesheet suitable for browser use -->
    
    <xsl:template match="/*">
        <html lang="en">
            <head>
                <title>XSLT Blender Demonstrations</title>
                <link href="projects-html.css" rel="stylesheet" />
                <xsl:call-template name="script"/>
            </head>
            <body>
                <h1>XSLT Blender Demonstrations</h1>
                <xsl:apply-templates/>
            </body>
        </html>
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
            <a href="{@href}">
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
    
    <!--<xsl:template match="*[.='View Source']" mode="cast-to-html">
        <span onclick="showSource('{ancestor::project/@entry}')">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->
        
    <xsl:template name="script">
        <!--<script>
            function showSource(relPath) {
              window.location = showSourceHREF(relPath);
              // console.log(showSourceHREF(relPath));
            }
            
            function showSourceHREF(relPath) {
              thereURL = new URL(relPath,document.location);
              return "view-source:" + thereURL.href;
            }
        </script>-->
    </xsl:template>
    
</xsl:stylesheet>