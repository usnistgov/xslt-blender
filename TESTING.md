
## Testing

What does failure mean? Assume (worst case scenario) this project deploys code with bugs in it. What could happen?

* Browser runtime errors resulting in defective page displays. If we deploy an XSLT with errors, you could see red boxes in your output or just empty spots.
* Failure to deliver results ("hang") - again, DOS limited to browser runtime. Assuming we mess up somehow, one of these applications might crash your browser, but not your entire system.
* Delivery of wrong results

what it doesn't mean -

* data exposure or leakage (assuming the browser is secure)
* wider system effects including runaway effects

To the extent that the latter two issues occur at all, they are relatively easy to defend against both by developers and users.

### Typescript / Javascript library

### XSLT functionality

Note that functionality of an XSLT transformation can and must be tested entirely independently of the application stack. This is because as a "least-powered", declarative language with limited (and traceable) capability for producing system side effects [XXX link to further description], XSLT 1.0 is relatively easy to secure (at least in comparison to fully expressive 3GL languages such as Java or Javascript) from system execution exploits.

## XSpec unit testing

## Audits

XSLT is an easy language to audit by experienced practitioners

The site itself aims to provide tools to support auditing XSLT.

### Application development and testing

"tested under load" with sample data

tested across browsers before deployment

## Controls listing

The security posture of an XSLT system must be understood, like all systems, in its operational context.

In other words, how you use it makes all the difference, while at the same time, some simple principles and precautions applied at a deeper level - in the system's design and deployment - can also make a huge difference, by protecting you and your data by default, and by architectural and design features that "build in" data safety (and broader system security), not just something you have to think about.

The following synopsis lists SP 800-53 controls supported, broadly, by these applications, in their design, development and maintenance.

CM-7 Least Functionality
CM-7(6) Confined Environments with Limited Privileges
CM-7(7) Code Execution in Protected Environments
CM-7(8) Binary or Machine Executable Code
  [nb: the control provides for executing code when the source is given, as on this site]
CM-10 Software Usage Restrictions
CM-10(1) Open-source Software

SA-11?

SC-2 Separation of System and User Functionality
SC-6 Resource Availability
SC-7 Boundary Protection
SC-27 Platform-independent Applications
SC-36 Distributed Processing and Storage

SI-10 Information Input Validation
SI-10(3) Predictable Behavior
SI-10(5) Restrict Inputs to Trusted Sources and Approved Formats
