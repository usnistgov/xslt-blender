# XSLT Blender

A library of XML/XSLT functionality for execution in a browser, illustrated through demonstrations.

See the portal page for the demonstrations. There is a single portal (maintained in XML) but each demonstration is largely self-contained. Come back here for code.

## Aims

This code base is intended to support development of lightweight client-side web applications exploiting the XML/XSLT capabilities currently offered as standard in browsers, starting with XSLT 1.0.

Elsewhere on line we have some beautiful demonstrations of XSLT 3.0 using the SaxonJS library, developed within the context of the OSCAL project. Applications here are not limited to OSCAL (though not exclusive either). At time of writing all the demonstrations use exclusively XSLT 1.0; that is, they run without any third-party libraries.

In general, applications here will process XML with XSLT. Depending on the application in questions, the XML may be on the site, elsewhere on the Internet (if permissions obtain), or provided by the user. In most cases, the capability being demonstrated  is implemented in XSLT, delivered by the server as a static page, compiled and applied in your browser.

A noteworthy aspect of this arrangement is that if a file is provided by a user from a local system, it can be accessed and processed *without sharing* with any other application, service or point of contact. No file is uploaded to a server. No file, view or log is retained anywhere after the browser application is terminated.

In these demonstrations the stylesheets are applied by means of a library authored in Typescript and Javascript with as small a footprint as possible, for ease of use, deployment and maintenance. The intent is to make it easy to do things that should be easy, but that require some measure of engineering of pipelines and interfaces, which might be provided by such a library.

All source code, whether Typescript, Javascript or XSLT, is also available for inspection and testing. An isolated runtime (that is, download everything and run it off line) can help demonstrate the integrity of the application.

In the demonstrations, this code base can be exercised to show different kinds of functionality, including "mixed" applications where XSLT is used in conjunction with Javascript or with other Javascript (or Typescript) libraries supporting other functionalities, such as zipping/unzipping.

A particular area of interest is the pipelining of JSON data and integration of JSON data into XML-based pipelines, even using XSLT 1.0.

Use this repository by browsing the code base, trying the examples (as served in a plain web server), then replicating and rewriting them.

Developers who are interested in this code base should consider both

- new applications showing new functionalities
- how you can contribute to building, extending and supporting this

## Rights

Like all NIST work, this software is provided on behalf of the US taxpayer to the public domain, as noted in the [License file](LICENSE.md), provided only that adequate notices of origin and modification are kept intact.

## Why XSLT?

Developed in 1999, XSLT 1.0 remains an excellent prototyping language for lightweight data transformation tasks, including some that may surprise even today.

The language's grown-up version -- XSLT 3.0 is even more capable. But XSLT 1.0 has a peculiar advantage. It's kind of like the cigarette lighter in your car - you had no idea it could be so useful for powering things, and it still works.

Sticking with XSLT 1.0 for demonstrations, code bases can be small and relatively easy to audit. Vulnerabilities of the architecture, specifications and tools are well understood and preventable or mitigable. XSLT processors and their dependencies (such as parsers) have been well tested, and their degree of conformance with the relevant specifications is high.

XSLT 1.0 remains what it was in 1999, but the Internet has grown up around it, and Javascript (more precisely, ECMAScript) in particular is *finally* able to provide the level of support needed to apply XSLT transformation logic flexibly, in a range of different scenarios, to achieve useful data processing operations in the browser, beyond display.

Applications can be written with *no* dependencies on external libraries. XSLT 1.0 is supported natively in the browser. If the feature set or capabilities of XSLT 3.0 are needed, a single dependency suffices, [SaxonJS](https://www.saxonica.com/saxon-js/index.xml), which additionally offers a range of features supporting integration, application and interface development.

XSLT applications are perfect for implementing along the lines of the [Rule of Least Power](https://www.w3.org/2001/tag/doc/leastPower.html). When a code base is small, and the boundaries of its yard (its domain of capability) are well marked, there is less to go wrong.

## Development Model

This codebase started a secondary ("spinoff") project with the purpose of making code available for reuse. Developed for internal projects or use at NIST, these projects are published here for the use of the public and by developers who can build on its foundations or study it as a model. Contribute to this project by offering positive commentary and feedback ([tell us what is working](https://github.com/usnistgov/xslt-blender/issues/new)). New ideas for projects or feature requests will be considered and taken up based on the generality of the need and the closeness of the use case. Of course, the repository is also designed to be improved on in your fork.

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

This project is maintained by Wendell Piez, NIST ITL/CSD (Information Technology Laboratory, Computer Security Division). Please contact w e n d e l l p i e z [at] n i s t . g o v.

Additionally please open or respond to Issues in this Github repository.

## Cite this work

Piez, Wendell. XSLT Blender. US National Institute of Standards and Technology (NIST), 2022. https://github.com/usnistgov/xslt-blender.

## Next to do

- [ ] update readmes in project directories
- [ ] further explore unit testing (mocha/chai)
- [ ] build unit tests
