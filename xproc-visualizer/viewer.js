
async function filterAndViewXMLFiles(fileSet, whereToView) {
    for (const eachFile of fileSet) {
      const maybeSTSXML = await fileXMLContent(eachFile);
      if (maybeSTSXML) {
        viewAndShowXML(maybeSTSXML, whereToView);
      }
    }
  }
  
 const clearView = (whereToClear) => {
   const clearing = document.getElementById(whereToClear);
   let emptyList = new DataTransfer();
   let noFiles = emptyList.files;
   while ( clearing.firstChild && clearing.removeChild(clearing.firstChild) );
     document.getElementById("loadSTS").files = noFiles;
   }
