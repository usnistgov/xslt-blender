# XSLT Blender

A library of XML/XSLT functionality for execution in a browser.

Presently in "alpha" state, that is, barely working and scarcely documented.

## Aims

This code base is intended to support development of "intelligent" lightweight client-side web applications exploiting the XML/XSLT capabilities currently offered as standard in browsers (especially XSLT 1.0).

Code here is authored in Typescript and Javascript but aims to be minimalistic, so it can easily be reused. The intent is to make it easy to do "things that should be easy", but require a small amount of engineering of pipelines and interfaces.

This code base will be exercised through an informal collection of examples showing different kinds of functionality, including "mixed" applications where XSLT is used in conjunction with Javascript or with other Javascript (or Typescript) libraries supporting other functionalities, such as zipping/unzipping.

A particular area of interest is the pipelining of JSON data and integration of JSON data into XML-based pipelines, using XSLT 1.0.

In its present state the best way to use this repository is to browse the code base, try the examples (typically to be served in a plain web server), replicate and rewrite them.

Depending largely on developer interest, over time more mature support may be offered, including packaging.

## Repository Contents

`pub` subdirectory - serve the demonstrations from here.
`src` Typescript source to be compiled (compiled Javascript goes into `pub`)

## Installation

Presently the `pub` directory presents an entire coherent publication, with navigation, of available demonstrations.

It can be served directly and viewed on `localhost`, or bound to a Pages site (for example).

Demonstrations should be self-explanatory.

## License and dependencies

Code here all runs in your browser with no dependencies except as noted per demonstration.

A license is given in the LICENSE.md file.

## Contact Info

Project is maintained by Wendell Piez, NIST ITL/CSD (Information Technology Lab, Computer Security Division). Please contact w e n d e l l p i e z @ n i s t . g o v.

Additionally please open or respond to Issues in this Github repository.

## Cite this work

Piez, Wendell. XSLT Blender. National Institute of Standards and Technology, 2022. https://github.com/usnistgov/xslt-blender

## To Do:

-[x] finish README line items
-[x] finish README-template.md line items
-[x] README.md, CODEOWNERS, CODEMETA.yaml
-[x] push
-[ ] test and push minimal installation

Each repository will contain a plain-text [README file][wk-rdm],
preferably formatted using [GitHub-flavored Markdown][gh-mdn] and
named `README.md` (this file) or `README`.

Per the [GitHub ROB][gh-rob] and [NIST Suborder 1801.02][nist-s-1801-02],
your README should contain:

1. Software or Data description
   - Statements of purpose and maturity
   - Description of the repository contents
   - Technical installation instructions, including operating
     system or software dependencies
1. Contact information
   - PI name, NIST OU, Division, and Group names
   - Contact email address at NIST
   - Details of mailing lists, chatrooms, and discussion forums,
     where applicable
1. Related Material
   - URL for associated project on the NIST website or other Department
     of Commerce page, if available
   - References to user guides if stored outside of GitHub
1. Directions on appropriate citation with example text
1. References to any included non-public domain software modules,
   and additional license language if needed, *e.g.* [BSD][li-bsd],
   [GPL][li-gpl], or [MIT][li-mit]

The more detailed your README, the more likely our colleagues
around the world are to find it through a Web search. For general
advice on writing a helpful README, please review
[*Making Readmes Readable*][18f-guide] from 18F and Cornell's
[*Guide to Writing README-style Metadata*][cornell-meta].
