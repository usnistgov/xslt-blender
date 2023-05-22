<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns="http://www.w3.org/1999/xhtml" xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0">

  <xsl:template match="oscal:catalog">
    <div class="catalog">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="oscal:title">
    <h2 class="title">
      <xsl:apply-templates/>
    </h2>
  </xsl:template>

  <xsl:template match="oscal:group">
    <section class="group">
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <xsl:key name="assignment" match="oscal:param" use="@id"/>

  <xsl:template match="oscal:control | oscal:part">
    <div class="{local-name()} {@class}">
      <xsl:copy-of select="@id"/>
      <xsl:call-template name="make-title">
        <xsl:with-param name="runins" select="oscal:prop[@name = 'label']"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Picked up in parent -->
  <xsl:template match="oscal:control/oscal:title"/>

  <xsl:template name="make-title">
    <xsl:param name="runins" select="/.."/>
    <h3>
      <xsl:apply-templates select="$runins" mode="run-in"/>
      <xsl:for-each select="@class">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>] </xsl:text>
      </xsl:for-each>

      <xsl:for-each select="oscal:title">
        <xsl:apply-templates/>
      </xsl:for-each>
    </h3>
  </xsl:template>

  <xsl:template match="oscal:prop" mode="run-in">
    <span class="run-in subst">
      <xsl:value-of select="@value"/>
    </span>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="oscal:param">
    <p class="param">
      <span class="subst">
        <xsl:for-each select="@id">
          <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:text>: </xsl:text>
      </span>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="oscal:prop">
    <p class="prop {@name}">
      <span class="subst">
        <xsl:value-of select="@name"/>
        <xsl:text>: </xsl:text>
      </span>
      <xsl:apply-templates select="@value"/>
    </p>
  </xsl:template>

  <xsl:template match="oscal:p">
    <p class="p">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="oscal:insert" priority="101">
    <xsl:variable name="param-id" select="@param-id"/>
    <span class="insert">
      <xsl:variable name="param" select="key('assignment',@id-ref)"/>
      <xsl:apply-templates select="$param" mode="param-insert"/>
        <xsl:if test="not($param)"><i>broken parameter reference</i></xsl:if>
    </span>
  </xsl:template>

  <xsl:template mode="param-insert" match="oscal:param">
    <xsl:apply-templates mode="param-insert" select="oscal:value"/>
  </xsl:template>
  
  <xsl:template mode="param-insert" match="oscal:param[not(oscal:value)]">
    <xsl:apply-templates mode="param-insert" select="oscal:label"/>
  </xsl:template>
  
  
  <xsl:template match="oscal:ol">
    <ol class="ol">
      <xsl:apply-templates/>
    </ol>
  </xsl:template>
  
  <xsl:template match="oscal:li">
    <li class="li">
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="oscal:link">
    <p class="link">
      <a class="xref">
        <xsl:copy-of select="@href"/>
        <xsl:apply-templates/>
      </a>
    </p>
  </xsl:template>

  <xsl:template match="oscal:ref">
    <div class="ref">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="oscal:table | oscal:p | oscal:li | oscal:ul | oscal:pre |
    oscal:table//* | oscal:p//* | oscal:li//* | oscal:pre//*">
    <xsl:element name="{ local-name()}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
