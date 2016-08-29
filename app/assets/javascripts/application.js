// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
//
//= require jquery/jquery-2.1.1.js
//= require jquery_ujs
//= require bootstrap-sprockets
//= require pace/pace.min.js

function copyToClipboard(element) {
    var $temp = $("<input>");
    $("body").append($temp);
    console.log(element);
    $temp.val(element.val()).select();
    document.execCommand("copy");
    $temp.remove();
}

$(document).ready(function(){
  $('#menu-btn').click(function(){
    if ($( "#flex-sidebar" ).hasClass( "full" )){
        $( "#flex-sidebar" ).removeClass( "full" ).addClass( "minimized" );
        $( "#content" ).removeClass( "minimized" ).addClass( "full" );
      }
    else{
        $( "#flex-sidebar" ).removeClass( "minimized" ).addClass( "full" );
        $( "#content" ).removeClass( "full" ).addClass( "minimized" );
    }
  });
  $("#copy").click(function(){
    copyToClipboard($("#link-1"));
  });
});
