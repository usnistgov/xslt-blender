<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xlink"
    version="1.0">
    
<!--      
      STS Viewer to do
      
      o footnotes as 'aside'
      o pretty table css
      o special handling for 'overview' sec?
      
      OSCAL->STS to do
      o Link from family header to Table C
      o check withdrawn controls - Table C but also the primary listing
      AC-3(1), AC-3(6), AT-3(4) (moved to), AU-15
      
      
      
      -->
    <xsl:import href="fallback.xsl"/>

    <xsl:template match="sec/title | sec/label" priority="49"/>
    
    <xsl:template match="app/title | app/label" priority="49"/>
    
    <xsl:template match="table-wrap/title | table-wrap/label" priority="49"/>
    
    <xsl:template match="@id">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="title">
        <h4>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </h4>
    </xsl:template>
    
    <xsl:template priority="5" match="std/title">
        <span>
            <xsl:apply-templates select="@*"/>            
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:param name="fn-label"/>
        <xsl:apply-templates select="descendant::fn" mode="fn-aside"/>
        <p>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>            
        </p>
    </xsl:template>
    
    <xsl:template match="p//fn/label"/>
    
    <xsl:template match="p//fn/p[1]">
        <xsl:param name="fn-label">
            <xsl:apply-templates select="../label"/>
        </xsl:param>
        <p>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:if test="$fn-label">
                <span class="fn-label">
                    <xsl:value-of select="$fn-label"/>
                </span>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="sec | app | table-wrap | ref-list">
        <details>
            <xsl:if test="@sec-type='control-enhancements'">
                <xsl:attribute name="open">open</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="." mode="sec.head"/>
            <xsl:apply-templates/>
        </details>
    </xsl:template>
    
    <!--<xsl:template match="sec[@sec-type='assessment-objective']"/>
    <xsl:template match="sec[@sec-type='assessment-methods']"/>
    
    <xsl:template match="sec[@sec-type='statement'] | sec[@sec-type='related-controls'] | sec[@sec-type='references']">
        <div>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="." mode="sec.head"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>-->
    
    <xsl:template match="standard | adoption">
        <section>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="." mode="page.head"/>
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    
    
    <xsl:template match="standard" mode="page.head">
        <header>
            <xsl:for-each select="child::front/std-doc-meta/title-wrap/*[1] | child::front[1]/std-meta/title-wrap/*[1]">
                <h1>
                    <xsl:apply-templates mode="page.head"/>
                </h1>
            </xsl:for-each>
        </header>
    </xsl:template>
    
    <xsl:template match="body">
        <section>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    
    <xsl:template match="adoption-front | front | back">
        <section>
            <xsl:apply-templates select="@*"/>
            <xsl:call-template name="add.class"/>
            <details>
                <xsl:apply-templates select="." mode="sec.head"/>
                <xsl:apply-templates/>
            </details>
        </section>
    </xsl:template>
    
    <xsl:template match="adoption-front" mode="sec.head">
        <summary><span class="gen">Adoption</span></summary>
    </xsl:template>
    
    <xsl:template match="front" mode="sec.head">
        <summary><span class="gen">Front matter</span></summary>
    </xsl:template>
    
    <xsl:template match="back" mode="sec.head">
        <summary><span class="gen">Back matter</span></summary>
    </xsl:template>
    
    <xsl:template match="ref-list" mode="sec.head">
        <summary><span class="gen">References</span></summary>
    </xsl:template>
    
    <xsl:template match="sec | app | table-wrap" mode="sec.head">
        <summary>
            <xsl:apply-templates mode="sec.head" select="label | title | caption"/>
        </summary>
    </xsl:template>
    
    <xsl:template match="caption" mode="sec.head">
        <!-- emitting a colon when both title and label are given -->
        <xsl:for-each select="child::title/parent::caption/../label">
            <!-- add a colon if no colon or period is found in the value -->
            <xsl:call-template name="punctuate-label"/>
        </xsl:for-each>
        <xsl:apply-templates select="title" mode="sec.head"/>
    </xsl:template>
    
    <xsl:template name="punctuate-label">
        <xsl:choose>
            <!-- if numeric (only), punctuate with period -->
            <xsl:when test="translate(string(.), '0123456789', '') = ''">
                <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <!-- if not containing a colon or period, punctuate with a colon -->
                <xsl:if test="translate(string(.), ':.', '') = string(.)">
                    <xsl:text>:</xsl:text>
                </xsl:if>        
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <!-- picked up in sec.head mode -->    
    <xsl:template match="table-wrap/caption/title | app/title"/>
    
    <xsl:template match="label | title" mode="sec.head">
        <xsl:for-each select="preceding-sibling::label">
            <xsl:call-template name="punctuate-label"/>
        </xsl:for-each>
        <span>
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="break">
        <br>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
        </br>
    </xsl:template>
    
    <xsl:template match="named-content">
        <span>
            <xsl:apply-templates select="@*"/>            
            <xsl:attribute name="title">
                <xsl:value-of select="@content-type"/>
            </xsl:attribute>
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="bold">
        <b>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </b>
    </xsl:template>
    
    <xsl:template match="italic">
        <i>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    
    <xsl:template match="sub">
        <sub>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </sub>
    </xsl:template>
    
    <xsl:template match="sup">
        <sup>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    
    <xsl:key name="fn-by-id" match="fn" use="@id"/>
    
    <!-- fn xrefs to sibling fn elements are not displayed   -->
    <xsl:template match="xref[@ref-type='fn'][count(key('fn-by-id',@rid) | ../fn) = count(../fn)]"/>
        
    
    <!-- For now -->
    <xsl:template match="xref">
        <a onclick="javascript:viewSection('{@rid}');" target="internal">
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <!-- For now -->
    <xsl:template match="ext-link">
        <a href="{@xlink:href}" target="external">
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="ext-link/@xlink:href">
        <xsl:attribute name="href">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="p//fn">
        <xsl:variable name="fnno">
            <xsl:number level="any"/>
        </xsl:variable>
        <sup class="fn-label" id="fnref-{ $fnno }" onclick="javascript:highlightAside('{ $fnno }')">
            <xsl:value-of select="$fnno"/>
        </sup>    
        </xsl:template>
    
    <xsl:template match="p//fn" mode="fn-aside">
        <xsl:variable name="fnno">
            <xsl:number level="any"/>
        </xsl:variable>
        <aside id="fn-{ $fnno }" class="inline-footnote" onclick="javascript:highlightAside('{ $fnno }')">
            <xsl:apply-templates>
                <xsl:with-param name="fn-label" select="$fnno"/>
            </xsl:apply-templates>
        </aside>
    </xsl:template>
    
    
    <xsl:template match="underline">
        <u>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    
    <xsl:template match="list[not(list-item/label)]">
        <div>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="child::*[not(self::list-item)]"/>
            <ul>
                <xsl:apply-templates select="list-item"/>
            </ul>
        </div>
    </xsl:template>
    
    <xsl:template match="list[list-item/label]/list-item">
        <div>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="child::label"/>
            <div>
                <xsl:apply-templates select="child::*[not(self::label)]"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="list-item">
        <li>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="child::*[not(self::label)]"/>
        </li>
    </xsl:template>

    <xsl:template match="preformat">
        <pre>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates/>
        </pre>
    </xsl:template>
    
    <!--
    table | col | thead | tr | th | tbody | td
    -->
    
    <xsl:template match="table | col | thead | tr | th | tbody | td">
        <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*" mode="table.copy"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@content-type" mode="table.copy"/>
    
    <xsl:template match="table[@content-type='control-matrix']//@content-type" mode="table.copy">
        <xsl:attribute name="class">
            <xsl:value-of select="."/>
            <xsl:text> sts_</xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template priority="2" match="@content-type[contains(.,'-withdrawn')]" mode="table.copy">
            <xsl:attribute name="class">withdrawn</xsl:attribute>
     </xsl:template>
            

    <xsl:template match="@*" mode="table.copy">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="table-wrap-group | app-group">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="app-group">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ref/*">
        <div>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:if test="not(preceding-sibling::*[not(self::label)])">
              <xsl:apply-templates select="../label" mode="run.in"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template priority="12" match="ref/label"/>
        
    <xsl:template match="ref/label" mode="run.in">
        <span class="run-in">
            <xsl:apply-templates/>
        </span>
        <xsl:text> </xsl:text>
    </xsl:template>

    <!-- overriding fallback class 'labeled' for things with titles -->
    <xsl:template match="*[title]" mode="class">
        <xsl:text>titled sts_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
<!-- add anything here that shouldn't be marked 'labeled' -->
    <xsl:template priority="2" match="app-group | table-wrap | table-wrap-group | ref-list | ref | def-list | def-item | term | def | term-sec | term-display | preformat" mode="class">
        <xsl:text>sts_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
    <xsl:template priority="5" match="normative-note |  non-normative-note | normative-example | non-normative-example" mode="class">
        <xsl:text>boxed labeled sts_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
    <xsl:template priority="5" match="std | mixed-citation | element-citation | nlm-citation" mode="class">
        <xsl:text>citation sts_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
    <xsl:template match="mml:*"  xmlns:mml="http://www.w3.org/1998/Math/MathML">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template mode="class" match="p//*" priority="-0.3">
        <xsl:text>sts_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
</xsl:stylesheet>