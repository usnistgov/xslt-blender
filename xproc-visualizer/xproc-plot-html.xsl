<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:p="http://www.w3.org/ns/xproc" xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="p"
   version="1.0">

   <!--
   Punchlist
   
   ToC/directory
   CSS
   - grid?
   -->


   <xsl:variable name="page-title">
      <xsl:value-of select="name(/*)"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="/*/@type"/>
   </xsl:variable>

   <xsl:template match="/*">
      <html>
         <head>
            <title>
               <xsl:value-of select="$page-title"/>
            </title>
            <xsl:call-template name="make-style"/>
            <xsl:call-template name="make-script"/>
         </head>
         <body>
            <main>
               <xsl:call-template name="lede"/>
               <!-- p:documentation is a complication in producing a map of an XProc
               
               -->

               <xsl:call-template name="plot-pipeline"/>
            </main>
         </body>
      </html>
   </xsl:template>



<!-- modes: import, prologue, step-decls, subpipeline filter for the respective groups
      then reverting to unnamed mode -->
   
   <xsl:template mode="pull-imports" match="*"/>
   <xsl:template mode="pull-imports" match="p:import | p:import-functions">
      <xsl:apply-templates select="."/>
   </xsl:template>
   <xsl:template mode="pull-imports" match="p:documentation[following-sibling::p:import | following-sibling::p:import-functions]">
      <xsl:apply-templates select="."/>
   </xsl:template>

   <xsl:template mode="pull-prologue" match="*"/>
   <xsl:template mode="pull-prologue" match="p:input | p:option | p:output | p:with-input | p:with-option">
      <xsl:apply-templates select="."/>
   </xsl:template>
   <xsl:template mode="pull-prologue"  match="p:documentation[following-sibling::p:import | following-sibling::p:import-functions]"/>
   <xsl:template mode="pull-prologue" match="p:documentation[following-sibling::p:input | following-sibling::p:option | following-sibling::p:output | following-sibling::p:with-input | following-sibling::p:with-option]">
      <xsl:apply-templates select="."/>
   </xsl:template>
   
   <xsl:template mode="pull-step-decls" match="p:import | p:import-functions | p:input | p:option | p:output | p:with-input | p:with-option"/>
   <xsl:template mode="pull-step-decls" match="p:documentation[following-sibling::p:import | following-sibling::p:import-functions]"/>
   <xsl:template mode="pull-step-decls" match="p:documentation[following-sibling::p:import | following-sibling::p:import-functions | following-sibling::p:input | following-sibling::p:option | following-sibling::p:output | following-sibling::p:with-input | following-sibling::p:with-option]"/>
   <xsl:template mode="pull-step-decls" priority="2" match="p:declare-step | p:documentation[following-sibling::p:declare-step]">
      <xsl:apply-templates select="."/>
   </xsl:template>
   <xsl:template mode="pull-step-decls" match="*"/>
   
   <xsl:template mode="pull-subpipeline" match="p:import | p:import-functions | p:input | p:option | p:output | p:with-input | p:with-option | p:declare-step"/>
   <xsl:template mode="pull-subpipeline" match="p:documentation[following-sibling::p:import | following-sibling::p:import-functions]"/>
   <xsl:template mode="pull-subpipeline" match="p:documentation[following-sibling::p:import | following-sibling::p:import-functions | following-sibling::p:input | following-sibling::p:option | following-sibling::p:output | following-sibling::p:with-input | following-sibling::p:with-option | following-sibling::p:declare-step]"/>
   <xsl:template mode="pull-subpipeline" match="p:declare-step | p:documentation[following-sibling::p:declare-step]"/>
   <xsl:template mode="pull-subpipeline" match="*">
      <xsl:apply-templates select="."/>
   </xsl:template>
   
   <xsl:template match="p:declare-step">
      <details class="declaration" id="{generate-id()}">
         <summary><span class="el"><xsl:call-template name="step-label"/></span></summary>
         <xsl:call-template name="plot-pipeline"/>
      </details>
   </xsl:template>
   
   <xsl:template name="plot-pipeline" match="p:library">
      <xsl:variable name="imports">
         <xsl:apply-templates mode="pull-imports"/>
      </xsl:variable>
      <xsl:variable name="prologue">
         <xsl:apply-templates mode="pull-prologue"/>
      </xsl:variable>
      <xsl:variable name="step-declarations">
         <xsl:apply-templates mode="pull-step-decls"/>
      </xsl:variable>
      <xsl:variable name="steps">
         <xsl:apply-templates mode="pull-subpipeline"/>
      </xsl:variable>
      <!-- brute force testing the results to see which divs to produce -->
      <xsl:if test="normalize-space($imports)">
         <div class="imports">
            <xsl:copy-of select="$imports"/>
         </div>
      </xsl:if>
      <xsl:if test="normalize-space($prologue)">
         <div class="prologue">
            <xsl:copy-of select="$prologue"/>
         </div>
      </xsl:if>
      <xsl:if test="normalize-space($step-declarations)">
         <div class="declarations">
            <xsl:copy-of select="$step-declarations"/>
         </div>
      </xsl:if>
      <xsl:if test="normalize-space($steps)">
         <div class="subpipeline">
            <xsl:copy-of select="$steps"/>
         </div>
      </xsl:if>
   </xsl:template>

   <xsl:template match="p:for-each | p:try | p:if | p:choose | p:viewport | p:group | p:catch | p:when | p:otherwise">
      <details class="{ local-name() }" id="{generate-id()}">
         <summary><span class="el"><xsl:call-template name="step-label"/></span></summary>
         <xsl:call-template name="plot-pipeline"/>
      </details>
   </xsl:template>
   
   <xsl:template match="p:documentation[text()[normalize-space()]]" priority="10">
      <p class="documentation">
         <xsl:apply-templates mode="in-docs"/>
      </p>
   </xsl:template>
   
   <xsl:template match="p:documentation">
         <xsl:apply-templates mode="in-docs"/>
   </xsl:template>
   
   <!-- we assume elements in docs cast to HTML - mode can be amended -->
   <xsl:template mode="in-docs" match="*">
       <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
       </xsl:element>
   </xsl:template>
   
   <xsl:template match="*">
      <section id="{ generate-id() }">
         <xsl:variable name="pipe-connector">
            <xsl:choose>
               <xsl:when test="substring-after(@pipe,'@') = /*/@name">
                  <xsl:value-of select="@pipe"/>
               </xsl:when>
               <xsl:when test="@pipe">
                  <xsl:text>@</xsl:text>
                  <xsl:value-of select="substring-after(@pipe,'@')"/>
               </xsl:when>
               <xsl:when test="p:pipe[@step = /*/@name]">
                  <xsl:value-of select="p:pipe/@pipe"/>
                  <xsl:text>@</xsl:text>
                  <xsl:value-of select="p:pipe/@step"/>
               </xsl:when>
               <xsl:when test="p:pipe">
                  <xsl:text>@</xsl:text>
                  <xsl:value-of select="p:pipe/@step"/>
               </xsl:when>
               <xsl:otherwise>-</xsl:otherwise>
            </xsl:choose>
         </xsl:variable>
         <xsl:for-each select="key('port-by-namekey',$pipe-connector)">
            <xsl:attribute name="onmouseenter">
               <xsl:text>highLight('</xsl:text>
               <xsl:value-of select="generate-id()"/>
               <xsl:text>')</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="onmouseleave">
               <xsl:text>unHighLight('</xsl:text>
               <xsl:value-of select="generate-id()"/>
               <xsl:text>')</xsl:text>
            </xsl:attribute>
         </xsl:for-each>
         
         <xsl:apply-templates select="." mode="label-step"/>
      </section>
   </xsl:template>
   
   <xsl:key name="port-by-namekey" match="*[@port]" use="concat(@port, '@', parent::*/@name)"/>
   
   <xsl:key name="port-by-namekey" match="*[@name]" use="concat('@', @name)"/>
   
   <xsl:template match="*[count(@*[not((name() = 'name') or (name() = 'port')) or (name() = 'pipe')]) > 0]" mode="label-step">
         <p class="el { local-name() }">
            <xsl:value-of select="name()"/>
            <xsl:for-each select="@name | @port | @pipe">
               <xsl:call-template name="tag-attribute"/>
            </xsl:for-each>
            <ul>
               <xsl:for-each select="@*[not((name() = 'name') or (name() = 'port') or (name() = 'pipe'))]">
                  <li>
                     <xsl:call-template name="tag-attribute"/>
                  </li>
               </xsl:for-each>
            </ul>
         </p>
         <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template name="tag-attribute">
      <xsl:text> </xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text>="</xsl:text>
      <code class="v">
         <xsl:value-of select="."/>
      </code>
      <xsl:text>"</xsl:text>
   </xsl:template>
   
   <xsl:template match="*" mode="label-step" name="label-step">
         <p class="el { local-name() }">
            <xsl:call-template name="step-label"/>
         </p>
         <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template name="step-label">
      <xsl:value-of select="name()"/>
      <xsl:for-each select="@*">
         <xsl:call-template name="tag-attribute"/>
        </xsl:for-each>
   </xsl:template>
   
   

   <xsl:template name="make-style">
      <style xml:space="preserve">
#XProcPlot {

body { font-family: sans-serif }
.el { width: fit-content; padding: 0.2em; margin-right: 1em; border: thin outset black; border-bottom: medium solid black; background-color: lightsteelblue }
span.el { display: inline }
main div { padding: 0.2em; outline: thin dotted black; margin-top: 0.4em }
main details { padding: 0.6em; outline: thin dotted black; margin-top: 0.8em }
main details.declaration { background-color: lavenderblush }
main div.prologue { background-color: lemonchiffon }
main div.subpipeline { background-color: whitesmoke }
main div:before { float: right; font-size:70%; font-weight: bold; background-color: black; color: white; padding: 0.4em }
main div:before { content: attr(class) }
.prologue .el, .el.with-input, .el.with-option { background-color: pink }
.el.import, .el.import-functions { background-color: midnightblue; color: white }
.el.variable  { background-color: lavender }
code.v { font-family: monospace; display: inline-block; padding: 0.2em }
code.v:hover { background-color: lightyellow; outline: thin dotted darkred }
section section { margin-left: 1em; padding-left: 1em; border-left: thin solid black }
ul { margin: 0em }
li { list-style-type: none }

section { width: fit-content;
  margin: 0.3em;
  padding: 0.2em }
section:hover { outline: medium dotted steelblue;
  background-color: lightsteelblue }
.LIT-UP { outline: medium dotted darkred;
  background-color: thistle }

}
         </style>
   </xsl:template>

   <xsl:template name="make-script"/>

   <xsl:template name="lede">
      <h1>
         <xsl:value-of select="$page-title"/>
      </h1>
   </xsl:template>
   
</xsl:stylesheet>