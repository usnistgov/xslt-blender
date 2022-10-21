
## Testing

See the [[Architecture]] and [[Assessment]] wiki pages for background related to testing.

This page describes in general the testing that has been done, while the wiki describes methods for testing as part of assessment and offers advice for assessing XSLT.

### Typescript / Javascript library

## Scope of functionality

The W3C DOM Level 4 API to XSLT is used as an interface to a built-in XSLT engine that comes with your browser. [Mozilla API documentation]https://developer.mozilla.org/en-US/docs/Web/API/XSLTProcessor) includes some coverage.

The engine used will depend on the browser and possibly its configuration. Within a XSLT, the engine and supported version can be reported by evaluating xsl:system-property values.

## Audits / code review

### XSLT functionality

Note that functionality of an XSLT transformation can and must be tested entirely independently of the application stack. This is because as a "least-powered", declarative language with limited (and traceable) capability for producing system side effects [XXX link to further description], XSLT 1.0 is relatively easy to secure (at least in comparison to fully expressive 3GL languages such as Java or Javascript) from system execution exploits.

We limit ourselves to XSLT 1.0 for several reasons:

- The viability for client-side XSLT 3.0 in similar applications is already being shown
- In contrast to other options, the actual capabilities of XSLT 1.0 (an obsolete or obsolescent technology) has arguably *never* been widely understood (despite [repeated demonstration](https://www.balisage.net/Proceedings/topics/XSLT.html)), due to the immaturity of Javascript support for on-the-page XSLT infrastructure until recently (e.g. lack of support for asynchronous resource calls)
- While they deliver functionality, demonstrations can serve as useful and instructive examples for data processing systems in miniature - small models, open to emulation and study.

This makes it easy to assess since XSLT 1.0 has very limited capabilities for system interaction, and such capabilities as it has are tracable -- meaning risks are knowable and discoverable. (See the [[Vulnerabilities]] page.) Unlike Javascript, for example, XSLT cannot use http POST or PUT, cannot interact directly with the interface, and operates "statelessly", that is, its results being derived from its inputs deterministically. By default, it does nothing with data but 'dump' it, and the application does nothing with a dump but display it. For a display application this is a safe default. For applications that work on unsafe inputs (such as for example HTML or SVG inputs containing raw, executable script), it enforces sanitization by design.

### Typescript code review

The developer is seeking code review from colleagues and interested users. Informal code reviews have already been conducted.

## XSpec unit testing

An individual project may have XSpec unit tests for testing parts or all of the processing pipelines or mappings offered in the application. However, the failure of these tests shows only the failure of code to conform to specs given (in or for the tests). Following the "garbage in / garbage out" principle, no contract can be made regarding anomalous inputs. So testing the XSLT itself is far less useful and indicative than screening inputs for quality. Evaluate the quality and extensiveness of the XSpec given in the context of the application.

Note as above there is a very low risk of any effects from XSLT bugs beyond runtime hangs (page freezes), at worst, or most likely simply defective results.

## Input data quality testing


## Audits

XSLT is an easy language to audit by experienced practitioners

Tools to support auditing XSLT are also planned as demonstration projects.

### Application development and testing

"tested under load" with sample data

tested across browsers before deployment

## Layered architecture and least power

See the wiki, for example the page on [[Controls]].
