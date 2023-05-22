# OSCAL XML Styler

XSLT 1.0 Fiddle for OSCAL

Suitable for:

- OSCAL experts learning XSLT 1.0
- XSLT/XML practitioners learning OSCAL
- Any students of XSLT or OSCAL
- OSCAL developers sketching and testing ideas with real or test data

Not suitable for people who "don't want to deal" with source code or processes. If you need black-box, lights-out styling or require exacting production values - this is not the appliance for you.

- [x] Load an OSCAL XML file from your system (or with a link) - show in "load box" (document title, metadata, element count etc.)
  - [x] borrow from STS Viewer
- [x] Load an OSCAL XSLT 1.0 into an editing frame with a button (or from your system)
  - [x] borrow from HTML Reducer
  - [x] Hit a button to apply, show results in display
  - [x] Another button to clear
  - [ ] Test and harden against bad inputs
- [ ] Provide XSLT pre-loads 
- [x] Load a CSS into an edit window
  - [ ] Hit a button to apply
  - [x] Another button to clear
  - [ ] Test and defend e.g. against conflicts, overloading, bleeding
- [ ] Hit a Clear All button to clear everything
- [ ] Deploy an OSCAL Painter application to do CSS only - decorate your OSCAL in the browser 

Write up approaches

- [ ] 'Least Power' minimal XSLT for styling
    - OSCAL is copied through and sometimes *wrapped* (not mapped over to) HTML 
    - parameter expansion, uuid manipulation and links
    - ids and classes are copied, with local-name() appended to @class
    - other attributes are mapped to @data-*
    - except any element or attribute named '-uuid' gets special handling
    - and UUIDs are expanded to "uuid_x" etc.
- [ ] Comprehensive mapping into XHTML namespace - schema-driven
- [ ] Modified identity transformations
- [ ] Casting into altogether different vocabularies
- [ ] Doing other things e.g. Obfuscate 'Secret Encoder Ring'

Possible XSLTs

- [ ] OSCAL minimal - maps into 'oscalized' HTML?
- [ ] OSCAL all auto-generated
- [ ] OSCAL basic / handmade
- [ ] Generic identity transformation
- [ ] OSCAL Obfuscator

not OSCAL
- Elisa
- David B
