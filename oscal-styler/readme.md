# OSCAL XML Styler

XSLT 1.0 Fiddle for OSCAL

Suitable for:

- OSCAL experts learning XSLT 1.0
- XSLT/XML practitioners learning OSCAL
- Any students of XSLT or OSCAL
- OSCAL developers sketching and testing ideas with real or test data

Not suitable for people who "don't want to deal" with source code or processes. If you need black-box, lights-out styling or require exacting production values - this is not the appliance for you.

Both the Styler and its configured (hard-wired) variant, the OSCAL Painter, are 'meta-applications' in the sense that the user is expected to drive them by providing what amounts to application code.

This is useful for learners, and extends the range of potential uses even for something very lightweight and generic.

## Original punchlist

- [x] Load an OSCAL XML file from your system (or with a link) - show in "load box" (document title, metadata, element count etc.)
  - [x] borrow from STS Viewer
- [x] Load an OSCAL XSLT 1.0 into an editing frame with a button (or from your system)
  - [x] borrow from HTML Reducer
  - [x] Hit a button to apply, show results in display
  - [x] Another button to clear
  - [x] Test and harden against bad inputs
- [ ] Provide XSLT pre-loads 
- [x] Load a CSS into an edit window
  - [x] Hit a button to apply
  - [x] Another button to clear
  - [x] Test and defend e.g. against conflicts, overloading, bleeding
- [x] Hit a Clear All button to clear everything
- [x] Deploy an OSCAL Painter application to do CSS only - decorate your OSCAL in the browser 

## Discarded ideas

- Provide more variants
- Heavier documentation (for now)