$(document).ready(function () {
	if(window.location.pathname.match(/\/business$/)){
		$('#tools-choose').modal({
									  backdrop: 'static',
									  keyboard: false
									}).show();
	}
});
$('.edit-business-settings').on('click', function (e) {
	var modal_container = $('#edit-business-settings');
	modal_container.find('input[name="link"]').val($(this).data('ref_link'));
	console.log($(this).data('block_reg'));
	modal_container.find('#settings_block_reg').attr('checked',$(this).data('block_reg'));
	modal_container.find('form').attr('action', $(this).data('action'));
	modal_container.modal().show();
})
$('.activate-business-btn').on('click', function () {

	if($(this).attr('disabled') == 'disabled') return;
	
	var action_link = $('#activate-business-form').data('action');
	var business = $(this).closest('.company');
	console.log(business.data('id'));
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
