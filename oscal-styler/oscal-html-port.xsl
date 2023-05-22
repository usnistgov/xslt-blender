<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns="http://www.w3.org/1999/xhtml" xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0">

  <xsl:template match="/">
    <main class="oscal-port">
      <xsl:apply-templates/>
    </main>
  </xsl:template>

  <xsl:template match="*">
    <xsl:call-template name="port"/>
  </xsl:template>
  
  <xsl:template name="port">
    <xsl:element name="oscal-{ local-name() }" namespace="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="attribute::*"/>
      <xsl:attribute name="class">
        <xsl:value-of select="local-name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="@*">
    <xsl:attribute name="data-{ local-name() }">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@id">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="@uuid">
    <xsl:attribute name="data-{ local-name() }">
      <xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:attribute name="id">
      <xsl:text>uuid_</xsl:text>
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="oscal:prop">
    <oscal-prop>
      <xsl:apply-templates select="attribute::*"/>
      <!-- forcing this to appear after attributes -->
      <xsl:for-each select="@value">
        <oscal-value>
          <xsl:value-of select="."/>
        </oscal-value>
      </xsl:for-each>
      <xsl:apply-templates/>
    </oscal-prop>
  </xsl:template>
  
  <xsl:template match="oscal:p | oscal:table | oscal:pre | oscal:ul | oscal:ol |
    oscal:p//* | oscal:table//* | oscal:pre//* | oscal:ul//* | oscal:ol//* |
    oscal:i | oscal:em | oscal:strong | oscal:b | oscal:q | oscal:a | oscal:code | oscal:img | oscal:sub | oscal:sup" >
      <xsl:element name="{ local-name() }" namespace="http://www.w3.org/1999/xhtml">
        <xsl:copy-of select="attribute::*"/>
        <xsl:apply-templates/>
      </xsl:element>
  </xsl:template>
  
  <xsl:template match="oscal:insert" priority="101">
    <ins>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="@id-ref"/>
      <!-- traversal to retrieve parameter value or label can go here -->
    </ins>
  </xsl:template>
    
</xsl:stylesheet>
