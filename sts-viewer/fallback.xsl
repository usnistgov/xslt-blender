<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="1.0">

    <xsl:template match="/*">
        <xsl:if test="not(self::standard)">
            
        <div class="warn">
            <p>Warning: seeing a document named <code><xsl:value-of  select="local-name(.)"/></code> ... this tool is designed and tested for STS <code>standard</code> documents (in no namespace).</p>
        </div>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--without a better rule, make a div -->
    <xsl:template priority="-0.4" match="*">
        <div>
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
<!--Elements appearing in elements permitting mixed content should map to span unless a better match
    intervenes -->
    <xsl:template priority="-0.1" match="abbrev/* | access-date/* | accrediting-organization/* | addr-line/* | aff/* | alt-text/* | alt-title/* | annex-type/* | article-id/* | article-title/* | attrib/* | authorization/* | award-id/* | bold/* | chapter-title/* | chem-struct/* | city/* | code/* | collab/* | comm-ref/* | comment/* | compl/* | compound-kwd-part/* | compound-subject-part/* | conf-acronym/* | conf-date/* | conf-loc/* | conf-name/* | conf-num/* | conf-sponsor/* | conf-theme/* | content-language/* | contrib-id/* | copyright-holder/* | copyright-statement/* | copyright-year/* | corresp/* | country/* | data-title/* | date-in-citation/* | day/* | def-head/* | degrees/* | disp-formula/* | doc-number/* | doc-ref/* | doc-type/* | edition/* | elocation-id/* | email/* | era/* | etal/* | ext-link/* | fax/* | fixed-case/* | fpage/* | full/* | funding-source/* | funding-statement/* | given-names/* | glyph-data/* | gov/* | ics/* | ics-desc/* | inline-formula/* | inline-supplementary-material/* | institution/* | institution-id/* | intro/* | isbn/* | issn/* | issn-l/* | issue/* | issue-id/* | issue-part/* | issue-sponsor/* | issue-title/* | italic/* | journal-id/* | kwd/* | label/* | language/* | license-p/* | long-desc/* | lpage/* | main/* | meta-date/* | meta-name/* | meta-value/* | mixed-citation/* | monospace/* | month/* | named-content/* | nav-pointer/* | nav-pointer-group/* | num/* | object-id/* | on-behalf-of/* | originator/* | overline/* | p/* | page-range/* | part-number/* | part-of-speech/* | part-title/* | patent/* | person-group/* | phone/* | postal-code/* | prefix/* | preformat/* | price/* | principal-award-recipient/* | principal-investigator/* | product/* | proj-id/* | pronunciation/* | pub-date/* | pub-id/* | publisher-loc/* | publisher-name/* | rb/* | related-article/* | related-object/* | related-term/* | release-date/* | release-version/* | release-version-id/* | role/* | roman/* | rp/* | rt/* | sans-serif/* | sc/* | sdo/* | season/* | secretariat/* | see/* | see-also/* | see-also-entry/* | see-entry/* | self-uri/* | series/* | series-text/* | series-title/* | sig/* | sig-block/* | size/* | source/* | speaker/* | state/* | std/* | std-id/* | std-org-abbrev/* | std-org-loc/* | std-org-name/* | std-organization/* | std-ref/* | strike/* | string-conf/* | string-date/* | string-name/* | styled-content/* | sub/* | subject/* | subtitle/* | suffix/* | sup/* | suppl-number/* | suppl-type/* | suppl-version/* | supplement/* | surname/* | target/* | td/* | term/* | term-head/* | term-source/* | tex-math/* | textual-form/* | th/* | time-stamp/* | title/* | trans-source/* | trans-subtitle/* | trans-title/* | underline/* | unstructured-kwd-group/* | uri/* | urn/* | verse-line/* | version/* | volume/* | volume-id/* | volume-series/* | wi-number/* | x/* | xref/* | year/*">
        <span>
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- The following are matched by name to produce divs irrespective of whether appearing in mixed contents -->
    <xsl:template priority="0" match="address | aff-alternatives | alternatives | annotation | anonymous | array | author-comment | bio | boxed-text | break | chem-struct-wrap | citation-alternatives | collab-alternatives | contrib-group | date | def | def-list | disp-formula-group | disp-quote | element-citation | fig | fig-group | fn | graphic | hr | index-term | index-term-range-end | inline-graphic | institution-wrap | list | media | milestone-end | milestone-start | name | name-alternatives | non-normative-example | non-normative-note | normative-example | normative-note | notes-group | open-access | permissions | private-char | ref-list | ruby | speech | statement | std-id-group | supplementary-material | table-wrap | table-wrap-group | verse-group">
        <div>
            <xsl:call-template name="add.class"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:include href="sts-tags-and-names.xsl"/>
    
    <!--<xsl:template mode="formal-name" match="*"/>-->
    
    <xsl:template name="add.class">
        <xsl:variable name="gi" select="local-name()"/>
        <xsl:variable name="fullname">
            <xsl:apply-templates select="." mode="formal-name"/>
        </xsl:variable>
        <xsl:variable name="classes">
            <xsl:apply-templates select="." mode="class"/>
        </xsl:variable>
        <xsl:attribute name="data-tag">
            <xsl:choose>
                <xsl:when test="normalize-space($fullname)">
                    <xsl:value-of select="$fullname"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$gi"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="class">
            <xsl:value-of select="normalize-space($classes)"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- mode "class" generates values to assign to class - use next-match to cascade to this -->
    <xsl:template mode="class" match="*">
        <xsl:text>labeled sts_</xsl:text>
        <xsl:value-of select="local-name()"/>
    </xsl:template>
    
    <!-- @id propagates in default traversal -->
    <xsl:template match="@id">
        <xsl:copy-of select="id"/>
    </xsl:template>
    
    <!-- Attributes in default traversal -->
    <xsl:template match="@*"/>
    
</xsl:stylesheet>