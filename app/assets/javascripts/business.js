$('#activate-business-btn').on('click', function () {
	var action_link = $('#activate-business-form').attr('action');
	action_link += $(this).closest('.business').data('id');

	$('#activate-business-form').attr('action', action_link);

	$('#activate-business').modal().show();
});