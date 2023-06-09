<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <sch:ns prefix="h3" uri="http://www.w3.org/1999/xhtml"/>
    <!--<script xmlns="http://www.w3.org/1999/xhtml" src="https://pages.nist.gov/nist-header-footer/js/nist-header-footer.js" type="text/javascript" defer="defer"/>-->
    <sch:pattern>
        
        <sch:rule context="h3:head">
            <sch:let name="forme-script" value="'https://pages.nist.gov/nist-header-footer/js/nist-header-footer.js'"/>
            <sch:assert test="exists(h3:script[@src=$forme-script][@defer='defer'])">NIST header/footer script is missing.</sch:assert>
        </sch:rule>
        
        <sch:rule context="h3:body">
            <sch:assert test="exists(h3:script[matches(@src,'/site/nist-bounce.js$')])">NIST bounce script is missing.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>