// XSLT Blender is a library of functions supporting XML and JSON processing using XSLT 1.0
// in the browser or (eventually) under NodeJS.

/* 

XSLT Blender

NIST/ITL/CSD


*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// First, OSCAL-aware functions to be called by a UI
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%

// Loads an HTML view of SP 800-53 into the target Element content
// async function loadsp80053(targetID: string): Promise<void> {
    // cacheable?
//     const catalogHTML: Document = await sp80053inHTML();
//     const clearing: Boolean = true;
//     return spliceIntoPage(targetID, catalogHTML, clearing);
// }

// Picks up loaded files, thus handling multiple catalogs, groups, or controls
// (sequences of discrete XML instances)
// each sequence member is rendered and displayed in the target locationn
// async function showOSCAL(fileSet: FileList, targetID: string): Promise<void> {
//     const target = document.getElementById(targetID);
//     if (target) {
//         for (const eachFile of fileSet) {
//             const resultXML = await fileXMLContent(eachFile);
//             if (resultXML) { addOSCALView(resultXML, targetID) }
//             // else { clearElement(target) }
//         }
//     }
// }

/* 



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// Utility UI drivers capable of accepting OSCAL
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%

// async function addOSCALView(xml: Document, targetID: string): Promise<void> {
//     const result: Document = await HTMLForOSCALXML(xml); // a promise
//     const clearing: Boolean = false
//     return spliceIntoPage(targetID, result, clearing);
// }

// Same as add, but not additive
// async function refreshOSCALView(xml: Document, targetID: string): Promise<void> {
    // const result: Promise<Document> = HTMLForOSCALXML(xml); // a promise
//     const result: Document = await HTMLForOSCALXML(xml);
//     const clearing: Boolean = true
//     return spliceIntoPage(targetID, result, clearing);
// }

/* 



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// OSCAL-related (static) resources and functionality
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%

// const sp80053CatalogXML: Promise<Document> = getXMLviaHTTP('NIST_SP-800-53_rev5_catalog.xml');

// const OSCALtoHTMLxsltEngine: Promise<XSLTProcessor> = xsltEngineForHREF('show-oscal-html.xsl');

// async function HTMLForOSCALXML(xml: Document): Promise<Document> {
//     const xsltEngine = await OSCALtoHTMLxsltEngine;
//     return xslt1ResultDocument(xml, xsltEngine);
// }

// async function sp80053inHTML(): Promise<Document> {
//     const catalog = await sp80053CatalogXML;
//     const xsltEngine = await OSCALtoHTMLxsltEngine;
//     return xslt1ResultDocument(catalog, xsltEngine);
// }

/* 



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// General helpers for writing to a page
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%

function addToView(targetID: string, doc: Document): void {
    const clearing = false;
    return spliceIntoPage(targetID, doc, clearing);
}

function refreshView(targetID: string, doc: Document): void {
    const clearing = true;
    return spliceIntoPage(targetID, doc, clearing);
}

const clearElementById = (targetID: string) => {
    const clearMe: Element | null = document.getElementById(targetID);
    // clears everything inside by removing until none are left
    if (clearMe) { clearElement(clearMe) }
    else { console.log("Can't clear " + targetID) }
}

const clearElement = (elem: Element) => {
    // clears everything inside by removing until none are left
    // https://stackoverflow.com/questions/3450593/how-do-i-clear-the-content-of-a-div-using-javascript
    while (elem.firstChild && elem.removeChild(elem.firstChild));
}

function spliceIntoPage(targetID: string, doc: Document, clearing: Boolean): void {
    const viewerElement: HTMLElement | null = document.getElementById(targetID);
    if (viewerElement && doc.documentElement) {
        const newContents = document.adoptNode(doc.documentElement);
        if (clearing) { clearElement(viewerElement) };
        viewerElement.prepend(newContents);
    }
    else {
        console.log("Can't splice into page at " + targetID);
        if (!viewerElement) { console.log(" ... not seeing " +  targetID) }
    }
}

/* 



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// Utility functions for XML/XSLT processing
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%


// For XSLT not yet loaded we can accept an href
async function transformAndShowXML(xmlLiteral: string, xsltHREF: string, targetID: string): Promise<void> {
    const resultDocument: Document = await getAndApplyXSLTtoLiteral(xmlLiteral, xsltHREF); // a promise
    const clearing: Boolean = true;
    return spliceIntoPage(targetID, resultDocument, clearing);
}

// If neither XML nor XSLT have yet been picked up, we can accept references ...
async function getAndApplyXSLTtoLiteral(xmlLiteral: string, xsltHREF: string): Promise<Document> {
    const xsltEngine: XSLTProcessor = await xsltEngineForHREF(xsltHREF);
    return parseAndTransformXMLLiteral(xmlLiteral, xsltEngine);
}

async function getAndApplyXSLTtoXMLatHREF(xmlHREF: string, xsltHREF: string): Promise<Document> {
    const xsltEngine: XSLTProcessor = await xsltEngineForHREF(xsltHREF);
    return parseAndTransformXMLatHREF(xmlHREF, xsltEngine);
}

// This gives us back an engine for an XSLT given an href (relative or absolute URL)
async function xsltEngineForHREF(xsltHREF: string): Promise<XSLTProcessor> {
    const xsltDoc: Document = await getXMLviaHTTP(xsltHREF);
    return setupXSLTEngine(xsltDoc);
}

// Setting up the engine - extend to provide runtime parameters (in a map)
function setupXSLTEngine(xslt: Document): Promise<XSLTProcessor> {
    const isXSLT = xslt.querySelector('stylesheet') || xslt.querySelector('transform');
    return new Promise((resolve, reject) => {
        if (isXSLT) {
            const xsltEngine = new XSLTProcessor();
            xsltEngine.importStylesheet(xslt);
            resolve(xsltEngine)
        }
        else { reject("Requested XSLT is not a stylesheet") }
    });
}

// If we have an XML literal and a configured XSLT engine ...
function parseXMLLiteral(xmlLiteral: string): Document {
    const aParser = new DOMParser();
    return aParser.parseFromString(xmlLiteral, "application/xml");
    // error handling?
}

// If we have an XML literal and a configured XSLT engine ...
function parseAndTransformXMLLiteral(xmlLiteral: string, xsltEngine: XSLTProcessor): Document {
    const aParser = new DOMParser();
    const doc = aParser.parseFromString(xmlLiteral, "application/xml");
    // error handling?
    return xslt1ResultDocument(doc, xsltEngine);
}

// If we have an XML at an HREF and a configured XSLT engine ...
async function parseAndTransformXMLatHREF(httpResource: string, xsltEngine: XSLTProcessor): Promise<Document> {
    const doc = await getXMLviaHTTP(httpResource);
    // error handling?
    return xslt1ResultDocument(doc, xsltEngine);
}

// If we have an XML DOM and a configured XSLT engine ... returning a Document
function xslt1ResultDocument(xmlDom: Document, xsltEngine: XSLTProcessor): Document {
    // error handling?
    return xsltEngine.transformToDocument(xmlDom);
}

// If we have already got an XML DOM and a configured XSLT engine ... returning a DocumentFragment
// (nb untested how this works 20220205)
function xslt1ResultFragment(xmlDom: Document, xsltEngine: XSLTProcessor): DocumentFragment {
    // error handling?
    // should aDocument be passed in as an arg?
    const aDocument = new Document;
    return xsltEngine.transformToFragment(xmlDom, aDocument);
}

// Promise returning an XML DOM given a file reference
// helpful on promises for HTTP: https://www.freecodecamp.org/news/javascript-promise-tutorial-how-to-resolve-or-reject-promises-in-js/
function getXMLviaHTTP(httpResource: string): Promise<Document> {
    return new Promise((resolve, reject) => {
        const request = new XMLHttpRequest();
        request.addEventListener("readystatechange", () => {
            // we can get a DOM if it parses
            if (request.readyState === 4 && request.status === 200 && request.responseXML) {
                resolve(request.responseXML);
            } else if (request.readyState === 4) {
                reject("failed http request for XML - no file or did not parse");
            }
        });
        request.open("GET", httpResource);
        request.send();
    });
}


// Produces an XML mapping for a JSON string literal
// see https://www.w3.org/TR/xpath-functions-31/#schema-for-json for the format
function JSONasXML(json: string): string | void {
    try { JSON.parse(json, obj => writeOBJtoXML(obj)) }
    catch (error) { console.log("Could not parse JSON: ", error) };
    // return JSON.parse(json, obj => writeOBJtoXML(obj));
}

// To write an XML file from an arbitrary JSON object, call the tagger
function writeOBJtoXML(obj: any): string {
    let xml: string = "";
    for (const prop in obj) { xml += tagProperty(obj[prop], prop, true) };
    return xml;
}

// The tagger returns tagging for anything, including its contents
function tagProperty(obj: any, key: any, top: boolean): string {
    const scalarTypes: string[] = ["boolean", "number", "string", "undefined"];
    const xpathns: string = " xmlns='http://www.w3.org/2005/xpath-functions'";

    // produce the start tag, with attribute syntax conditionally
    // making xmlns attribute only when writing from the top
    // making @key only for (named) object properties, not (enumerated) array members
    let xml = `<${tagName(obj)}${top ? xpathns : ""}${isNaN(key) ? ` key='${key}'` : ""}>`;

    // if we know the object type as a scalar, we can write the value
    if (scalarTypes.includes(typeof obj)) { xml += obj }
    // or for objects and arrays, we process contents recursively
    else if (typeof obj === "object") {
        for (const prop in obj) { xml += tagProperty(obj[prop], prop, false); }
    };

    // now the close tag
    xml += `</${tagName(obj)}>`;
    return xml;
}

// Utility function returns the corresponding XPath object type name
// for any JSON object
// see https://www.w3.org/TR/xpath-functions-31/#schema-for-json
function tagName(jsonvalue: any): string {
    if (jsonvalue instanceof Array) { return "array" }
    else {
        switch (typeof jsonvalue) {
            case "string": return "string"; // with return, we need no break
            case "number": return "number";
            case "boolean": return "boolean";
            // case "undefined": return "null";
            default: return "map";
        }
    };
}

// Given a file object, we can read XML from it, intercepting parser errors
// function fileXMLContent(fileToRead: File): Promise<Document> {
//     return new Promise(async (resolve, reject) => {
//         const fileText = await fileTextContent(fileToRead);
//         const fileXML = new DOMParser().parseFromString(fileText, "application/xml");
//         const errorNode = fileXML.querySelector('parsererror');
//         return (errorNode) ? reject(errorNode) : resolve(fileXML);
//     });
// }

// for local loading, not http
function fileXMLContent(fileToRead: File): Promise<Document> {
    return fileParsedContent(fileToRead, "application/xml")
}

function fileHTMLContent(fileToRead: File): Promise<Document> {
    return fileParsedContent(fileToRead, "text/html")
}

type ParseableMIMEType = "text/html" | "text/xml" | "application/xml" | "application/xhtml+xml" | "image/svg+xml"

// Reads file and intercepts parser errors for expected type
function fileParsedContent(fileToRead: File, asMIME: ParseableMIMEType): Promise<Document> {
    return new Promise(async (resolve, reject) => {
        const fileText = await fileTextContent(fileToRead);
        const fileParsed = new DOMParser().parseFromString(fileText, asMIME);
        const errorNode = fileParsed.querySelector('parsererror');
        return (errorNode) ? reject(errorNode) : resolve(fileParsed);
    });
}

// Utility function gets the text out of a File object returning a Promise of a string
// https://stackoverflow.com/questions/34495796/javascript-promises-with-filereader/46568146#46568146
function fileTextContent(fileToRead: File): Promise<string> {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => {
            (typeof reader.result === "string") ? resolve(reader.result) : reject
        };
        reader.onerror = reject;
        reader.readAsText(fileToRead);
    });
}

/* 



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// Utility functions for browser/UI interaction
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%

function addClassToElementById(who: string, newClass: string): void {
    const whichElement: Element | null = document.getElementById(who);
    if (whichElement) { whichElement.classList.add(newClass) }
}

function removeClassFromElementById(who: string, theClass: string): void {
    const whichElement: Element | null = document.getElementById(who);
    if (whichElement) { whichElement.classList.remove(theClass) }
}

function addClassToElementsByClass(addToClass: string, newClass: string): void {
    const elements: HTMLCollection = document.getElementsByClassName(addToClass);
    for (const elem of elements) { elem.classList.add(newClass) }
}

function removeClassFromElementsByClass(removeFromClass: string, theClass: string): void {
    const elements: HTMLCollection = document.getElementsByClassName(removeFromClass);
    for (const elem of elements) { elem.classList.remove(theClass) }
}

// any automagic way to export everything?
export { fileTextContent, fileXMLContent, fileHTMLContent,
         getXMLviaHTTP, writeOBJtoXML, clearElementById, spliceIntoPage,
         parseXMLLiteral, parseAndTransformXMLLiteral, parseAndTransformXMLatHREF,
         xslt1ResultDocument, xsltEngineForHREF };