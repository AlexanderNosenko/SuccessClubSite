# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready () ->
  roleSelect = $("#role-select")
  csrf = $('meta[name="csrf-token"]').val()
  roleSelect.change () ->
    id = $('#user-id').text()
    $.post "/admin/user/#{id}/changerole", {
        role_id: roleSelect.val(),
        CSRF: csrf
      }, (data)->
      alert(data)
