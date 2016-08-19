//= require flot/jquery.flot.js
//= require flot/jquery.flot.tooltip.min.js
//= require flot/jquery.flot.resize.js
//= require flot/jquery.flot.pie.js
//= require flot/jquery.flot.time.js
//= require flot/jquery.flot.spline.js
//= require sparkline/jquery.sparkline.min.js
//= require chartjs/Chart.min.js
//= require jvectormap/jquery-jvectormap-1.2.2.min.js
//= require jvectormap/jquery-jvectormap-world-mill-en.js


function copyToClipboard(element) {
    var $temp = $("<input>");
    $("body").append($temp);
    console.log(element);
    $temp.val(element.val()).select();
    document.execCommand("copy");
    $temp.remove();
}

$(document).ready(function(){
  $("#copy_first_link").click(function(){
    copyToClipboard($("#first-partner-link-input"));
  });
});
