//= require iCheck/icheck.min.js
//= require jquery-ui/jquery-ui-1.10.4.min.js
//= require fullcalendar/moment.min.js
//= require fullcalendar/fullcalendar.min.js
//= require peity/jquery.peity.min.js
$(document).ready(function (e) {
  var detailedContainer = $("#detailed-user");
  $("#team_search").on("ajax:complete", function (e, data, status, xhr) {
  	console.log($(data.responseText));
  	$('.table.table-striped.table-hover').find('tbody').html($(data.responseText));
  })
  $(".users-list").find("a").click(function(e){
    var elem = (e.target.nodeName != "A")? $(e.target.parentNode) : $(e.target);
    detailedContainer.load(elem.attr('href') + ".partial");
    console.log(elem);
    return false;
  });

})
