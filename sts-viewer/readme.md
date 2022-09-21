# STS Viewer mini application

*Work in progress*

Note: fallback.xsl provides logic to tag everything if not tagged.

Extend in sts-view10.xsl and in CSS. B

## XSLT Version

Right now this is built in XSLT 1.0 for lightest possible browser footprint.

We can port to XSLT 3.0 later if need be.

## To do

- [x] Internal links (`xref`)
- [x] `list[@list-type='simple']`

### New pages

- [ ] Tweaked / tuned for optimal styled preview of SP800-53

## Fallback logic

By scrutinizing element content models given in the schemas, we attempt to make a distinction between element classes as follows:

Everything becomes a div unless it (a) appears directly inside an element permitted to have text content, and (b) it is itself permitted to have text content (i.e. it's more 'soup' not an island of structure), when it becomes a span.

## Base layer

The base layer overrides the fallback layer for all 'normal' and regular structures permitting better mappings into HTML.

- paragraphs - `p` elements
- tables
- lists
- term lists
- References section, citations
- figures
- sections / asides
- links - external & internal
- MathML

## Transformation strategy

strip-space removes space from block-level elements

everything matches on generic level (based on nominal level either)

class assignments expose names to CSS layer

only very basic formatting is exposed in HTML - b i u header levels - optimized for 508/Accessibility

CSS does the rest

## Staged templates

Class assignment should be 'cascading'.

Extra wrappers should be avoided where possible - HTML should not be more complicated than XML
Special functionalities may be sequestered (ToC, etc.) -- this is a PROOFING stylesheet not production

## Example documents?


