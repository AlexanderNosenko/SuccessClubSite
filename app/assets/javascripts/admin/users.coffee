# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready () ->
  roleSelect = $("#role-select")
  inv = $('#invite')
  parentList = $('#inv-container').find '.dropdown-menu'
  csrf = $('meta[name="csrf-token"]').val()
  roleSelect.change () ->
    id = $('#user-id').text()
    $.post "/admin/user/#{id}/changerole", {
        role_id: roleSelect.val(),
        CSRF: csrf
      }, (data)->
      alert(data)
  $(".delete-user").on "ajax:complete",  (e, data, status, xhr) ->
    alert(data.responseText)
    if(status == "success")
      $(e.target).parents("a.row").remove()
    true
  $('#invite').on "input", () ->
    $.post "/admin/users/parse.json", {data: inv.val()}, (data) ->
      console.log data
      parentList.empty()
      for elem in data
        parentList.append $("<li><a data-id=#{elem.id} class='parent-select'>#{elem.name} #{elem.last_name}</a></li>")
      0
  true
  $(document).on 'click','.parent-select', (e) ->
    updateParent e.target.dataset.id
updateParent = (new_id) ->
  id = $('#user-id').text()
  $.post "/admin/user/#{id}/changeparent", {
      parent_id: new_id
    }, (data)->
      alert(data)
