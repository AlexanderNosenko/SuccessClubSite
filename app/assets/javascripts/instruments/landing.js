//= require iCheck/icheck.min.js
//= require jquery-ui/jquery-ui-1.10.4.min.js
//= require fullcalendar/moment.min.js
//= require fullcalendar/fullcalendar.min.js
//= require peity/jquery.peity.min.js
$(document).ready(function (e) {
  var detailedContainer = $("#detailed-landing-info");
  // $("#member-search").on("ajax:complete", function (e, data, status, xhr) {
  // 	console.log($(data.responseText));
  // 	$('#partners').html($(data.responseText));
  // })
  // $("#landings").find(".nasu").click(function(e){
  //   //var elem = (e.target.nodeName != "A")? $(e.target.parentNode) : $(e.target);
  //   var text = $(e.target).attr('data-link');
  //   detailedContainer.load(text + ".partial");
  //   //console.log(elem);
  //   return false;
  // });

  
  $('#landings').find(".moreinfo").find('a').click(function (e) {
    e.preventDefault();
    var elem = (e.target.nodeName != "A")? $(e.target.parentNode) : $(e.target);
    var text = elem.attr('href');
    detailedContainer.load(text + ".partial");
    alert(text);
    console.log(e.target);
    return false;
  });
  // $('.tabsbtns').click(function(){
  //   if (!$(this).hasClass( "disabled" )) {
  //     $( ".tabsbtns" ).removeClass( "active" );
  //     $(this).addClass( "active" );
  //   }
  // });
})
