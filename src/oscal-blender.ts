/* 

OSCAL Blender
Uses xslt blender

NIST/ITL/CSD


*/

import {fileXMLContent, getXMLviaHTTP, spliceIntoPage, xslt1ResultDocument, xsltEngineForHREF} from "./xslt-blender";

// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// First, OSCAL-aware functions to be called by a UI
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%

// Loads an HTML view of SP 800-53 into the target Element content
async function loadsp80053(targetID: string): Promise<void> {
    // cacheable?
    const catalogHTML: Document = await sp80053inHTML();
    const clearing: Boolean = true;
    return spliceIntoPage(targetID, catalogHTML, clearing);
}

// Picks up loaded files, thus handling multiple catalogs, groups, or controls
// (sequences of discrete XML instances)
// each sequence member is rendered and displayed in the target locationn
async function showOSCAL(fileSet: FileList, targetID: string): Promise<void> {
    const target = document.getElementById(targetID);
    if (target) {
        for (const eachFile of fileSet) {
            const resultXML = await fileXMLContent(eachFile);
            if (resultXML) { addOSCALView(resultXML, targetID) }
            // else { clearElement(target) }
        }
    }
}

/* 



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// Utility UI drivers capable of accepting OSCAL
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%

async function addOSCALView(xml: Document, targetID: string): Promise<void> {
    const result: Document = await HTMLForOSCALXML(xml); // a promise
    const clearing: Boolean = false
    return spliceIntoPage(targetID, result, clearing);
}

// Same as add, but not additive
async function refreshOSCALView(xml: Document, targetID: string): Promise<void> {
    // const result: Promise<Document> = HTMLForOSCALXML(xml); // a promise
    const result: Document = await HTMLForOSCALXML(xml);
    const clearing: Boolean = true
    return spliceIntoPage(targetID, result, clearing);
}

/* 



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// OSCAL-related (static) resources and functionality
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%

const sp80053CatalogXML: Promise<Document> = getXMLviaHTTP('NIST_SP-800-53_rev5_catalog.xml');

const OSCALtoHTMLxsltEngine: Promise<XSLTProcessor> = xsltEngineForHREF('show-oscal-html.xsl');

async function HTMLForOSCALXML(xml: Document): Promise<Document> {
    const xsltEngine = await OSCALtoHTMLxsltEngine;
    return xslt1ResultDocument(xml, xsltEngine);
}

async function sp80053inHTML(): Promise<Document> {
    const catalog = await sp80053CatalogXML;
    const xsltEngine = await OSCALtoHTMLxsltEngine;
    return xslt1ResultDocument(catalog, xsltEngine);
}

