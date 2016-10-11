$(document).ready(function () {
	if(window.location.pathname.match(/\/business/)){
		$('#index-business-modal').modal({
									  backdrop: 'static',
									  keyboard: false
									}).show();
	}
});

$('.activate-business-btn').on('click', function () {
	
	var action_link = $('#activate-business-form').attr('action');
	var business = $(this).closest('.business');

	action_link += business.data('id');
	$('#activate-business-form').attr('action', action_link);
	console.log(business.find('.business_name').text());
	if(business.data('id') == 1 || 1==1){ // Redex id
		//Mess with header substitute with buseness name
		var new_modal_header = $('.modal-body>h2').text();
		new_modal_header = new_modal_header.replace(/{business_name}/g, business.find('.business_name').text());
		$('.modal-body>h2').text(new_modal_header);
		//Mess with placeholder
		$('input[name="ref_link"]').attr('placeholder', 'Введите RedEx логин');

	}
	

	$('#activate-business').modal().show();
});