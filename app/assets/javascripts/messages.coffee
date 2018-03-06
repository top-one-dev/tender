# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->

	$('body').on 'click', '#send-message', (event) ->
		buyer	 	= $(this).attr 'data-buyer'
		supplier 	= $(this).attr 'data-supplier'
		request  	= $(this).attr 'data-request'
		requisition = $(this).attr 'data-requisition'
		url		 	= $(this).attr 'data-url'
		content  	= $('#message-content').val()

		if content == ''
			$('#message-result').fadeIn(200).addClass('alert-danger').html('Message content is required!').fadeOut(3000)
			return

		if request?
			data = { 'message': { 'content' : content, 'from': 'supplier', 'read': false,  'user_id': buyer, 'supplier_id': supplier, 'request_id': request } }
		
		if requisition?
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
				else
					$('#message-result').fadeIn(200).removeClass('alert-info').addClass('alert-danger').html(res.message).fadeOut(3000)



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

