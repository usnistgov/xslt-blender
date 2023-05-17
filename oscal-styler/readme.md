# OSCAL XML Styler

XSLT 1.0 Fiddle for OSCAL

Suitable for:

- OSCAL experts learning XSLT 1.0
- XSLT/XML practitioners learning OSCAL
- Any students of XSLT or OSCAL
- OSCAL developers sketching and testing ideas with real or test data

Not suitable for people who "don't want to deal" with source code or processes. If you need black-box, lights-out styling or require exacting production values - this is not the appliance for you.

- [ ] Load an OSCAL XML file from your system (or with a link) - show in "load box" (document title, metadata, element count etc.)
  - [ ] borrow from STS Viewer
- [ ] Load an OSCAL XSLT 1.0 into an editing frame with a button (or from your system)
  - [ ] borrow from HTML Reducer
  - [ ] It is pregenerated yet also contains specific OSCAL logic
    - [ ] parameter expansion, uuid manipulation and links
    - [ ] any element or attribute named '-uuid' gets special handling
    - [ ] UUIDs are expanded to "uuid_x" etc.
  - [ ] Hit a button to apply, show results in display
  - [ ] Another button to clear
- [ ] Load a CSS into an edit window
  - [ ] Hit a button to apply
  - [ ] Another button to clear
- [ ] Hit a Clear All button to clear everything

