# XSLT Blender

A library of XML/XSLT functionality for execution in a browser, illustrated through demonstrations.

See the [XSLT Blender Portal](https://pages.nist.gov/xslt-blender) page for the demonstrations. There is a single portal (maintained in XML) and a library of scripts, with each demonstration adding its own capabilities and customizations. 

This repository contains source code for both library and demonstrations, as well as project documentation. Projects will describe themselves both in demonstration and with their own README files.

Also see [the project wiki](https://github.com/usnistgov/xslt-blender/wiki) for more detailed and extensive coverage.

## Aims and background

This code base is intended to support development of lightweight client-side web applications exploiting the XML/XSLT capabilities currently offered as standard in browsers, starting with XSLT 1.0.

Developed originally for internal projects or for use at NIST, these projects are published here for the use of the public and by developers who can build on its foundations or study it as a model. Contribute to this project by offering positive commentary and constructive feedback ([tell us what is working](https://github.com/usnistgov/xslt-blender/issues/new)). New ideas for projects or feature requests will be considered and taken up based on the generality and acuteness of the need and the closeness of the use case. The repository is also designed to be improved on in your fork.

Elsewhere on line, impressive demonstrations of the current technology (XSLT 3.0) are available using the SaxonJS library from [Saxonica](https://saxonica.com/saxonjs/). At NIST some of these capabilities have been shown in the context of the [OSCAL project](https://pages.nist.gov/oscal-tools/demos/csx/). XSLT Blender applications are not limited to OSCAL (though not exclusive of it either). At time of writing all the demonstrations on the site (and available through the [portal page](https://www.github.com/usnistgov/xslt-blender)) use exclusively XSLT 1.0 as distributed with the browser (as a DOM Level 4 feature); that is, they run without any support from third-party libraries.

In general, applications here will process XML with XSLT. Depending on the application, the XML may be provided on the site, accessed from elsewhere on the Internet (when permissions obtain), or provided by the user. In most cases, the capability being demonstrated is implemented in XSLT, delivered by the server as a resource (asynchronously, in the background), and compiled and applied dynamically in your browser.

A noteworthy aspect of this arrangement is that if a file is provided by a user on their local system, it can be accessed and processed *without exposure* to any other application, service or point of contact. No file is uploaded to a server. No file, view or log is retained anywhere after the browser application is terminated. (A hosting page may do any of these things but the application itself will not.)  Once the server has delivered a functional payload (host page and transformations specifications, aka stylesheets in XSLT), no data is passed across the network connection, instead residing entirely within the user's browser runtime, and disappearing with it.

In these demonstrations the stylesheets are applied by means of a library authored in Typescript and Javascript with as small a footprint as possible, for ease of use, deployment and maintenance. The intent is to make it easy to do things that should be easy, but that require some measure of engineering of pipelines and interfaces, which might be provided by such a library.

All source code, whether Typescript, Javascript or XSLT, is also available for inspection and testing. An isolated runtime (that is, download everything and run it off line) can help demonstrate the integrity of the application.

In the demonstrations, this code base can be exercised to show different kinds of functionality, including mixed applications where XSLT is used in conjunction with Javascript or with other Javascript (or Typescript) libraries supporting other functionalities, such as zipping/unzipping.

A particular area of interest is the pipelining of JSON data and integration of JSON data into XML-based pipelines, even using XSLT 1.0.

Use this repository by browsing the code base, trying the examples (as served in a plain web server or in the [portal](https://www.github.com/usnistgov/xslt-blender)), then replicating and rewriting them.

Developers who are interested in this code base should consider both

- new applications showing new functionalities
- how you can contribute to building, extending and supporting this project or this approach

## Rights

As work product of the National Institute for Standards and Technology (NIST), this software with its documentation is placed into the public domain, as noted in the [License file](LICENSE.md), and is free for use provided that adequate notices of origin and modification are kept intact.

When you adapt this code please remove any NIST-identifying boilerplate text or branding from page views. While your site should retain appropriate credits, we cannot be responsible for misrepresentations and we expect you not to be.

### Licensing statement

A current statement of licensing applicable to this software appears here: 
https://www.nist.gov/open/license#software

Transcribed September 2022:

> NIST-developed software is provided by NIST as a public service. You may use, copy, and distribute copies of the software in any medium, provided that you keep intact this entire notice. You may improve, modify, and create derivative works of the software or any portion of the software, and you may copy and distribute such modifications or works. Modified works should carry a notice stating that you changed the software and should note the date and nature of any such change. Please explicitly acknowledge the National Institute of Standards and Technology as the source of the software. 
>
> NIST-developed software is expressly provided "AS IS." NIST MAKES NO WARRANTY OF ANY KIND, EXPRESS, IMPLIED, IN FACT, OR ARISING BY OPERATION OF LAW, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND DATA ACCURACY. NIST NEITHER REPRESENTS NOR WARRANTS THAT THE OPERATION OF THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE, OR THAT ANY DEFECTS WILL BE CORRECTED. NIST DOES NOT WARRANT OR MAKE ANY REPRESENTATIONS REGARDING THE USE OF THE SOFTWARE OR THE RESULTS THEREOF, INCLUDING BUT NOT LIMITED TO THE CORRECTNESS, ACCURACY, RELIABILITY, OR USEFULNESS OF THE SOFTWARE.
>
> You are solely responsible for determining the appropriateness of using and distributing the software and you assume all risks associated with its use, including but not limited to the risks and costs of program errors, compliance with applicable laws, damage to or loss of data, programs or equipment, and the unavailability or interruption of operation. This software is not intended to be used in any situation where a failure could cause risk of injury or damage to property. The software developed by NIST employees is not subject to copyright protection within the United States.

## Why XSLT?

Released in 1999, [XSLT 1.0](https://www.w3.org/TR/1999/REC-xslt-19991116) remains an excellent language for data transformation tasks, including some that may surprise even today.

The language's grown-up version -- [XSLT 3.0](https://www.w3.org/XML/Group/qtspecs/specifications/xslt-30/html/) -- is even more capable. But XSLT 1.0 has a peculiar advantage. Not unlike an AC power port in your car, you may not even know it is there, but it turns out to be useful and versatile.

### Why XSLT 1.0?

We limit ourselves to XSLT 1.0 for several reasons:

- The viability for client-side XSLT 3.0 supporting applications -- more than one, considerably more ambitious -- is already being shown
- In contrast to other options, the actual capabilities of XSLT 1.0 have arguably *never* been widely understood (despite [repeated demonstration](https://www.balisage.net/Proceedings/topics/XSLT.html)), due in part to the immaturity until recently of Javascript support for resource handling in support of on-the-page XSLT infrastructure (e.g., asynchronous web and file system interaction)
- By delivering functionality, demonstrations can serve as useful and instructive examples for data processing systems in miniature - small models, open to emulation and study
- XSLT 1.0's limitations make it easier to deploy and use securely (see [Testing](Testing.md) along with wiki pages on [Assessment](https://github.com/usnistgov/xslt-blender/wiki/Assessment) and [Controls](https://github.com/usnistgov/xslt-blender/wiki/Controls))

Sticking with XSLT 1.0 for demonstrations, code bases can be small and relatively easy to audit. [Vulnerabilities]((https://github.com/usnistgov/xslt-blender/wiki/Vulnerabilities)) of the architecture, specifications and tools are well understood and preventable or mitigable. XSLT processors and their dependencies (such as parsers) have been well tested, and their degree of conformance with the relevant specifications is high.

XSLT 1.0 remains what it was in 1999, but the Internet has grown up around it, and Javascript (more precisely, ECMAScript) in particular is *finally* able to provide the level of support needed in web pages, to orchestrate transformations and interactions together. Using modern Javascript we are able to deploy asynchronous, defensible subroutines for acquiring resources and applying transformation logic flexibly, in a range of different scenarios, to achieve useful data processing operations in the browser, supporting display and interactivity.

Entire (albeit small and simple) applications can be written with *no* dependencies on external libraries. The basic capability that XSLT offers -- casting data from one descriptive format into another at arbitrary levels of granularity, while retaining structure and organization -- is simple, difficult to abuse or break, yet flexible in use, making XSLT applications well-suited to following the [Rule of Least Power](https://www.w3.org/2001/tag/doc/leastPower.html). When a code base is small, and the boundaries of its yard (its domain of capability) are well marked, there is less to go wrong. Hence the site tagline, "Least Power, Greatest Effect".

This also makes this project suitable for "weightless technology transfer" as described on the [project wiki page](https://github.com/usnistgov/xslt-blender/wiki/Technology-Transfer).

### Project origins

This work is informed by daily and weekly practice with XSLT, and inspired by research by Will Thompson and Katherine Ford (as by XSLT practitioners everywhere):

- Ford, Katherine, and Will Thompson. “An Adventure with Client-Side XSLT to an Architecture for Building Bridges with Javascript.” Presented at Balisage: The Markup Conference 2018, Washington, DC, July 31 - August 3, 2018. In *Proceedings of Balisage: The Markup Conference 2018*. Balisage Series on Markup Technologies, vol. 21 (2018). https://doi.org/10.4242/BalisageVol21.Thompson01.

## Repository Contents

### Repo configuration

- CODEMETA.yaml
- CODEOWNERS
- CODE_OF_CONDUCT.md
- CONTRIBUTORS.md
- LICENSE.md
- TESTING.md
- fair-software.md

### NodeJS configuration

- package-lock.json
- package.json
- tsconfig.json

### Site CSS

- nist-boilerplate.css
- nist-combined.css (copied from https://pages.nist.gov/nist-header-footer/css/)

### Portal landing page

- index.html

### Projects directory and supporting files

- directory.xml
- list-projects.xsl
- projects-html.css
- projects-page.xsl

### Projects

See directories

- [JSON Mixer](json-mixer) - can we do something (anything) with JSON in XSLT 1.0? yup
- [STS Viewer](sts-viewer)

(... and others to come ...)

### Source and compiled Typescript

- Sources in `src`
- Compiled Typescript and Javascript goes into `lib`
- Additionally, projects may have their own Javascript libraries

### Site and project documentation

- Miscelleneous files in `docs`

### This file

- README.md

## Installation

The repository presents a set of web browser-based demonstrations, as embedded in (delivered by) a plain web site, with no back end or dynamic capability. They can be installed to run locally. Such an installation is also a [testbed for development](#serving-a-testbed-site) (below) inasmuch as the site administrator can easily modify, extend, add and replace applications or parts of applications.

When serving your derived XSLT Blender framework, take care to provide its exterior ("dress") with new design that distinguishes it as your work, especially removing all NIST- or distributor-related branding or indicators including (but not limited to) logos, headers and footers, font settings, theme colors and page links, replacing them with your own. License notices should retain acknowledgements of upstream contributors: you should not appropriate or "borrow" their (our) design, so changes to site-level CSS and hosting pages will be necessary for you to publish a clone in good faith, while proper credits are always acceptable. As the goal of XSLT Blender is to provide a platform for application development, such refurbishment can be considered a first step in local customization and extension. Congratulations and welcome.

### Serving from localhost

For development and testing, and for additional assurance of data security, the demo site with all its applications can be served directly and viewed on `localhost` (see below) for "clean room" use, with no connection to the open Internet.

To install (globally) and then run a server in node js, for example:

```
$ npm install -g http-server
[... some good stuff ...]
$ http-server
```

This will start a web server on port 8080. Pointing your browser to localhost will load the demonstration site:

http://localhost:8080

A page will show. XSLT Blender functionality can be confirmed by proceeding to load the directory and navigate.

### Serving on the web

XSLT Blender Applications can also be served directly on the web, or pushed into a Github or Gitlab Pages site (such as what you might be reading), or other repository host, for wide availability.

XSLT Blender can also be integrated with static site generators like Jekyll and Hugo, for the best of multiple possible worlds.

For more guidance in this area please make inquiries.

## Development Model

Since these are client-side applications intended to be run in far-away environments, the development model relies on standards and simplicity to help ensure operations. Relevant standards -- XML, XSLT, CSS, occasionally others -- make it easy to do what would be hard, and possible to do what would be impossible.

A project will typically be built by:

- designing a conceptual model of a functional interface for XML/XSLT
- deploying a prototype coded by hand (HTML/Javascript) calling XSLT over XML sources
- iteratively develop the (XSLT) transformation along with with user interface

Over time, projects will show a range of different approaches and user interface capabilities, which can be borrowed, reused, and refined.

### Project design

See the page on [Architecture](https://github.com/usnistgov/xslt-blender/wiki/Architecture) for a schematic of a typical project along with more information on project design.

By inspecting source code -- both statically and running in a demo -- an analyst should be able to determine the components of any given project. Demonstrations should be self-explanatory, assuming relevant background knowledge. Please do research or make inquiries!

- Declarative markup
- XML and XSLT

Scripting and application logic used in this site falls into four categories:

- The 'XSLT Blender' library (Typescript in `src` compiled into `lib`) provides generalized interfaces for XML and XSLT capabilities.
- Per demonstration, XSLT provides the *layering* that gets content into the browser, typically via a 'cast' or mapping into HTML for a defined tag set or vocabulary.
- CSS applied to the page can then style this further - both CSS per demonstration, and site-wide CSS are used
- Javascript (lightweight, self-contained) may also be deployed to provide demonstrations with interactivity on the page

This describes the general pattern: in the case of individual demonstrations, it may be muddied or complicated by special requirements. For example, there may be more than one XSLT transformation, or none at all for a CSS-only project. A code base may be fairly large and complex, or quite small. A small code base may do useful things with large data sets. Etc.

To compile Typescript libraries from source, nodeJS and npm are assumed. But for many purposes this will not be necessary.

### Compiling

The latest `lib` outputs will be pushed to the repository, so you only have to compile from source if you modify or extend the library.

In the project subdirectory, enter `npm install` to install or reinstall the Typescript configuration.

Source code is in `src`. This is all Typescript compiled on NodeJS, so (with Typescript installed) `tsc` to produce Javascript runtime libraries, saved in `lib` and also open for inspection.

Note that applications have full access to XSLT without having to modify the libraries that are used to invoke transformations. Compiling the Typescript source (or writing, testing and deploying Javascript) is not necessary to code or extend any application, unless they go beyond the transformation (mapping) requirements ably addressed by XSLT.

### Serving a testbed site

As they are designed to be delivered over the Internet using a browser, for application it is often convenient to run a server locally, enabling a tight loop between code revision and execution. This in turn makes deployment easy, since it amounts to copying.

As [noted above](#serving-from-localhost), with NPM, start a local server by opening a Linux/WSL prompt in the `xslt-blender` directory, and invoking `npm serve`, or simply `http-server` with that npm module installed.

Or run a vanilla web server using the `http` server of your choice.

Point your browser at `index.html` or the landing page of any demo, as served on `localhost` or the address of your server.

### Coding and testing XSLT

With a site up and running, XSLT can be tested directly in the application. You may need a way to empty files from your cache or supress caching. XSLT can also be developed and tested in offline editing or coding environments, with representative sample inputs.

Applications are typically tested by development under load with representative sample documents (including representations of 'pathological' inputs).

See [TESTING](./TESTING.md) for more about testing and the kinds of testing performed. See the [Assessment](https://github.com/usnistgov/xslt-blender/wiki/Assessment) page on the wiki for information about second- and third-party assessment, both for functional testing and for security.

Note that XSLT applications (and declarative XML applications in general) are built in accordance with the security principle of "Least Power". As a domain-specific-language, XSLT is robust against hard failures entailing threats such as data exfiltration or denial of service. Unless you provide your own code to these code bases, the worst they will be capable of will be "GIGO" (garbage-in-garbage-out) symptomized by incoherent layout, dropped contents or data "dumps" to your screen -- or in extreme cases (with stylesheets not properly tested), by suspending your browser.

By design, XSLT 1.0 is specifically limited. If as a developer you find yourself pushing the edges of its capabilities, consider using XSLT 3.0, a considerably more powerful language build on the same functional processing paradigm.

## Dependencies and licenses

Code here all runs in your browser with no runtime dependencies except as noted per demonstration. Particular demonstrations may carry license information as required (see their respective readmes).

## Contact info

This project is maintained by Wendell Piez, NIST ITL/CSD (Information Technology Laboratory, Computer Security Division), Secure Systems and Applications Group. Please contact w e n d e l l (dot) p i e z (at) n i s t (dot) g o v.

Additionally please feel free to open or respond to [Issues in this Github repository](https://github.com/usnistgov/xslt-blender/issues) or to contact the developer in public forums.

## Cite this work

Piez, Wendell (2022), XSLT Blender, US National Institute of Standards and Technology (NIST), https://doi.org/10.18434/mds2-2813.
