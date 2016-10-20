$(document).ready(function (e) {
  console.log('s');
  if(window.location.pathname.match(/\/landings$/)){
    $('#tools-choose').modal({
                    backdrop: 'static',
                    keyboard: false
                  }).show();
  }
})
function activate_landing(form){
	business_id = localStorage.getItem("business_id");
	form = $(form);
	if(business_id){
	  var action = form.attr('action');
	  action += '/?business_id=' + business_id
	  form.attr('action', action);
	  localStorage.removeItem("business_id");
	}
	form.submit();
}