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
- [ ] Code itself is intended for re-use (e.g., in a specific scientific area) or the public is being invited to contribute to it.
  - *Fill out the rest of the form, register your code in MIDAS, and make the code available to the public. (Registering your code in MIDAS allows us to maintain an inventory of our code as required by OMB. One option for releasing your code is to make it public on [https://github.com/usnistgov](https://github.com/usnistgov), which is authorized repository for NIST code and part of an existing IT System Security Plan. For more information on GitHub, see [https://odiwiki.nist.gov/ODI/GitHub.html](https://odiwiki.nist.gov/ODI/GitHub.html).)

----------

## DEVELOPING AND TESTING

- [ ] A testing plan (e.g., unit, integration, acceptance, performance) was developed, followed, and documented. The testing plan and results are available at ____________________________
- [ ] Continuous testing was conducted during updates and new builds.
- [ ] Code includes appropriate IT security and privacy controls. (For more information, see Develop/Test Resources available at [https://inet.nist.gov/adlp/open-access-research-oar/publishinginstructions/publishing-software](https://inet.nist.gov/adlp/open-access-research-oar/publishinginstructions/publishing-software)). (After you create a record for your code in MIDAS and submit it for review, your ITSO will check for security (of software); will look at the method for release of software if it is something other than GitHub; will make sure it does not compromise dependencies (I.e., internal databases or other physical resources to which it is linked).

## DOCUMENTING

Documentation is available as appropriate:

 - [ ] Integrated with the source code
 - [ ] On separate web pages (e.g., www.nist.gov, pages.nist.gov) at URL(s): _________________
 - [ ] In a separate publication at URL(s):_____________________________________________
 - [ ] Other

Documentation includes, as appropriate:

 - [ ] A readme file
 - [ ] Function-level documentation - every file has a description of what it does, whether as documentation in the code or in auxiliary files
 - [ ] Information about how a binary was produced
 - [ ] System requirements and prerequisites (e.g., OS version, memory, dependencies)
 - [ ] Installation instructions
 - [ ] User instructions/guides
 - [ ] API specifications
 - [ ] A changelog file
 - [ ] Specification of maturity level (i.e., is the software still being actively developed, are you expecting feedback on performance and usability, is the project completed)
 - [ ] A communication to users of your intent to provide (or not provide) support

## LICENSES AND DISCLAIMERS

- [ ] NIST license and disclaimers ([https://www.nist.gov/open/copyright-fair-use-and-licensing-statements-srddata-software-and-technical-series-publications](https://www.nist.gov/open/copyright-fair-use-and-licensing-statements-srddata-software-and-technical-series-publications)) included (including commercial product disclaimer, [https://inet.nist.gov/adlp/disclaimers-publications](https://inet.nist.gov/adlp/disclaimers-publications), if necessary)
- [ ] External collaborators who were part of this project been credited
- [ ] Third-party software licenses permit modification and/or redistribution (https://www.gnu.org/licenses/gplfaq.en.html#GPLUSGovAdd)
  - [ ] Appropriate licensing is included
  - [ ] Files modified by NIST contain notice that modifications are released to the public domain as appropriate
  
If you don’t think the standard NIST disclaimers apply, e.g., if NIST has modified software that is available under a different license that must be retained, contact the NIST Office of Chief Counsel for guidance.

## REGISTERING IN THE NIST INVENTORY

 - [ ] Create a record in MIDAS and include
   - [ ] A complete description
   - [ ] A readme file
   - [ ] A link to the software itself

NOTES: The information you provide in the inventory will help users locate your code and decide whether it will be of use to them. Https://github.com/usnistgov is an authorized repository for NIST code, and the GitHub json file goes to code.nist.gov and code.gov; MIDAS json goes to data.gov and data.nist.gov. MIDAS registration results in assignment of a DOI, which you can reference in publications associated with your code.

## ASSOCIATED DATA

The software requires access to data provided by NIST.

 - [ ] A record for the data has been created in MIDAS.
 - [ ] The data is distributed with the code.
 - [ ] The data is made available in a separate published data set.

What NIST system(s) host the data to be accessed? ___________________________________

How will the data be accessed from remote clients (e.g., using what protocols / APIs)? _____________

What coordination is required between the release/update of the software and the maintenance of the data sources? _____________________

Data storage (e.g., location, cost, redundancy, etc.) is being managed by ______________________

Backup and restoration is being managed by ________________

Retention policy ________________________________

NOTE: Data storage, backup, restoration, retention, etc. are managed by OISM if data is uploaded to AWS via MIDAS.

In collaboration with your ITSO, determine the level of security and privacy. For an explanation of how IT security relates to the public availability of NIST data that your code may access, see Order 5701.00, Appendix A, Section IV at [https://inet.nist.gov/adlp/directives/managing-public-access-results-federally-funded-research-0](https://inet.nist.gov/adlp/directives/managing-public-access-results-federally-funded-research-0).)

**Confidentiality**: [LOW]

**Integrity**: [LOW][MODERATE]

**Availability**:  [LOW][MODERATE]

## CODE DISTRIBUTION/PUBLISHING

The software will be available from the following direct link:
 - [ ] Github under the usnistgov organization, repo name _______________________
 - [ ] Github, not usnistgov, repo name _________________________
 - [ ] From the following website: _________________________________
 - [ ] Embedded in another software package ___________________
 - [ ] Other: _______________________________________

 - [ ] Checksum and/or digital signature is present for integrity validation of download

  - [ ] The application is confirmed to be stand-alone and does not include connectivity to any NIST systems other than through publicly accessible APIs.
 - [ ] A mechanism to issue updates is provided (if applicable)
   - [ ] users will not be notified
   - [ ] users will be notified.
 - [ ] Updates will not be issued.

 Code releases are
 - [ ] Versioned; released versions are tagged and changes in the source code are documented in the revision control system
 - [ ] Not versioned

 - [ ] A binary is not available for download.
 - [ ] A binary (i.e., executable file) is available for download from
   - [ ] The following website: _________________________________________________
   - [ ] Embedded in another software package: _______________________________
   - [ ] An app store: ___________________________________________________________
   - [ ] A binary is available for these platforms: ______________________________
   - [ ] Other: ________________________________________________________

 - [ ] The code has dependencies (e.g., services, other software packages, etc.) other than the data previously noted; please specify: _______________________________________________________
 - [ ] A publication describing background for or application of the code is available at: _____________________________________

## MAINTENANCE

 - [ ] A maintenance plan has been approved by my manager

Lifecycle planning:
- Anticipated end of active development: ________
- Anticipated end of active support: __________
- Anticipated date when software should be permanently archived: _______________

 - [ ]  Users are notified of release management (e.g., release cycle, end-of-life, bug fixes) via:  _______________

 - [ ] Security/feature updates of third-party libraries are performed.

Bugs can be reported:
 - [ ] By email/messaging at the following address: ____________
 - [ ] By bug/issue tracker at the following URL: ___________
 - [ ] By other means, explain: _______________

 - [ ] Users cannot report bugs
 
----------
 
Signature of code’s ‘author’/’owner’ _________________________________________
Signature of reviewer ______________________________________
Signature of author’s supervisor________________________________


 


