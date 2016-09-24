//= require iCheck/icheck.min.js
//= require jquery-ui/jquery-ui-1.10.4.min.js
//= require fullcalendar/moment.min.js
//= require fullcalendar/fullcalendar.min.js
//= require peity/jquery.peity.min.js
//= require bootstrap-datepicker
$(document).ready(function (e) {
  $('.datepicker').datepicker();
  $('.tabsbtns').click(function(){
    if (!$(this).hasClass( "disabled" )) {
      $( ".tabsbtns" ).removeClass( "active" );
      $(this).addClass( "active" );
    }
  });
})
