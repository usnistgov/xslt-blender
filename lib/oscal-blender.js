/*

OSCAL Blender
Uses xslt blender

NIST/ITL/CSD


*/
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { fileXMLContent, getXMLviaHTTP, spliceIntoPage, xslt1ResultDocument, xsltEngineForHREF } from "./xslt-blender";
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// First, OSCAL-aware functions to be called by a UI
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// Loads an HTML view of SP 800-53 into the target Element content
function loadsp80053(targetID) {
    return __awaiter(this, void 0, void 0, function* () {
        // cacheable?
        const catalogHTML = yield sp80053inHTML();
        const clearing = true;
        return spliceIntoPage(targetID, catalogHTML, clearing);
    });
}
// Picks up loaded files, thus handling multiple catalogs, groups, or controls
// (sequences of discrete XML instances)
// each sequence member is rendered and displayed in the target locationn
function showOSCAL(fileSet, targetID) {
    return __awaiter(this, void 0, void 0, function* () {
        const target = document.getElementById(targetID);
        if (target) {
            for (const eachFile of fileSet) {
                const resultXML = yield fileXMLContent(eachFile);
                if (resultXML) {
                    addOSCALView(resultXML, targetID);
                }
                // else { clearElement(target) }
            }
        }
    });
}
/*



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// Utility UI drivers capable of accepting OSCAL
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
function addOSCALView(xml, targetID) {
    return __awaiter(this, void 0, void 0, function* () {
        const result = yield HTMLForOSCALXML(xml); // a promise
        const clearing = false;
        return spliceIntoPage(targetID, result, clearing);
    });
}
// Same as add, but not additive
function refreshOSCALView(xml, targetID) {
    return __awaiter(this, void 0, void 0, function* () {
        // const result: Promise<Document> = HTMLForOSCALXML(xml); // a promise
        const result = yield HTMLForOSCALXML(xml);
        const clearing = true;
        return spliceIntoPage(targetID, result, clearing);
    });
}
/*



*/
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
// OSCAL-related (static) resources and functionality
// ###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%###%%%
const sp80053CatalogXML = getXMLviaHTTP('NIST_SP-800-53_rev5_catalog.xml');
const OSCALtoHTMLxsltEngine = xsltEngineForHREF('show-oscal-html.xsl');
function HTMLForOSCALXML(xml) {
    return __awaiter(this, void 0, void 0, function* () {
        const xsltEngine = yield OSCALtoHTMLxsltEngine;
        return xslt1ResultDocument(xml, xsltEngine);
    });
}
function sp80053inHTML() {
    return __awaiter(this, void 0, void 0, function* () {
        const catalog = yield sp80053CatalogXML;
        const xsltEngine = yield OSCALtoHTMLxsltEngine;
        return xslt1ResultDocument(catalog, xsltEngine);
    });
}
//# sourceMappingURL=oscal-blender.js.map