

// See https://docs.mathjax.org/en/latest/web/configuration.html#configuring-and-loading-in-one-script 

window.MathJax = {
  // config goes here
};

(function () {
  var script = document.createElement('script');
  script.src = 'https://cdn.jsdelivr.net/npm/mathjax@3/es5/mml-chtml.js';
  script.async = true;
  document.head.appendChild(script);
})();