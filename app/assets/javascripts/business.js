$(document).ready(function () {
	if(window.location.pathname.match(/\/business$/)){
		$('#index-business-modal').modal({
									  backdrop: 'static',
									  keyboard: false
									}).show();
	}
});

$('.activate-business-btn').on('click', function () {
	
	if($(this).attr('disabled') == 'disabled') return;
	console.log($(this).attr('disabled'));
	var action_link = $('#activate-business-form').attr('action');
	var business = $(this).closest('.business');

	action_link += business.data('id');
	$('#activate-business-form').attr('action', action_link);
	$('.modal-body>h2').text('Активация ' + business.find('.business_name').text() + ' бизнеса');
	if(business.data('id') == 1 || 1==1){ // Redex id
		//Mess with header substitute with buseness name
		// var new_modal_header = $('.modal-body>h2').text();
		// new_modal_header = new_modal_header.replace(/{business_name}/g, business.find('.business_name').text());
		
		//Mess with placeholder
		$('input[name="ref_link"]').attr('placeholder', 'Введите RedEx логин');

	}
	
	localStorage.setItem("business_id", business.data('id'));
	$('#activate-business').modal().show();
});