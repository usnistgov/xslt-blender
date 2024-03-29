declare const clearElementById: (targetID: string) => void;
declare function spliceIntoPage(targetID: string, doc: Document, clearing: Boolean): void;
declare function xsltEngineForHREF(xsltHREF: string): Promise<XSLTProcessor>;
declare function parseXMLLiteral(xmlLiteral: string): Document;
declare function parseAndTransformXMLLiteral(xmlLiteral: string, xsltEngine: XSLTProcessor): Document;
declare function parseAndTransformXMLatHREF(httpResource: string, xsltEngine: XSLTProcessor): Promise<Document>;
declare function xslt1ResultDocument(xmlDom: Document, xsltEngine: XSLTProcessor): Document;
declare function getXMLviaHTTP(httpResource: string): Promise<Document>;
declare function fileXMLContent(fileToRead: File): Promise<Document>;
declare function fileHTMLContent(fileToRead: File): Promise<Document>;
declare function fileTextContent(fileToRead: File): Promise<string>;
export { fileTextContent, fileXMLContent, fileHTMLContent, getXMLviaHTTP, clearElementById, spliceIntoPage, parseXMLLiteral, parseAndTransformXMLLiteral, parseAndTransformXMLatHREF, xslt1ResultDocument, xsltEngineForHREF };
