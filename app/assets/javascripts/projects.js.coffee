# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#more-downloads', ->
  $('#downloads').toggleClass('hide')
  if location.hash == '#downloads'
    location.hash = ''
  else
    location.hash = '#downloads'

$(document).on 'click', '#add-dev', ->
  $('#add-dev-form').fadeToggle(50)
  $('input#project_users').focus()

$(document).ready ->
  $('#add-dev-form').on 'ajax:success', (e, data, status, xhr) ->
    $('input#project_users').val('')

$(document).on "click", (e) ->
  formClick = $("#add-dev-form").has($(e.target)).length || $(e.target).is("#add-dev")
  $("#add-dev-form").fadeOut 50 unless formClick

$(document).on "keydown", "textarea", (e) ->
  $(this).parents("form").submit()  if e.keyCode is 13 and (e.metaKey or e.ctrlKey)