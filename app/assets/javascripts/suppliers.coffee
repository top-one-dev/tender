# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->

	$('body').on 'click', '.ask-question', (event) ->
		top = $('#message-board-title').offset().top
		$('html, body').animate({scrollTop: top - 5 }, 1000)

