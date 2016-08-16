$(document).ready( () ->
  $("#delete_partner_session").on "ajax:success", (e, data, status, xhr) ->
    $("#partner_alert").remove()
)
