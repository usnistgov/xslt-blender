# CHECKLIST FOR PUBLICATION OF RESEARCH CODE/SOFTWARE

Based on draft of April 27 2022

> Use this checklist to make sure you have considered and addressed everything necessary before publishing source code. (Signature blocks are provided on the final page because your management may require use of this form to indicate that you have considered/addressed everything.)

**Research code/software** is defined in NIST S1801.03 as code developed in the course of NIST research programs, i.e., custom code developed to address specific and unique mission-related research problems. Research code means computer programs that comprise a series of instructions, rules, routines, or statements, regardless of the media in which they are recorded, that allow or cause a computer to perform a specific operation or series of operations. Research code includes binaries, source code, scripts, and software, and these words may be used synonymously in the context of this document and the directives associated with NIST 1801.00.

Deployment of executable software as a service (e.g., the [NIST Uncertainty Machine](https://uncertainty.nist.gov/)) is not considered a fundamental research communication (although release of the source code behind that tool would be) and is not covered by NIST O 1801.00. Software products (as opposed to the source code itself) published on the NIST website (and the content of webpages themselves) are the responsibility of the Public Affairs Office through your Information Coordinator.

If the code was developed under the rules of another organization (e.g., a committee that’s part of a Standards Development Organization), NIST may get credit as a collaborator or co-developer of that software, but NIST policies and review requirements do not apply because the committee itself is the ‘author.’

If you are contributing code to a non-NIST project in a pull request that is subsequently merged into the main branch, there are no NIST review requirements. If you are contributing code as a collaborator on a non-NIST account, NIST policies and review requirements apply.

If this document would benefit from additions or other changes or if you have sample test plans or other documents you would be willing to share, please let us know at [public-access@nist.gov](mailto:public-access@nist.gov).

## HOW DO YOU EXPECT YOUR CODE/SOFTWARE TO BE USED?

The amount of documentation, testing, and support that you should provide will vary depending on its intended use. Your level of effort should be fit for purpose: discuss this with your management, decide what makes sense, then do that. Communicate your intentions to your potential users.

- [ ] Code is informational (e.g., part of the supplemental information in a narrative publication) and not intended for re-use.
  - *Register your code in MIDAS. Provide appropriate instructions for use and fill out the rest of this form if you and your management think it is necessary to provide information that will make the code more useful to others.*
- [x] Code itself is intended for re-use (e.g., in a specific scientific area) or the public is being invited to contribute to it.
  - *Fill out the rest of the form, register your code in MIDAS, and make the code available to the public. (Registering your code in MIDAS allows us to maintain an inventory of our code as required by OMB. One option for releasing your code is to make it public on [https://github.com/usnistgov](https://github.com/usnistgov), which is authorized repository for NIST code and part of an existing IT System Security Plan. For more information on GitHub, see [https://odiwiki.nist.gov/ODI/GitHub.html](https://odiwiki.nist.gov/ODI/GitHub.html).)

----------

## DEVELOPING AND TESTING

- [ ] A testing plan (e.g., unit, integration, acceptance, performance) was developed, followed, and documented. The testing plan and results are available at ____________________________
- [x] Continuous testing was conducted during updates and new builds.
- [ ] Code includes appropriate IT security and privacy controls. (For more information, see Develop/Test Resources available at [https://inet.nist.gov/adlp/open-access-research-oar/publishinginstructions/publishing-software](https://inet.nist.gov/adlp/open-access-research-oar/publishinginstructions/publishing-software)). (After you create a record for your code in MIDAS and submit it for review, your ITSO will check for security (of software); will look at the method for release of software if it is something other than GitHub; will make sure it does not compromise dependencies (I.e., internal databases or other physical resources to which it is linked).

## DOCUMENTING

Documentation is available as appropriate:

 - [x] Integrated with the source code *Each project has its own readme and inline documentation*
 - [x] On separate web pages (e.g., www.nist.gov, pages.nist.gov) at URL(s): *Site presents demonstrations as web pages, each one with its own documentation*
 - [ ] In a separate publication at URL(s):_____________________________________________
 - [ ] Other

Documentation includes, as appropriate:

 - [x] A readme file
 - [ ] Function-level documentation - every file has a description of what it does, whether as documentation in the code or in auxiliary files *tbd*
 - [ ] Information about how a binary was produced *N/A*
 - [x] System requirements and prerequisites (e.g., OS version, memory, dependencies) *Everything is web-browser based*
 - [x] Installation instructions *Ditto*
 - [x] User instructions/guides *Per project as applicable*
 - [ ] API specifications *N/A*
 - [ ] A changelog file
 - [ ] Specification of maturity level (i.e., is the software still being actively developed, are you expecting feedback on performance and usability, is the project completed) *tbd*
 - [x] A communication to users of your intent to provide (or not provide) support

## LICENSES AND DISCLAIMERS

- [x] NIST license and disclaimers ([https://www.nist.gov/open/copyright-fair-use-and-licensing-statements-srddata-software-and-technical-series-publications](https://www.nist.gov/open/copyright-fair-use-and-licensing-statements-srddata-software-and-technical-series-publications)) included (including commercial product disclaimer, [https://inet.nist.gov/adlp/disclaimers-publications](https://inet.nist.gov/adlp/disclaimers-publications), if necessary)
- [ ] External collaborators who were part of this project been credited *N/A*
- [ ] Third-party software licenses permit modification and/or redistribution ([https://www.gnu.org/licenses/gplfaq.en.html#GPLUSGovAdd](https://www.gnu.org/licenses/gplfaq.en.html#GPLUSGovAdd)) *N/A everything is browser based with no external dependencies*
  - [ ] Appropriate licensing is included
  - [ ] Files modified by NIST contain notice that modifications are released to the public domain as appropriate
  
If you don’t think the standard NIST disclaimers apply, e.g., if NIST has modified software that is available under a different license that must be retained, contact the NIST Office of Chief Counsel for guidance.

## REGISTERING IN THE NIST INVENTORY

 - [x] Create a record in MIDAS and include
   - [x] A complete description
   - [x] A readme file
   - [x] A link to the software itself

NOTES: The information you provide in the inventory will help users locate your code and decide whether it will be of use to them. Https://github.com/usnistgov is an authorized repository for NIST code, and the GitHub json file goes to code.nist.gov and code.gov; MIDAS json goes to data.gov and data.nist.gov. MIDAS registration results in assignment of a DOI, which you can reference in publications associated with your code.

## ASSOCIATED DATA

 - [ ] The software requires access to data provided by NIST. *N/A*
   - [ ] A record for the data has been created in MIDAS. *N/A*
   - [ ] The data is distributed with the code. *N/A*
   - [ ] The data is made available in a separate published data set. *N/A*

What NIST system(s) host the data to be accessed? *Demo portal is hosted on [pages.nist.gov](http://pages.nist.gov/xslt-blender)*.

How will the data be accessed from remote clients (e.g., using what protocols / APIs)?  *Applications are served to users' machines via https as self-contained collections of resources including scripting. Users provide their own data for applications for local processing without exposure.*

What coordination is required between the release/update of the software and the maintenance of the data sources? *Applications are designed to fail gracefully on bad inputs, and are isolated inside browser runtime. The project operates under a rolling release, "always complete, always developing" strategy: new applications, features and bug fixes are added by merging code to the project repo for deployment to pages.nist.gov. While there are no versioned releases for the project as a whole, particular demonstrations may be versioned, or track versions of dependent technologies and standards.*

Data storage (e.g., location, cost, redundancy, etc.) is being managed by *the [Github project repository](https://github.com/usnistgov/xslt-blender) and by NIST administrators of pages.nist.gov and github.com/usnistgov* 

Backup and restoration is being managed by *ditto*

Retention policy *ditto*

NOTE: Data storage, backup, restoration, retention, etc. are managed by OISM if data is uploaded to AWS via MIDAS.

### IMPACT LEVELS

In collaboration with your ITSO, determine the level of security and privacy. For an explanation of how IT security relates to the public availability of NIST data that your code may access, see Order 5701.00, Appendix A, Section IV at [https://inet.nist.gov/adlp/directives/managing-public-access-results-federally-funded-research-0](https://inet.nist.gov/adlp/directives/managing-public-access-results-federally-funded-research-0).)

**Confidentiality**: [LOW]

**Integrity**: [LOW]

**Availability**:  [LOW]

## CODE DISTRIBUTION/PUBLISHING

The software will be available from the following direct link:
 - [x] Github under the usnistgov organization, repo name `xslt-blender`
 - [ ] Github, not usnistgov, repo name _________________________
 - [ ] From the following website: _________________________________
 - [ ] Embedded in another software package ___________________
 - [ ] Other: _______________________________________

 - [ ] Checksum and/or digital signature is present for integrity validation of download

 - [x] The application is confirmed to be stand-alone and does not include connectivity to any NIST systems other than through publicly accessible APIs. *No connectivity is required after page resources are downloaded and cached*
 - [x] A mechanism to issue updates is provided (if applicable) *Planning a continuous development update model via Github*
   - [x] users will not be notified *with a passive publication model*
   - [x] users will be notified. *depending on both public announcements, incoming links and word of mouth*
 - [ ] Updates will not be issued.

 Code releases are
 - [x] Versioned; released versions are tagged and changes in the source code are documented in the revision control system
 - [x] Not versioned *Depending on the demonstration or application*

 - [x] A binary is not available for download. *Demonstrations are coded in XSLT, an interpreted language*
 - [ ] A binary (i.e., executable file) is available for download from
   - [ ] The following website: _________________________________________________
   - [ ] Embedded in another software package: _______________________________
   - [ ] An app store: ___________________________________________________________
   - [ ] A binary is available for these platforms: ______________________________
   - [ ] Other: ________________________________________________________

 - [ ] The code has dependencies (e.g., services, other software packages, etc.) other than the data previously noted; please specify: _______________________________________________________
 - [ ] A publication describing background for or application of the code is available at: _____________________________________ *tbd*

## MAINTENANCE

 - [ ] A maintenance plan has been approved by my manager

Lifecycle planning:

- Anticipated end of active development: *2028, depending on project* 
- Anticipated end of active support: *2028*
- Anticipated date when software should be permanently archived: *N/A - already in Github, no?*

 - [ ]  Users are notified of release management (e.g., release cycle, end-of-life, bug fixes) via:  _______________

 - [ ] Security/feature updates of third-party libraries are performed. *tbd - such libraries have been scrupulously avoided - although continuous testing of browser support may be in order*

Bugs can be reported:
 - [ ] By email/messaging at the following address: ____________
 - [x] By bug/issue tracker at the following URL: [https://github.com/usnistgov/xslt-blender/issues](https://github.com/usnistgov/xslt-blender/issues)
 - [ ] By other means, explain: _______________

 - [ ] Users cannot report bugs
 
----------

Signature of code’s ‘author’/’owner’ _________________________________________
Signature of reviewer ______________________________________
Signature of author’s supervisor________________________________

