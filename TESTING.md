# Testing

Also see the [Assessment](https://github.com/usnistgov/xslt-blender/wiki/Assessment) wiki page for background related to testing, with information on third-party auditing and testing.

This page describes in general the testing that has been done, while the wiki describes methods for testing as part of assessment and offers advice for assessing XSLT.

## Layered architecture and least power

See the wiki, for example the pages on [Architecture](https://github.com/usnistgov/xslt-blender/wiki/Architecture) and [Controls](https://github.com/usnistgov/xslt-blender/wiki/Controls).

The layered architecture of an XML/XSLT-based system makes it possible to "divide and conquer" the testing problem, by helping to discriminate between kinds of testing, to determine which testing approaches provide defense against actual risks, to manage testing, and to isolate issues and bugs. Because the implementation is supported by robust standards including HTML5, DOM, CSS and ECMAScript, commodity tools are used where possible, rendering it possible to concentrate testing efforts effectively.

## System Components

See the [Architecture](https://github.com/usnistgov/xslt-blender/wiki/Architecture) page for details on system components. The summary below describes how different components are tested.

### Commodity display/UI

The browser, with support for ECMAScript, DOM and CSS, provides a commodity tool supporting display and user interactivity. Testing the browser and its conformance to necessary standards is outside the scope of application testing for XSLT Blender, although application development of XSLT Blender pages is itself a test of this platform.

Generally speaking, projects in this repo are tested routinely on Chrome, Firefox, and other browsers, recognizing that several browsers use the same code base.

### Browser support for XSLT

The W3C DOM Level 4 API to XSLT is used as an interface to a built-in XSLT engine that comes with your browser. [Mozilla API documentation]https://developer.mozilla.org/en-US/docs/Web/API/XSLTProcessor) includes some coverage.

By executing a transformation to display a directory, the [XSLT Blender Portal](https://pages.nist.gov/xslt-blender) provides a live test of XSLT 1.0 support via the DOM 4 API, in any browser.

The engine used will depend on the browser and possibly its configuration. Within a XSLT, the engine and supported version can be reported by evaluating `xsl:system-property` values.

### XSLT Blender Typescript / Javascript library

The deployed Javascript library is authored in Typescript from the [src](src) directory and transpiled into Javascript for deployment. Typescript provides defense against many of the kinds of development bugs that plague Javascript applications. Unit testing for Typescript functionality can be 

### Application logic

#### HTML/JS/CSS for UI

Each application has one or more "host" pages in HTML pulling together Javascript (for calling XSLT Blender functions and lightweight UI interaction, and CSS, for styling and dynamic display. These are all tested heavily during development, which basically encompasses an "add/test" continuous enhancement cycle, in which these components are variously built out from a functional core.

#### XSLT logic

For the same reasons, testing XSLT occurs heavily during development "under load". Typically, testing XSLT is also supported with one or more sample XML documents, illustrating potential inputs and the range of potential inputs. In many cases these useful resources for development and maintenance are also committed to the repository.

In appropriate cases, XSpec unit tests may also be provided for XSLT per project, as described below.

## Testing in development

Every application is "tested under load" with sample data as it is developed, according to an agile "spiral" development pattern suited to XSLT.

Applications are also tested across browsers before deployment to ensure consistency.

## Audits / code review

Since all source code is committed to the repository, and applications are self-contained, code audits can be clearly bounded.

### XSLT code review

The xslt-blender libraries and demo applications are currently under development. At this time, rigorous auditing providing for a secure code review has not been performed. Assigned developers of xslt-blender, and colleagues performing code review independent of developers who have implemented a particular feature, make a best attempt effort during code review to identify potential issues, including security issues, to confirm them, and to identify proper mitigations.

Tools to support auditing XSLT are also planned as demonstration projects. How to audit XSLT is not as well understood as it needs to be. Documentation and demonstration tooling may be able to help bridge that gap. Experienced XSLT developers are familiar with[Vulnerabilities](https://github.com/usnistgov/xslt-blender/wiki/Vulnerabilities) of the technology and its dependencies: documenting these is a first step to sharing and generalizing this knowledge.

Functionality of an XSLT transformation can and should be tested independently of the application stack. This is because as a "least-powered", declarative language, XSLT 1.0 is relatively easy to secure from system execution exploits, in comparison to fully expressive 3GL languages such as Java or Javascript.

### Typescript code review

The developer welcomes code review from colleagues and interested users. Informal code reviews have already been conducted.

## Unit testing

### Typescript unit testing

To the extent practical, unit testing is offered for the Typescript function library.

### XSLT unit testing - XSpec

Any project may have [XSpec](https://github.com/xspec/xspec/) unit tests for testing parts or all of the processing pipelines or mappings offered in the application. However, the failure of these tests shows only the failure of code to conform to specs given in or for the tests. Where contracts must be made explicit, for example for function definition, XSpec unit tests can help test the boundaries of the range of possible inputs, and thereby usefully validate the correctness of a code base. For generic mappings of tag sets, however -- the kind of "normal task" of an XSLT, in which specifications are simple, but the number of mappings is potentially higher -- unit testing the XSLT is less useful and productive than testing data "under load" (both representative and "pathological"). Evaluate the quality and extensiveness of the XSpec given in the context of the application.

Note as above there is a very low risk of any effects from XSLT bugs beyond runtime hangs (page freezes), at worst, or most likely simply defective results.

Since these are conformant XSLT 1.0 stylesheets, they can be migrated into a range of environments and frameworks for third-party testing.

## Input data quality testing

For correct behavior in these applications, input quality inevitably makes a difference. Being sure that input data (and many of these applications make use of users' input data) is high quality (XML) is essential for ensuring that an application works as expected and promised.

This is complicated by the fact that applications planned for this site include data quality testing and assessment applications. Data that is "bad" from one point of view (such as for example with respect to schema validation) might be perfectly amenable from another, and the application framework is able to take advantage of XML's definition as a syntax. So even poor quality data can often be processed to some level of success.
