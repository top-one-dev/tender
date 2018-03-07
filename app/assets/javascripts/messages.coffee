# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->

	$('#open-request-detail').on 'click', ->
		console.log $(this).html()
		if $(this).html() == 'OPEN REQUEST DETAILS'
			$('#message-request-detail').slideDown()
			$(this).html 'HIDE REQUEST DETAILS'
		else		
			$('#message-request-detail').slideUp()
			$(this).html 'OPEN REQUEST DETAILS'

	$('#new-message').on 'click', ->
		$('#new-message-div').slideDown()
		$('#message-content').focus()

	$('body').on 'click', '#send-message', (event) ->
		buyer	 	= $(this).attr 'data-buyer'
		supplier 	= $(this).attr 'data-supplier'
		request  	= $(this).attr 'data-request'
		requisition = $(this).attr 'data-requisition'
		colleague 	= $(this).attr 'data-colleague'
		url		 	= $(this).attr 'data-url'
		content  	= $('#message-content').val()

		if content == ''
			$('#message-result').fadeIn(200).addClass('alert-danger').html('Message content is required!').fadeOut(3000)
			return

		if request?
			if supplier?
				data = { 'message': { 'content' : content, 'from': 'supplier', 'read': false,  'supplier_id': supplier, 'request_id': request } }
			else
				data = { 'message': { 'content' : content, 'from': 'buyer', 'read': false,  'user_id': buyer, 'request_id': request } }
			
		
		if requisition?
			if colleague?
				data = { 'message': { 'content' : content, 'from': "colleague_#{colleague}", 'read': false, 'requisition_id': requisition } }
			else
				if buyer?
					data = { 'message': { 'content' : content, 'from': 'company', 'read': false, 'requisition_id': requisition } }
				else
					data = { 'message': { 'content' : content, 'from': 'requisitioner', 'read': false, 'requisition_id': requisition } }

		$(this).html('<i class="fa fa-spinner fa-spin" style="font-size: 18px;" ></i> sending...').attr "disabled", true
		$('#message-content').attr "disabled", true

		$.ajax
			type: 'POST'
			url: url
			dataType: 'json'
			data: data
			success: (res) ->
				$('#send-message').html('send').attr "disabled", false
				$('#message-content').attr "disabled", false
				if res.status == 'success'
					$('#message-result').fadeIn(200).removeClass('alert-danger').addClass('alert-info').html(res.message).fadeOut(3000)
					location.reload();
				else
					$('#message-result').fadeIn(200).removeClass('alert-info').addClass('alert-danger').html(res.message).fadeOut(3000)


	$('body').on 'click', '.reply-message', ->
		if $('#message-board-title').length
			top = $('#message-board-title').offset().top			
		if $('#new-message-div').length
			$('#new-message-div').slideDown()
			top = $('#new-message-div').offset().top
		$('html, body').animate({scrollTop: top - 10 }, 500)
		$('#message-content').focus()

	$('body').on 'click', '.mark-read', ->
		url = $(this).attr 'data-url'
		_this = this
		$.ajax
			type: 'PUT'
			url: url
			dataType: 'json'
			data: {'message': { 'read' : true }}
			success: (res) ->
				if res.status == 'success'
					$(_this).parent().append '<small><span class="label label-success">Read</span></small>'
					$(_this).remove()
				else
					alert res.message

