<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="1.0"
    xmlns:mml="http://www.w3.org/1998/Math/MathML">
    
    <xsl:import href="sts-view10.xsl"/>


    <!--<xsl:output indent="true"/>-->

    <xsl:template match="/*">
        <div id="checkerReport">
            <h1>Checker report</h1>
            <details class="outliner reportView">
                <summary>Outline</summary>
                <xsl:call-template name="outline-description"/>
                <xsl:apply-templates select="child::*" mode="outliner"/>
            </details>
            <xsl:variable name="checkResults">
                        <xsl:apply-templates select="/descendant::xref[not(@ref-type)][1]" mode="checkxref-group">
                            <xsl:with-param name="us" select="/descendant::xref[not(@ref-type)]"/>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="$xref-groupers" mode="checkxref-group">
                            <xsl:sort select="@ref-type"/>
                        </xsl:apply-templates>
                    </xsl:variable>
            <details class="reportView">
                <summary>Questionable cross-references (<tt class="xpath">xref</tt>)</summary>
                <div class="xrefCheck">
                    <!--<xsl:call-template name="report-broken-xrefs"/>-->
                    <xsl:copy-of select="$checkResults"/>
                    <xsl:if test="not(normalize-space(string($checkResults)))">
                        <xsl:variable name="xrefs" select="//xref"/>
                        <xsl:choose>
                            <xsl:when test="boolean($xrefs[2])">
                                <p>
                                    <b>Congratulations</b>
                                    <xsl:text>, all </xsl:text>
                                    <xsl:value-of select="count(//xref)"/>
                                    <xsl:text> cross-references check out. </xsl:text>
                                    <span class="xpath">
                                        <tt class="c" onclick="clipboardCopy(this);">/descendant::xref</tt>
                                    </span>
                                </p>
                            </xsl:when>
                            <xsl:when test="boolean($xrefs[1])">
                                <p>The single cross-reference checks out. </p>
                                <xsl:apply-templates select="$xrefs[1]" mode="xpathme"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <p>No cross-references to check.</p>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </div>
            </details>
            <xsl:if test="//mml:math">
                <details class="reportView">
                    <summary>MathML</summary>
                    <div class="view">
                        <xsl:apply-templates select="//mml:math/parent::*" mode="report"/>
                    </div>
                </details>
            </xsl:if>
            <xsl:if test="//fig">
                <details class="reportView">
                    <summary>Figures (<tt class="tag">fig</tt>)</summary>
                    <div class="view">
                        <xsl:apply-templates select="//fig" mode="report"/>
                    </div>
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

    <!-- This XSLT doesn't check the metadata - opportunity for extension -->
    <xsl:template match="front"/>
    
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
        <xsl:variable name="outline-text">
            <xsl:apply-templates select="label" mode="inline"/>
            <xsl:apply-templates select="@id" mode="inline"/>
            <xsl:apply-templates select="title" mode="inline"/>
            <xsl:call-template name="xpathme"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="normalize-space(string($further))">
                <details class="outline { local-name() }">
                    <summary>
                        <xsl:copy-of select="$outline-text"/>
                    </summary>
                    <xsl:copy-of select="$further"/>
                </details>
            </xsl:when>
            <xsl:when test="title | label">
                <div class="outline { local-name() }">
                    <xsl:copy-of select="$outline-text"/>
                </div>
            </xsl:when>
        </xsl:choose>
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
    
    <xsl:template name="xpathme" mode="xpathme" match="*">
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