
   async function filterAndShowFiles(fileSet) {
      for (const eachFile of fileSet) {
        const maybeHTML = await fileHTMLContent(eachFile);
        const asText    = await fileTextContent(eachFile);
        let aDocument = new Document();
        aDocument.appendChild(maybeHTML.body);
        document.getElementById("literalIn").value = asText;
        return viewAndShowReduction(aDocument);
      }
    }

    function filterAndShowText(markupText) {
        const aParser = new DOMParser();
        const maybeHTML = aParser.parseFromString(markupText, "text/html");
        return viewAndShowReduction(maybeHTML);
    }

    /* async function filterAndShowHTMLFiles(fileSet) {
      for (const eachFile of fileSet) {
        const maybeHTML = await fileHTMLContent(eachFile);
        if (maybeHTML) {
          viewAndShowHTMLtags(maybeHTML, "counter-top");
        }
      }
    } */


    async function viewAndShowReduction(HTMLDocument) {
      // a pipeline through two XSLTs
      const reducerXSLTEngine = await xsltEngineForHREF('html-reducer10.xsl');
      const tagWriterXSLTEngine = await xsltEngineForHREF('write-xml10.xsl');
      const markdownWriterXSLTEngine = await xsltEngineForHREF('html-to-markdown.xsl');

      // primary result of filtering
      const reducedHTML = await xslt1ResultDocument(HTMLDocument, reducerXSLTEngine); // a promise

      // secondary results rewriting the primary
      // maybe we can avoid another transformation? const taggedHTML = await reducedHTML.firstChild.innerHTML;
      const taggedHTML = await xslt1ResultDocument(reducedHTML, tagWriterXSLTEngine); // a promise
      const markdownFormatted = await xslt1ResultDocument(reducedHTML, markdownWriterXSLTEngine); // a promise
      // console.log(reducedHTML);
      spliceIntoPage("literalOut", taggedHTML, true);
      spliceIntoPage("renderedOut", reducedHTML, true);
      spliceIntoPage("markdownOut", markdownFormatted, true);

      document.getElementById("panels").classList.remove('unpopulated');
    }
  
    const clearPage = () => {

      document.getElementById("literalIn").value = "";

      let targets = ['literalOut','renderedOut','markdownOut']
      targets.forEach( (e) => {
        let clearing = document.getElementById(e);
        while ( clearing.firstChild && clearing.removeChild(clearing.firstChild) );   
      });    

     /* const clearing = document.getElementById('literalIn');
     while ( clearing.firstChild && clearing.removeChild(clearing.firstChild) ); */
     document.getElementById("panels").classList.add('unpopulated');
     /* clearElementByID("literalOut");
     clearElementByID("renderedOut");
     clearElementByID("markdownOut"); */
       let emptyList = new DataTransfer();
       let noFiles = emptyList.files;
       document.getElementById("loadFile").files = noFiles;

     }

     /* reads text out of an element, provides it to a download link and clicks it */
    function offerDownload(elemID, mimeType) {
      const contents = document.getElementById(elemID).textContent;
      const f = new Blob([contents], { type: mimeType });
      const a = document.createElement("a");
      a.href = URL.createObjectURL(f);
      a.download = ( mimeType === "text/plain") ? "cleanedUp.md" : "cleanedUp.html";
      a.click()
      /* window.alert('boo!') */
    }

    /* selects textarea#linkcopy and copies it to the system clipboard */
    function copyToClipboard(whoToCopy) {
      const copyToCopy = document.getElementById(whoToCopy);
      // to select text ...
      window.getSelection().selectAllChildren(copyToCopy);
      document.execCommand('copy');
    }
