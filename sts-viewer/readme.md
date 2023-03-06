# STS Viewer application

## Aims

This is a display application for NISO STS format. Its primary use is to render documents encoded in NISO STS XML on screen for reading by human users. Because it does a generic rendering, it provides a useful pre-check for authors and editors of STS content, to confirm that their work appears and functions as intended. The layout is meant to be consistent with the STS model in design and versatile enough to be adapted, either to offer extended features, or local adjustments to styling. The current plan:

- For adequate handling for display of any reasonably 'generic' STS in the body and back matter
  - Front matter too, in part - (offer choice of templates?)
- To focus on NIST CSD publications as primary use case
  - With any other NIST or non-NIST pubs as further use cases
- To provide robust, clean, Accessible HTML
  - Reasonably easy to format further (style/PDF)  
- Not to provide solutions to everything, but instead a foundation

## Maintenance plan

Feature requests are welcome: please contact the developer or post an Issue.  ([See the repository](https://github.com/usnistgov/xslt-blender/issues).) Examples of real data with reasonable ("common") feature requests are especially welcome.

A longer-term maintenance plan remains to be formulated, based on the usefulness of the resource and how widely (and by whom) it is adopted. Internal users are the primary but not the only audience. Users who wish to ensure this application has long-term viability are encouraged to fork it in addition to finding other ways to support it.

If you use this application and tell no one, the developer will not know and it may become moribund, or disappear at any time, if only because no one was thought to care. You can prevent that.

## XSLT Version

Currently this is built in XSLT 1.0 for lightest possible browser footprint, and consistently with the host project [XSLT Blender](../README.md).

We can port to XSLT 3.0 later if need be (or spin off application logic to other applications).

The XSLT 1.0 is written to be forward-compatible, so running under a later version processor should not be problematic. (Not yet tested.)

## Architecture

`sts-view10.xsl` is the main (entry) XSLT, to be applied to any STS XML document. Any XSLT 1.0 runtime can be used to produce HTML from STS using this transformation. In the application this happens dynamically (responding to a load file event), but the same mapping transformation can be applied by any XSLT (1.0) engine in any runtime.

Other XML document types should process successfully, writing output that announces a match failure for an unrecognized root element. Other formats (not XML) will of course error on this operation.

`fallback.xsl` is imported by this stylesheet, and not used separately. It provides logic to tag everything if not tagged. Keeping it separate makes it easy to use the same fallback logic with other transformations.

This module provides explicit template matches for all elements in the model, classing them as element-only or text-level, as determined by analysis of the schema (see below). The fallback handling for any element not otherwise matched is to flag it to appear visibly in the HTML output. The best way of finding these is often by visual inspection.

`sts-tags-and-names.xsl` is *not called*, but provides logic to `fallback.xsl`. It was converted programatically from XML source documenting the formal names of STS tags (original source provided by STS).

### Fallback logic

By scrutinizing element content models given in the schemas (1.1d1 at time of writing), element classes can be distinguished as follows:

Everything becomes either a `div` (for structured elements) or `span` for elements appearing in line. An element becomes a `div` if its model given in the schema permits only other elements, no text contents. Likewise it becomes a `div` if it is never *used* (incuded) in an inline context (i.e., permissibly mixed with text. An STS `p` thus becomes a `div` (used only as a 'block' never in line), and so also does a `sec` (used only as a block,)

Whether an element appears in line  unless it (a) appears directly inside an element permitted to have text content, and (b) it is itself permitted to have text content. That is, everything is a div except 'soup', which is recognized as anything that both appears with text, and contains text, when it becomes a span.

The `fallback.xsl` logic also provides support for assignment of `@class` values, to be overridden when appropriate in a calling XSLT by providing a template in a callback mode ("class"), generating a string (space-delimited token set) for the value. Additionally, this stylesheet provides for `id` attributes to be copied, but for no other attributes to be copied or propagated (again without overriding logic).

### Base layer

The base layer of processing is encoded in the main module `sts-view10.xsl`. It overrides the fallback layer for all 'normal' and regular structures permitting better mappings into HTML.

- paragraphs - become HTML `p` elements
- tables - become tables
- lists - become lists or grids
- term lists - ditto
- References section, citations - wrapper structures and linking
- figures - ditto
- sections / asides - ditto
- links - external & internal
- MathML

Note that by default, everything is already matched and tagged such that most customizations of display can happen in the CSS layer. New or altered XSLT in the base layer is needed only when the HTML structure itself needs to be altered, attributes added or classes reassigned.

### CSS Layer

This layer of specification defines styles to be applied to the HTML produced by the transformation. Default `@class` tagging of the HTML provides hooks for CSS development, permitting fine-grained customization of style in the view, reflecting structures, organization, types and features expressed upstream in the XML.

Additionally, because most actual styling is controlled in a CSS, the HTML emitted by the base layer can be simple, robust, well-structured, descriptive, and 508-compliant for all accessibility requirements.

### Customization strategy

For customization, work in the opposite order, outside-in. First, see if CSS adjustments are sufficient. In many cases, desired styling on the page will be possible just given some adjustment to CSS to be applied on the basis of (`@class`) tagging carried from the STS source.

In cases when you want the HTML (not only the CSS) to be altered, this can be done by modifying a template with an appropriate match pattern, or by introducing a new template into the `sts-view10.xsl` or into another XSLT used in its place.

Other XSLT modules (`fallback.xsl` and `sts-tags-and-names.xsl`) only need to be modified when STS itself changes.

## Rights and Contact Info

For license information see the [repository readme](../README.md). (Public domain: reuse encouraged with credits.)

The lead developer of this project is Wendell Piez, w e n d e l l (dot) p i e z (at) n i s t (dot) g o v (NIST/ITL/CSD, Secure Systems and Applications Group).
