//= require bootstrap-datepicker
$(document).ready(function (e) {
  $('.datepicker').datepicker();
  $('.tab-links').click(function(){
    if (!$(this).hasClass( "disabled" )) {
      $( ".tab-links" ).removeClass( "active" );
      $(this).addClass( "active" );
    }
  });
})
