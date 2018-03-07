# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->

	$('#copy-web-form').on 'click', ->
		$('#web-form').copyme()

	$("#webformModal").on "hidden.bs.modal", ->
		$('#webformModal #success-alert').remove()

	if $('#delivery-date').length
		$('#delivery-date').datetimepicker format: 'YYYY-MM-DD'

	$('#add-colleague-button').on 'click', ->
		$(this).hide()
		$('#add-colleague-div').slideDown()

	
	$('.colleague-input').keydown (event) ->
		if event.keyCode == 13
			event.preventDefault()
			name 	= $('#colleague-name').val()
			email 	= $('#colleague-email').val()
			phone 	= $('#colleague-phone').val()
			job 	= $('#colleague-job').val()

			if name == ''
				$('#colleague-name').parent().addClass('has-error')
				return

			unless email != '' or validateEmail(email)
				$('#colleague-email').parent().addClass('has-error')
				return		
			
			$('#colleague-table tbody').append "<tr><td>#{name}</td><td>#{email}</td><td>#{phone}</td><td>#{job}</td><td><i class='glyphicon glyphicon-trash'></i></td></tr>"
			$('.colleague-input').val('').parent().removeClass 'has-error'
			$('#colleague-name').focus()

			unless $('#items-table tbody').html() == ''
				colleagues = []
				$('#colleague-table tbody tr').each (index, tr)->
					json = { 
								name: 	$(tr).children('td').eq(0).html(), 
								email: 	$(tr).children('td').eq(1).html(), 
								phone: 	$(tr).children('td').eq(2).html(), 
								job: 	$(tr).children('td').eq(3).html()
							}
					colleagues.push JSON.stringify(json)
				$('#colleague-params').val "[#{colleagues}]"



	$('#add-colleague').on 'click', ->
		name 	= $('#colleague-name').val()
		email 	= $('#colleague-email').val()
		phone 	= $('#colleague-phone').val()
		job 	= $('#colleague-job').val()

		if name == ''
			$('#colleague-name').parent().addClass('has-error')
			return

		unless email != '' or validateEmail(email)
			$('#colleague-email').parent().addClass('has-error')
			return		
		
		$('#colleague-table tbody').append "<tr><td>#{name}</td><td>#{email}</td><td>#{phone}</td><td>#{job}</td><td><i class='glyphicon glyphicon-trash'></i></td></tr>"
		$('.colleague-input').val('').parent().removeClass 'has-error'
		$('#colleague-name').focus()

		unless $('#items-table tbody').html() == ''
			colleagues = []
			$('#colleague-table tbody tr').each (index, tr)->
				json = { 
							name: 	$(tr).children('td').eq(0).html(), 
							email: 	$(tr).children('td').eq(1).html(), 
							phone: 	$(tr).children('td').eq(2).html(), 
							job: 	$(tr).children('td').eq(3).html()
						}
				colleagues.push JSON.stringify(json)
			$('#colleague-params').val "[#{colleagues}]"



	if $('div#requisition-document').length
		document = new Dropzone 'div#requisition-document',
            url: $('div#requisition-document').attr('data-url')
            method: 'post'
            maxFiles: 1
            timeout: 18000000
            sending: (data, xhr, formData)->
            	$.each JSON.parse($('div#requisition-document').attr('data-fields')), (key, value)->
                    formData.append key, value
            # renameFile: (file)->
            # 	extention = file.name.split('.').pop()
            # 	return "document.#{extention}"
            success: (file, result)->
            	res_data    = $.parseXML result
            	document_url   = $(res_data).find("Location").text()
            	$('#requisition_additional_document').val document_url

	$('body').on 'click', '#colleague-table i.glyphicon-edit', ->
    	$(this).hide()
    	$(this).parent().children('i.glyphicon-check').show()
    	$(this).parent().parent().children('td').children('span').hide()
    	$(this).parent().parent().children('td').children('input.form-control').show()

	$('body').on 'click', '#colleague-table i.glyphicon-remove', ->
		unless confirm('Are you sure to remove this colleague?')
			return
		url = $(this).attr 'data-url'
		_this = this
		$.ajax
			type: 'POST'
			url: url
			dataType: 'json'
			data: {"_method":"delete"}
			success: (res) ->
				if res.status == 'success'
					$(_this).parent().parent().remove()

	$('.colleague-input-ajax').keydown (event) ->
		if event.keyCode == 13
			event.preventDefault()
			name 	= $('#colleague-name').val()
			email 	= $('#colleague-email').val()
			phone 	= $('#colleague-phone').val()
			job 	= $('#colleague-job').val()
			requisition = $('#add-colleague-ajax').attr 'data-id'

			if name == ''
				$('#colleague-name').parent().addClass('has-error')
				return

			unless email != '' or validateEmail(email)
				$('#colleague-email').parent().addClass('has-error')
				return

			$('#add-colleague-ajax').html('<i class="fa fa-spinner fa-spin" style="font-size: 18px;" ></i> Adding...').attr "disabled", true
			$('.colleague-input-ajax').attr "disabled", true

			url = $('#add-colleague-ajax').attr 'data-url'

			$.ajax
				type: 'POST'
				url: url
				dataType: 'json'
				data: { 'stockholder': { 'name' : name, 'email': email, 'phone': phone, 'job': job, 'requisition_id': requisition } }
				success: (res) ->
					$('#add-colleague-ajax').html('Add').attr "disabled", false
					$('.colleague-input-ajax').attr "disabled", false

					if res.status == 'success'
						$('#stockholder-result').fadeIn(200).removeClass('alert-danger').addClass('alert-info').html(res.message).fadeOut(3000)
						$('#colleague-table tbody').append "<tr><td><span>#{name}</span><input type='text' value='#{name}' class='form-control'></td><td><span>#{email}</span><input type='text' value='#{email}' class='form-control'></td><td><span>#{phone}</span><input type='text' value='#{phone}' class='form-control'></td><td><span>#{job}</span><input type='text' value='#{job}' class='form-control'></td><td><i class='glyphicon glyphicon-check text-success' data-url='#{res.url}' ></i>&nbsp;<i class='glyphicon glyphicon-edit text-info'></i>&nbsp;<i class='glyphicon glyphicon-remove text-danger' data-url='#{res.url}' ></td></tr>"
						$('.colleague-input-ajax').val('').parent().removeClass 'has-error'
						$('#colleague-name').focus()
					else
						$('#stockholder-result').fadeIn(200).removeClass('alert-info').addClass('alert-danger').html(res.message).fadeOut(3000)


	$('#add-colleague-ajax').on 'click', ->
		name 		= $('#colleague-name').val()
		email 		= $('#colleague-email').val()
		phone 		= $('#colleague-phone').val()
		job 		= $('#colleague-job').val()
		requisition = $(this).attr 'data-id'

		if name == ''
			$('#colleague-name').parent().addClass('has-error')
			return

		unless email != '' or validateEmail(email)
			$('#colleague-email').parent().addClass('has-error')
			return

		$(this).html('<i class="fa fa-spinner fa-spin" style="font-size: 18px;" ></i> Adding...').attr "disabled", true
		$('.colleague-input-ajax').attr "disabled", true

		url = $(this).attr 'data-url'

		$.ajax
			type: 'POST'
			url: url
			dataType: 'json'
			data: { 'stockholder': { 'name' : name, 'email': email, 'phone': phone, 'job': job, 'requisition_id': requisition } }
			success: (res) ->
				$('#add-colleague-ajax').html('Add').attr "disabled", false
				$('.colleague-input-ajax').attr "disabled", false

				if res.status == 'success'
					$('#stockholder-result').fadeIn(200).removeClass('alert-danger').addClass('alert-info').html(res.message).fadeOut(3000)
					$('#colleague-table tbody').append "<tr><td><span>#{name}</span><input type='text' value='#{name}' class='form-control'></td><td><span>#{email}</span><input type='text' value='#{email}' class='form-control'></td><td><span>#{phone}</span><input type='text' value='#{phone}' class='form-control'></td><td><span>#{job}</span><input type='text' value='#{job}' class='form-control'></td><td><i class='glyphicon glyphicon-check text-success' data-url='#{res.url}' ></i>&nbsp;<i class='glyphicon glyphicon-edit text-info'></i>&nbsp;<i class='glyphicon glyphicon-remove text-danger' data-url='#{res.url}' ></td></tr>"
					$('.colleague-input-ajax').val('').parent().removeClass 'has-error'
					$('#colleague-name').focus()
				else
					$('#stockholder-result').fadeIn(200).removeClass('alert-info').addClass('alert-danger').html(res.message).fadeOut(3000)


	$('body').on 'click', '#colleague-table i.glyphicon-check', ->
		name 		= $(this).parent().parent().children('td').eq(0).children('input.form-control')
		email 		= $(this).parent().parent().children('td').eq(1).children('input.form-control')
		phone 		= $(this).parent().parent().children('td').eq(2).children('input.form-control')
		job 		= $(this).parent().parent().children('td').eq(3).children('input.form-control')
		url 		= $(this).attr 'data-url'
		
		if name.val() == ''
			name.parent().addClass('has-error')
			return

		unless email.val() != '' or validateEmail(email.val())
			email.parent().addClass('has-error')
			return

		name.attr 'disabled', true
		email.attr 'disabled', true
		phone.attr 'disabled', true
		job.attr 'disabled', true

		$.ajax
			type: 'PUT'
			url: url
			dataType: 'json'
			data: {'stockholder': { 'name' : name.val(), 'email': email.val(), 'phone': phone.val(), 'job': job.val() }}
			success: (res) ->
				name.attr 'disabled', false
				email.attr 'disabled', false
				phone.attr 'disabled', false
				job.attr 'disabled', false
				if res.status == 'success'
					name.hide().parent().children('span').show().html name.val()
					email.hide().parent().children('span').show().html email.val()
					phone.hide().parent().children('span').show().html phone.val()
					job.hide().parent().children('span').show().html job.val()
					$('#stockholder-result').fadeIn(200).removeClass('alert-danger').addClass('alert-info').html(res.message).fadeOut(3000)
				else
					$('#stockholder-result').fadeIn(200).removeClass('alert-info').addClass('alert-danger').html(res.message).fadeOut(3000)

	

validateEmail = (email) ->
	re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
	re.test email
