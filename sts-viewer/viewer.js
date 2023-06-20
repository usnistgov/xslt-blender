
async function filterAndViewXMLFiles(fileSet, whereToView) {
    for (const eachFile of fileSet) {
      const maybeSTSXML = await fileXMLContent(eachFile);
      if (maybeSTSXML) {
        viewAndShowXML(maybeSTSXML, whereToView);
      }
    }
  }
  
  function loadGraphic(file,graphicID,expectedName) {
     // const fr = new FileReader();
     const anURL = URL.createObjectURL(file)
     const expect = expectedName.split('/').pop().split('#')[0].split('?')[0];
     const labelClass = ( file.name === expect ? 'aligned' : 'unknown' );
     document.getElementById('label_'+graphicID).classList.add(labelClass);
     document.getElementById(graphicID).src = anURL;
   }

  const viewSection = eID => {
    let who = document.getElementById(eID); 
    let openers = getAncestorDetails(who);
    openers.forEach(o => { o.open = true; } );
    who.scrollIntoView( {behavior: 'smooth'} );
  }
  
  const getAncestorDetails = el => {
    let ancestors = [];
    while (el) {
      if (el.localName === 'details') { ancestors.unshift(el); }
      el = el.parentNode;
    }
    return ancestors;
  }
  
  
 const highlightAside = (fnNo) => {
   const fn = 'fn-' + fnNo;
   const fnr = 'fnref-' + fnNo;
   [fn, fnr].forEach( (e) => { document.getElementById(e).classList.toggle("flashing") } );
 }

 const clearView = (whereToClear) => {
   const clearing = document.getElementById(whereToClear);
   let emptyList = new DataTransfer();
   let noFiles = emptyList.files;
   while ( clearing.firstChild && clearing.removeChild(clearing.firstChild) );
     document.getElementById("loadSTS").files = noFiles;
   }
