# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#user_genre_ids').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '555px'