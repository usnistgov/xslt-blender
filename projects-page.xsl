<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="1.0">
    
    
    <!--XSLT 1.0 stylesheet suitable for browser use -->
    
    <xsl:template match="/*">
        <html lang="en">
            <head>
                <title>XSLT Blender Demonstrations</title>
                <link href="projects-html.css" rel="stylesheet" type="text/css"/>
                
                <link rel="stylesheet" href="nist-boilerplate.css" type="text/css" />
                
                <link rel="stylesheet" href="nist-combined.css"/>
                <xsl:call-template name="script"/>
                
            </head>
            <body>
                <xsl:call-template name="nist-head"/>
                <main id="main" class="directory">
                    <h1>XSLT Blender Demonstrations</h1>
                    <xsl:apply-templates/>
                </main>
                <section class="project-footer">
                    <p><i>XSLT Blender</i> is Javascript and XSLT together. Disclaimers apply; no warranty can be assumed.</p>
                    <p>See the code and contact the developers in the <a href="https://github.com/usnistgov/xslt-blender">project repository</a>.</p>
                </section>
                <xsl:call-template name="nist-foot"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:include href="list-projects.xsl"/>
    
    <xsl:template name="script">
        <!--<script>
            function showSource(relPath) {
              window.location = showSourceHREF(relPath);
              // console.log(showSourceHREF(relPath));
            }
            
            function showSourceHREF(relPath) {
              thereURL = new URL(relPath,document.location);
              return "view-source:" + thereURL.href;
            }
        </script>-->
    </xsl:template>
    
    
    <xsl:template name="nist-head">
        <div id="nistheadergoeshere">
            <header class="nist-header" id="nist-header" role="banner">

                <a href="https://www.nist.gov/"
                    title="National Institute of Standards and Technology"
                    class="nist-header__logo-link" rel="home">
                    <svg aria-hidden="true" class="nist-header__logo-icon" version="1.1"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="32"
                        viewBox="0 0 24 32">
                        <path
                            d="M20.911 5.375l-9.482 9.482 9.482 9.482c0.446 0.446 0.446 1.161 0 1.607l-2.964 2.964c-0.446 0.446-1.161 0.446-1.607 0l-13.25-13.25c-0.446-0.446-0.446-1.161 0-1.607l13.25-13.25c0.446-0.446 1.161-0.446 1.607 0l2.964 2.964c0.446 0.446 0.446 1.161 0 1.607z"
                        />
                    </svg>
                    <svg class="nist-header__logo-image" version="1.1"
                        xmlns="http://www.w3.org/2000/svg" viewBox="-237 385.7 109.7 29.3">
                        <title>National Institute of Standards and Technology</title>
                        <g>
                            <path class="st0"
                                d="M-231,415h-6v-23.1c0,0,0-4.4,4.4-5.8c4-1.3,6.6,1.3,6.6,1.3l19.7,21.3c1,0.6,1.4,0,1.4-0.6v-22h6.1V409
                            c0,1.9-1.6,4.4-4,5.3c-2.4,0.9-4.9,0.9-7.9-1.7l-18.5-20c-0.5-0.5-1.8-0.6-1.8,0.4L-231,415L-231,415z"/>
                            <path class="st0"
                                d="M-195,386.1h6.1v20.7c0,2.2,1.9,2.2,3.6,2.2h26.8c1.1,0,2.4-1.3,2.4-2.7c0-1.4-1.3-2.8-2.5-2.8H-176
                            c-3,0.1-9.2-2.7-9.2-8.5c0-7.1,5.9-8.8,8.6-9h49.4v6.1h-12.3V415h-6v-22.9h-30.2c-2.9-0.2-4.9,4.7-0.2,5.4h18.6
                            c2.8,0,7.4,2.4,7.5,8.4c0,6.1-3.6,9-7.5,9H-185c-4.5,0-6.2-1.1-7.8-2.5c-1.5-1.5-1.7-2.3-2.2-5.3L-195,386.1
                            C-194.9,386.1-195,386.1-195,386.1z"/>
                        </g>
                    </svg>
                </a>

            </header>
        </div>
    </xsl:template>
    
    <xsl:template name="nist-foot">
        <div id="nistfootergoeshere"><footer class="nist-footer">
            <div class="nist-footer__inner">
                <div class="nist-footer__menu" role="navigation">
                    <ul>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.nist.gov/privacy-policy">Site Privacy</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.nist.gov/oism/accessibility">Accessibility</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.nist.gov/privacy">Privacy Program</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.nist.gov/oism/copyrights">Copyrights</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.commerce.gov/vulnerability-disclosure-policy">Vulnerability Disclosure</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.nist.gov/no-fear-act-policy">No Fear Act Policy</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.nist.gov/foia">FOIA</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.nist.gov/environmental-policy-statement">Environmental Policy</a>
                        </li>
                        <li class="nist-footer__menu-item ">
                            <a href="https://www.nist.gov/summary-report-scientific-integrity">Scientific Integrity</a>
                        </li>
                        <li class="nist-footer__menu-item ">
                            <a href="https://www.nist.gov/nist-information-quality-standards">Information Quality Standards</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.commerce.gov/">Commerce.gov</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.science.gov/">Science.gov</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://www.usa.gov/">USA.gov</a>
                        </li>
                        <li class="nist-footer__menu-item">
                            <a href="https://vote.gov/">Vote.gov</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="nist-footer__logo">
                <a href="https://www.nist.gov/" title="National Institute of Standards and Technology" class="nist-footer__logo-link" rel="home">
                    <img src="https://pages.nist.gov/nist-header-footer/images/nist_logo_brand_white.svg" alt="National Institute of Standards and Technology logo"/>
                </a>
            </div>
        </footer>
        </div>
        </xsl:template>
    
</xsl:stylesheet>