# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require jquery/jquery-2.1.1.js
//= require jquery_ujs
//= require bootstrap-sprockets
//= require pace/pace.min.js


$(document).ready () ->
  $("#menu-toggle").click (e) ->
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
