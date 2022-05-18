# XSLT Blender

A library of XML/XSLT functionality for execution in a browser, illustrated through demonstrations.

Presently in "alpha" state, that is, minimalistic and working towards proof-of-concept.

## Aims

This code base is intended to support development of  lightweight client-side web applications exploiting the XML/XSLT capabilities currently offered as standard in browsers (especially XSLT 1.0).

Code here is authored in Typescript and Javascript but aims to have as small a footprint as possible, for ease of use, deployment and maintenance. The intent is to make it easy to do things that should be easy, but that require some measure of engineering of pipelines and interfaces -- which might be provided by a library.

This code base will be exercised through an informal collection of examples showing different kinds of functionality, including "mixed" applications where XSLT is used in conjunction with Javascript or with other Javascript (or Typescript) libraries supporting other functionalities, such as zipping/unzipping.

A particular area of interest is the pipelining of JSON data and integration of JSON data into XML-based pipelines, using XSLT 1.0.

Another area of interest is specifically [OSCAL](http://pages.nist.gov/OSCAL), the Open Security Controls Assessment Language, including rendering, proofing, and validating applications.

Use this repository by browsing the code base, trying the examples (as served in a plain web server), then replicating and rewriting them.

Depending largely on developer interest, over time more mature support may be offered, in the form of documentation, unit tests, packaging and deployment support.

## Repository Contents

- `pub` subdirectory - an HTML site, maintained by hand with the exception of its `lib` subdirectory. Serve the demonstrations from here.
- `src` Typescript source to be compiled (compiled Javascript goes into `pub`)

## Installation

The `pub` directory presents an entire coherent publication, with navigation, of available demonstrations, as embedded in (delivered by) a plain web site, with no back end or dynamic capability.

It can be served directly and viewed on `localhost`, or bound to a Github or Gitlab Pages site (for example). Because it is a prototype for demonstration, this site is presently *not* hosted on the open Internet.

Demonstrations should be self-explanatory, assuming relevant background knowledge.

To run a server (below) or to compile from source, nodeJS and npm are assumed.

### Serving from localhost

Start a local server by opening a Linux/WSL prompt, switching to `pub` and invoking `npm serve`, or simply `http-server` with that npm module installed.

## License and dependencies

Code here all runs in your browser with no runtime dependencies except as noted per demonstration.
Code is developed as Typescript or native Javascript, and compiled and tested under nodeJS.

A license is given in the LICENSE.md file.

## Contact info

This project is maintained by Wendell Piez, NIST ITL/CSD (Information Technology Lab, Computer Security Division). Please contact w e n d e l l p i e z [at] n i s t . g o v.

Additionally please open or respond to Issues in this Github repository.

## Cite this work

Piez, Wendell. XSLT Blender. US National Institute of Standards and Technology (NIST), 2022. https://github.com/usnistgov/xslt-blender.

## To Do:

- [x] finish README line items
- [x] finish README-template.md line items
- [x] README.md, CODEOWNERS, CODEMETA.yaml
- [x] push
- [ ] test and push minimal installation
  - JSON conversion; file loading and saving 
- [ ] stand up unit testing (mocha/chai)
- [ ] build unit tests
