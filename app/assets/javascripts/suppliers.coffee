# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->

	$('body').on 'click', '.ask-question', (event) ->
		top = $('#message-board-title').offset().top
		$('html, body').animate({scrollTop: top - 5 }, 1000)

	$('body').on 'click', '#send-message', (event) ->
		buyer	 = $(this).attr 'data-buyer'
		supplier = $(this).attr 'data-supplier'
		request  = $(this).attr 'data-request'
		url		 = $(this).attr 'data-url'
		content  = $('#message-content').val()

		if content == ''
			$('#message-result').fadeIn(200).addClass('alert-danger').html('Message content is required!').fadeOut(3000)
			return

		$(this).html('<i class="fa fa-spinner fa-spin" style="font-size: 18px;" ></i> sending...').attr "disabled", true
		$('#message-content').attr "disabled", true

		$.ajax
			type: 'POST'
			url: url
			dataType: 'json'
			data: { 'message': { 'content' : content, 'user_id': buyer, 'supplier_id': supplier, 'request_id': request } }
			success: (res) ->
				$('#send-message').html('send').attr "disabled", false
				$('#message-content').attr "disabled", false
				if res.status == 'success'
					$('#message-result').fadeIn(200).removeClass('alert-danger').addClass('alert-info').html(res.message).fadeOut(3000)
				else
					$('#message-result').fadeIn(200).removeClass('alert-info').addClass('alert-danger').html(res.message).fadeOut(3000)