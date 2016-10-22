$(document).ready(function (e) {
  if(window.location.pathname.match(/\/landings$/)){
    $('#tools-choose').modal({
                    backdrop: 'static',
                    keyboard: false
                  }).show();
  }
  $('.green-copy-btn').on('click', function (e) {
    console.log($(this).data('url'));
    $('#copy-landing-link').find('#landing-url').val($(this).data('url'));
    $('#copy-landing-link').modal().show();
  });
  $('.edit-landing-settings').on('click', function (e) {
  	var modal_container = $('#edit-landing-settings');
  	// modal_container.find('#landing-video-url').val($(this).data('action'));
  	modal_container.find('form').attr('action', $(this).data('action'));
  	modal_container.modal().show();
  })
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
function edit_landing_settings(form) {
	form = $(form);
	

	form.submit();
	return false;
}