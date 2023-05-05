<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="1.0">
    
    <xsl:import href="sts-view10.xsl"/>

    <!--<xsl:output indent="true"/>-->
    
    <xsl:template match="front"/>
    
    <!--
    ideas:
    
    x figures and tables
    ? footnotes
    References - colors?
      summary list of elements by type found in mixed-citation
   
    external links
    x internal cross-references
    
    -->
    <xsl:template match="/*">
        <div id="checkerReport">
            <h1>Checker report</h1>
            <details class="outliner reportView">
                <summary>Outline</summary>
                <xsl:call-template name="outline-description"/>
                <xsl:apply-templates select="//body | //back" mode="outliner"/>
            </details>
            <details class="reportView">
                <summary>Questionable cross-references (<tt class="tag">xref</tt>)</summary>
                <div class="xrefCheck">
                    <!--<xsl:call-template name="report-broken-xrefs"/>-->
                    <xsl:apply-templates select="/descendant::xref[not(@ref-type)][1]" mode="checkxref-group">
                        <xsl:with-param name="us" select="/descendant::xref[not(@ref-type)]"/>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="$xref-groupers" mode="checkxref-group">
                        <xsl:sort select="@ref-type"/>
                    </xsl:apply-templates>
                </div>
            </details>
            <xsl:if test="//fig">
                <details class="reportView">
                    <summary>Figures (<tt class="tag">fig</tt>)</summary>
                    <xsl:apply-templates select="//fig" mode="report"/>
                </details>
            </xsl:if>
            <xsl:if test="//table-wrap | //table[not(ancestor::table-wrap)]">
                <details class="reportView">
                    <summary>Tables (<tt class="tag">table</tt> with <tt>table-wrap</tt>)</summary>
                    <xsl:apply-templates select="//table-wrap | //table[not(ancestor::table-wrap)]" mode="report"/>
                </details>
            </xsl:if>
            <xsl:if test="//ref">
                <details class="reportView">
                    <summary>References (<tt class="tag">ref</tt>)</summary>
                    <xsl:apply-templates select="//ref" mode="report"/>
                </details>
            </xsl:if>
            <xsl:if test="//ext-link[not(ancestor::ref)]">
                <details class="reportView">
                    <summary>External links outside references (<tt class="tag">ext-link[not(ancestor::ref)]</tt>)</summary>
                    <div class="view">
                    <xsl:apply-templates select="//ext-link[not(ancestor::ref)]" mode="report"/>
                    </div>
                </details>
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template mode="report" match="*">
        <div class="report">
            <xsl:call-template name="xpathme"/>
            <div class="view">
                <xsl:apply-templates select="."/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template mode="report" match="ref">
        <div class="report">
            <span class="attrs"><xsl:apply-templates select="@*" mode="inline"/></span>
            <xsl:call-template name="xpathme"/>
            <div class="view">
                <xsl:apply-templates select="."/>
            </div>
        </div>
    </xsl:template>
    
    
    
    
    <xsl:template match="graphic">
        <div class="graphicBox">
            <xsl:text>Graphic</xsl:text>
            <xsl:apply-templates select="@*"/>
        </div>
    </xsl:template>
    
    <xsl:template match="table[not(ancestor::table-wrap)]">
        <details class="freeTableBox">
            <summary>
            <xsl:text>Table</xsl:text>
            </summary>
            <xsl:apply-imports/>
        </details>
    </xsl:template>
    
    <xsl:template match="table-wrap">
        <details>
            <xsl:apply-templates select="@*"/>            
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="." mode="sec.head"/>
            <xsl:apply-templates/>
        </details>
    </xsl:template>
    
    <!--<xsl:template name="report-broken-xrefs">
        <xsl:variable name="brokens" select="//xref[not(key('by-id',@rid))]"/>
        <xsl:if test="$brokens">
        <details class="xrefGroup">
            <summary>Broken <tt>xref/@rid</tt>
                <xsl:text> </xsl:text>
                <xsl:value-of select="concat(' (', count($brokens), ')')"/>
            </summary>
            <xsl:apply-templates select="$brokens" mode="checkxref"/>
        </details>
        </xsl:if>
    </xsl:template>-->
    
    <xsl:key name="xref-by-reftype" match="xref" use="@ref-type"/>
    
    <xsl:variable name="xref-groupers" select="/descendant::xref[generate-id(.) = generate-id(key('xref-by-reftype',@ref-type)[1])]"/>
    
    <xsl:template mode="checkxref-group" match="xref">
        <xsl:param name="us" select="key('xref-by-reftype',@ref-type)"/>
        <xsl:variable name="mine">
            <xsl:apply-templates select="$us" mode="checkxref"/>
        </xsl:variable>
        <xsl:if test="normalize-space(string($mine))">
        <details class="xrefGroup">
            <summary>
                <tt>@ref-type</tt>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@ref-type"/>
                <xsl:if test="not(normalize-space(string(@ref-type)))">[NONE]</xsl:if>
            </summary>
            <xsl:copy-of select="$mine"/>
        </details>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="outline-description">
        <p class="outlineDescription">Showing anything with <tt class="tag">child::label</tt> or <tt class="tag"
                >child::title</tt> except <tt class="tag">fn</tt>, <tt class="tag">ref</tt> and <tt
                class="tag">list-item</tt>.</p>
    </xsl:template>
    
    <xsl:template match="*[.//title or .//label]" mode="outliner">
        <xsl:variable name="further">
            <xsl:apply-templates mode="outliner"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="normalize-space(string($further))">
                <details class="outline { local-name() }">
                    <summary>
                        <xsl:apply-templates select="label" mode="inline"/>
                        <xsl:apply-templates select="@id" mode="inline"/>
                        <xsl:apply-templates select="title" mode="inline"/>
                        <xsl:call-template name="xpathme"/>
                    </summary>
                    <xsl:copy-of select="$further"/>
                </details>
            </xsl:when>
            <xsl:when test="title | label">
                <div class="outline { local-name() }">
                    <xsl:apply-templates select="title | label" mode="inline"/>
                    <xsl:call-template name="xpathme"/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template mode="outliner" match="body | back" priority="101">
        <div class="outline { local-name() }">
            <xsl:apply-templates mode="outliner"/>
        </div>
    </xsl:template> 
    
    <xsl:template mode="outliner" match="list-item" priority="9">
        <xsl:apply-templates mode="outliner"/>
    </xsl:template>
    
    <xsl:template mode="outliner" match="ref | fn" priority="9"/>
    
    <xsl:template match="* | text()" mode="outliner"/>
    
    <xsl:template mode="inline" match="*">
        <span class="{ local-name() } inline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template mode="inline" match="@*">
        <span class="{ local-name() } attribute inline" data-gi="{local-name()}">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    
    <xsl:template name="xpathme">
        <span class="xpath">
            <tt class="c" onclick="clipboardCopy(this);">
              <xsl:apply-templates select="." mode="path"/>
            </tt>
        </span>
    </xsl:template>
    
    <xsl:template match="/" mode="path"/>
    
    <xsl:template match="@*" mode="path">
        <xsl:apply-templates select=".." mode="path"/>
        <xsl:text>/@</xsl:text>
        <xsl:value-of select="name()"/>
    </xsl:template>
    
    <!--<xsl:template mode="path" match="*[@id]" priority="1001">
        <xsl:apply-templates select=".." mode="path"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="name()"/>
    </xsl:template>-->
    
    <xsl:template mode="path" match="*">
        <xsl:apply-templates select=".." mode="path"/>
        <xsl:variable name="myname" select="name()"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:if test="count(../child::*[name() = $myname]) > 1">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(. | preceding-sibling::*[name() = $myname])"/>
            <xsl:text>]</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template mode="path" match="comment()">
        <xsl:apply-templates select=".." mode="path"/>
        <xsl:text>/comment()</xsl:text>
        <xsl:if test="not(count(../comment()) = 1)">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(. | preceding-sibling::comment())"/>
            <xsl:text>]</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template mode="path" match="processing-instruction()">
        <xsl:apply-templates select=".." mode="path"/>
        <xsl:text>/comment()</xsl:text>
        <xsl:if test="not(count(../processing-instruction()) = 1)">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(. | preceding-sibling::processing-instruction())"/>
            <xsl:text>]</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!--<xsl:template mode="checkxref" match="*[not(.//xref)]"/>
    
    <xsl:template mode="checkxref" match="text()">
        <xsl:if test="../xref">
            <xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*" mode="checkxref">
        <div class="xrefmap { local-name() }" data-tag="{ local-name() }">
            <xsl:apply-templates mode="checkxref"/>
        </div>
    </xsl:template>-->
    
    <xsl:key name="by-id" match="*[@id]" use="@id"/>
    
    <xsl:template priority="101" match="xref" mode="checkxref">
        <xsl:variable name="target" select="key('by-id',@rid)"/>
        <xsl:variable name="targetType">
          <xsl:apply-templates select="$target" mode="targetType"/>
        </xsl:variable>
        <xsl:if test="not($target) or not(@ref-type = $targetType)">
            <p class="xref">
                <span class="xrefContent">
                    <xsl:apply-templates/>
                </span>
                <span class="xrefRid">
                    <xsl:value-of select="@rid"/>
                </span>
                <xsl:choose>
                    <xsl:when test="not(normalize-space(string(@rid)))">
                        <span class="error"><tt class="xpath">@rid</tt> is missing or empty</span>
                    </xsl:when>
                    <xsl:when test="contains(normalize-space(string(@rid)), ' ')">
                        <span class="warning">CHECKER DOES NOT SUPPORT MULTIPLE <tt class="xpath"
                                >@rid</tt></span>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="not(key('by-id', @rid))">
                                <span class="error"><tt class="xpath">@rid</tt> target is not
                                    found</span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="xrefType">
                                    <xsl:value-of select="@ref-type"/>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="not(normalize-space(string(@ref-type)))">
                        <span class="error"><tt class="xpath">xref/@ref-type</tt> is not given</span>
                    </xsl:when>
                    <xsl:when test="not(@ref-type = $targetType)">
                        <span class="error"><tt class="xpath">xref/@ref-type</tt> is <xsl:value-of
                                select="@ref-type"/>; expecting <xsl:value-of select="$targetType"
                            /></span>
                    </xsl:when>
                </xsl:choose>

                <xsl:call-template name="xpathme"/>
            </p>
        </xsl:if>
    </xsl:template>
    
    <xsl:template mode="targetType" match="*">
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
    <xsl:template mode="targetType" match="ref">bibr</xsl:template>
    
    <xsl:template mode="targetType" match="table-wrap">table</xsl:template>
    
    
    
</xsl:stylesheet>