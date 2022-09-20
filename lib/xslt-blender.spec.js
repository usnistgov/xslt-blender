/*
    This software was developed by employees of the National Institute of Standards and
    Technology (NIST), an agency of the Federal Government and is being made available as a
    public service. Pursuant to title 17 United States Code Section 105, works of NIST
    employees are not subject to copyright protection in the United States. This software may
    be subject to foreign copyright. Permission in the United States and in foreign countries, to
    the extent that NIST may hold copyright, to use, copy, modify, create derivative works, and
    distribute this software and its documentation without fee is hereby granted on a
    nonexclusive basis, provided that this notice and disclaimer of warranty appears in all copies.

    THE SOFTWARE IS PROVIDED 'AS IS' WITHOUT ANY WARRANTY OF ANY KIND,
    EITHER EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO,
    ANY WARRANTY THAT THE SOFTWARE WILL CONFORM TO SPECIFICATIONS, ANY
    IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
    PURPOSE, AND FREEDOM FROM INFRINGEMENT, AND ANY WARRANTY THAT THE
    DOCUMENTATION WILL CONFORM TO THE SOFTWARE, OR ANY WARRANTY THAT
    THE SOFTWARE WILL BE ERROR FREE. IN NO EVENT SHALL NIST BE LIABLE FOR
    ANY DAMAGES, INCLUDING, BUT NOT LIMITED TO, DIRECT, INDIRECT, SPECIAL OR
    CONSEQUENTIAL DAMAGES, ARISING OUT OF, RESULTING FROM, OR IN ANY WAY
    CONNECTED WITH THIS SOFTWARE, WHETHER OR NOT BASED UPON WARRANTY,
    CONTRACT, TORT, OR OTHERWISE, WHETHER OR NOT INJURY WAS SUSTAINED BY
    PERSONS OR PROPERTY OR OTHERWISE, AND WHETHER OR NOT LOSS WAS
    SUSTAINED FROM, OR AROSE OUT OF THE RESULTS OF, OR USE OF, THE
    SOFTWARE OR SERVICES PROVIDED HEREUNDER.
*/
/*
    Tests for the XSLT Blender

    json-to-xml functionality aims for conformance with this:
      https://www.w3.org/TR/xpath-functions-31/#func-json-to-xml
      aiming for basic functionality first
      (TODO: come back to spec to see some more advanced features)

    The XML representation of JSON syntax is described here:
      https://www.w3.org/TR/xpath-functions-31/#json-to-xml-mapping
*/
import { assert } from 'chai';
import { parseXMLLiteral, writeOBJtoXML } from './xslt-blender';
/*
describe('To exercise the parser', () => {
    it("Parsing does not reflect attribute order', () => {
        const xml1 = "<elem attr1='a' attr2='b' />";
        const parsedDoc1 = parseXMLLiteral(xml1);
        const xml2 = '<elem attr2="b" attr1="a" />';
        const parsedDoc2 = parseXMLLiteral(xml2);
        assert.equal(parsedDoc1, parsedDoc2);
    });
    it("Parsing supports switching up quote mark delimiters in XML', () => {
        const xml1 = "<elem attr1='a' attr2='b' />";
        const parsedDoc1 = parseXMLLiteral(xml1);
        const xml2 = '<elem attr2="b" attr1="a" />';
        const parsedDoc2 = parseXMLLiteral(xml2);
        assert.equal(parsedDoc1, parsedDoc2);
    });
    it("Character references are resolved', () => {
        const xml1 = "<elem attr1='a' attr2='b' />";
        const parsedDoc1 = parseXMLLiteral(xml1);
        const xml2 = '<elem attr2="b" attr1="&#x41;" />';
        const parsedDoc2 = parseXMLLiteral(xml2);
        assert.equal(parsedDoc1, parsedDoc2);
    });
};
*/
describe('When rendering JSON as XML ...', () => {
    it('JSON to XML function must deliver XPath JSON XML (simple)', () => {
        const aJSONobj = { someProperty: "string value" };
        const testXML = writeOBJtoXML(aJSONobj);
        const testXMLdoc = parseXMLLiteral(testXML);
        const intendedXML = '<map xmlns="http://www.w3.org/2005/xpath-functions"><string key="someProperty">string value</string></map>';
        const intendedXMLdoc = parseXMLLiteral(intendedXML);
        assert.equal(testXMLdoc, intendedXMLdoc);
    });
    it('JSON to XML function must deliver XPath JSON XML (type sampling)', () => {
        const aJSONobj = { aMap: { str1: "x", str2: "y" },
            anArray: [1, 2, 3],
            aBoolean: false,
            aNumber: 1.62,
            aString: "A STRING" };
        const testXML = writeOBJtoXML(aJSONobj);
        const testXMLdoc = parseXMLLiteral(testXML);
        const intendedXML = '<map xmlns="http://www.w3.org/2005/xpath-functions"><map key="aMap"><string key="str1">x</string><string key="str2">y</string></map><array key="anArray"><number>1</number><number>2</number><number>3</number></array><boolean key="aBoolean">false</boolean><number key="aNumber">1.62</number><string key="aString">A STRING</string></map>';
        const intendedXMLdoc = parseXMLLiteral(intendedXML);
        assert.equal(testXMLdoc, intendedXMLdoc);
    });
    it('JSON to XML function must error gracefully on garbage input', () => {
    });
    it('JSON to XML function must error informatively on XML input', () => {
    });
});
//# sourceMappingURL=xslt-blender.spec.js.map