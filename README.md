# XSLT Blender

A library of XML/XSLT functionality for execution in a browser, illustrated through demonstrations.

Presently in "alpha" state, that is, minimalistic and working towards proof-of-concept.

## Aims

This code base is intended to support development of  lightweight client-side web applications exploiting the XML/XSLT capabilities currently offered as standard in browsers (especially XSLT 1.0).

In general, applications here will process XML with XSLT. The XML may be on the site, elsewhere on the Internet, or provided by the user. In most cases, the capability being demonstrated  is implemented in XSLT, the source code of which is also provided for inspection and validation.

These stylesheets are appplied by means of a library whose code is authored in Typescript and Javascript with as small a footprint as possible, for ease of use, deployment and maintenance. The intent is to make it easy to do things that should be easy, but that require some measure of engineering of pipelines and interfaces -- which might be provided by a library

This code base can be exercised through an informal collection of examples showing different kinds of functionality, including "mixed" applications where XSLT is used in conjunction with Javascript or with other Javascript (or Typescript) libraries supporting other functionalities, such as zipping/unzipping.

A particular area of interest is the pipelining of JSON data and integration of JSON data into XML-based pipelines, even using XSLT 1.0.

Use this repository by browsing the code base, trying the examples (as served in a plain web server), then replicating and rewriting them.

Depending largely on developer interest, over time more mature support may be offered, in the form of documentation, unit 
tests, packaging and deployment support.

## Why XSLT?

XSLT remains an excellent prototyping language.

Code bases are small and relatively easy to audit. Vulnerabilities of the architecture, specifications and tools are well understood and preventable or mitigable. XSLT processors and their dependencies (such as parsers) have been well tested, and their degree of conformance with the relevant specifications is high.

XSLT 1.0 remains what it was in 1999, but the Internet has grown up around it, and Javascript (more precisely, ECMAScript) in particular is *finally* able to provide the level of support needed to apply XSLT transformation logic flexibly, in a range of different scenarios, to achieve useful data processing operations in the browser, beyond display.

The capacity to publish unit testing, for Javascript (Typescript) and XSLT, also helps to provide a level of assurance and verifiability to these applications that was impossible when they were first developed.

Applications can be written with *no* dependencies on external libraries. XSLT 1.0 is supported natively in the browser. If the feature set or capabilities of XSLT 3.0 are needed, a single dependency suffices, [SaxonJS](https://www.saxonica.com/saxon-js/index.xml), which additionally offers a range of features supporting integration, application and interface development.

The [Rule of Least Power](https://www.w3.org/2001/tag/doc/leastPower.html) can be applied.

## Development Model

This codebase is a secondary ("spinoff") project with the purpose of making code available for reuse. Developed for internal projects or use at NIST, the code base is published here for the use of the public and of developers who can build on its foundations or study it as a model.

## Repository Contents

### Site configuration

CODEMETA.yaml
CODEOWNERS
CODE_OF_CONDUCT.md
CONTRIBUTORS.md
LICENSE.md
README-template.md
fair-software.md

### This file

- README.md

### Portal front page

- index.html

### Site CSS

- nist-boilerplate.css
- nist-combined.css (copied from https://pages.nist.gov/nist-header-footer/css/)

### Directory and its supporting files

- directory.xml
- list-projects.xsl
- projects-html.css
- projects-page.xsl

### NodeJS setup

- package-lock.json
- package.json
- tsconfig.json

### Projects

See directories

- [JSON Mixer](json-mixer) - can do something (anything) with JSON in XSLT 1.0? yup
- [STS Viewer](sts-viewer)

### Source and compiled Typescript

- Sources in `src`
- Compiled Typescript and Javascript goes into `lib`
- Additionally, projects may have their own Javascript libraries

### For later (factor out)

- page-template.html
- frame.xsl
- style.css

## Installation

The repository presents an entire coherent publication, with navigation, of available demonstrations, as embedded in (delivered by) a plain web site, with no back end or dynamic capability.

It can be served directly and viewed on `localhost`, or bound to a Github or Gitlab Pages site (such as what you might be reading).

Demonstrations should be self-explanatory, assuming relevant background knowledge. Please do research or make inquiries!

- Declarative markup
- XML and XSLT

To compile Typescript libraries from source, nodeJS and npm are assumed.

## Development model

Since these are client-side applications intended to be run in far-away environments, the development model relies on standards and simplicity to help ensure operations.

A project will typically be built by:

- designing a conceptual model of a functional interface for XML/XSLT
- deploy a prototype coded by hand (HTML/Javascript) calling XSLT over XML sources
- iteratively develop the (XSLT) transformation along with with user interface

Over time, projects will show a range of different approaches and user interface capabilities, which can be borrowed, reused, and refined.

### Compiling

The latest `lib` outputs will be pushed to the repository, so you only have to compile if you modify or extend the source code.

`npm install` to install or reinstall the Typescript configuration.

Source code is in `src`. This is all Typescript compiled on NodeJS, so (with Typescript installed) `tsc` to produce Javascript runtime libraries.

### Serving from `localhost`

With NPM, start a local server by opening a Linux/WSL prompt in the `xslt-blender` directory, and invoking `npm serve`, or simply `http-server` with that npm module installed.

Or run a vanilla web server using the http server of your choice.

Point your browser at `index.html` or the landing page of any demo, as served on `localhost` or the address of your server.

### Testing

Applications are tested by development under load with representative sample documents.

Due to limitations in available support for XML/XSLT in Javascript (ECMAScript) outside browsers, we have not been able to unit test libraries outside the browser environment; this remains a TBD (and indeed browsers may vary in any case). To help compensate for this, a variety of browsers (typically at least Chrome and Firefox) are used to test in development.

Note that XSLT applications (and declarative XML applications in general) are built in accordance with the security principle of "Least Power". As a domain-specific-language, XSLT is fairly easy to compose in such a way that it is robust against hard failures entailing threats such as data exfiltration or even denial of service. Unless you provide your own code to these code bases, the worst they will be capable of will be "GIGO" (garbage-in-garbage-out) symptomized by incoherent layout and/or data "dumps" to your screen.

## License and dependencies

Code here all runs in your browser with no runtime dependencies except as noted per demonstration. Code is developed as Typescript and compiled and tested under Node JS.

A license is given in the LICENSE.md file.

## Contact info

This project is maintained by Wendell Piez, NIST ITL/CSD (Information Technology Lab, Computer Security Division). Please contact w e n d e l l p i e z [at] n i s t . g o v.

Additionally please open or respond to Issues in this Github repository.

## Cite this work

Piez, Wendell. XSLT Blender. US National Institute of Standards and Technology (NIST), 2022. https://github.com/usnistgov/xslt-blender.

## Next to do

- [ ] further explore unit testing (mocha/chai)
- [ ] build unit tests
