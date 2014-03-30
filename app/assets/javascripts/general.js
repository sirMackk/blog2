$(document).ready(function() {
  hljs.initHighlighting();
  var postContent = document.getElementsByClassName('post');
  if (postContent.length > 0) {
    var beeLine = new BeeLineReader(postContent[0], { theme: 'bright', skipBackgroundColor: true, skipTags: ['pre', 'code', 'h1', 'h2', 'h3', 'h4', 'h5']});
    beeLine.color();
  };
});
