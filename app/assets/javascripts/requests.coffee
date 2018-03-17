# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->	

	if $('#request_end_time').length
		$('#request-end-time').datetimepicker format: 'YYYY-MM-DD HH:mm'

	$('#request-end-time').on "dp.change", (e)->
		val = $('#request_end_time').val()
		$('#request_end_time').attr( 'value', val )
	
	$('input[type="checkbox"].toggle').bootstrapToggle()		

	$('.request-perm').on 'click', ->
		$('.request-perm').removeClass('btn-success').addClass('btn-default')
		$('.request-perm').children('i').remove()
		$('#request_permission').val $(this).html().split(' ')[0]
		$(this).removeClass('btn-default').addClass('btn-success').append(' <i class="glyphicon glyphicon-ok"></i>')

	if $('#request_permission').length
		if $('#request_permission').val() == ''
			$('#request_permission').val 'private'
			$('#private-request').click()
		else
			$("##{$('#request_permission').val()}-request").click()
			console.log $('#request_permission').val()


	$('#add-participant').on 'click', ->
		email = $('#participant-email').val()
		if email != ''
			if validateEmail(email)
				$('#participant-table tbody').append("<tr><td>Anonymous Participant<td><td>#{email}</td><td><i class='glyphicon glyphicon-trash'></i></td></tr><input type='hidden' name='participants[]' value='#{email}'>")
				$('#participant-email').val('').parent().removeClass('has-error')
			else
				$('#participant-email').parent().addClass('has-error')
		else
			$('#participant-email').parent().addClass('has-error')

	$('#participant-email').keydown (event) ->
		if event.keyCode == 13
			event.preventDefault()
			email = $(this).val()
			if email != ''
				if validateEmail(email)
					$('#participant-table tbody').append("<tr><td>Anonymous Participant<td><td>#{email}</td><td><i class='glyphicon glyphicon-trash'></i></td></tr><input type='hidden' name='participants[]' value='#{email}'>")
					$(this).val('').parent().removeClass('has-error')
				else
					$(this).parent().addClass('has-error')
			else
				$(this).parent().addClass('has-error')

	$('select#suppliers-list').on 'change', ->
		name = $(this).find(":selected").attr('data-name')
		email = $(this).find(":selected").attr('value')
		if name == ''
			name = 'Anonymous Supplier'
		$('#participant-table tbody').append("<tr><td>#{name}<td><td>#{email}</td><td><i class='glyphicon glyphicon-trash'></i></td></tr><input type='hidden' name='participants[]' value='#{email}'>")



	$('#item-add').on 'click', ->
		name 		= $('#item-name').val()
		unit 		= $('#item-unit').val()
		quantity 	= $('#item-quantity').val()
		description = $('#item-description').val()
		if name != '' && unit != '' && quantity != '' && description != ''
			$('#items-table tbody').append("<tr><td>#{name}</td><td>#{unit}</td><td>#{quantity}</td><td>#{description}</td><td><i class='glyphicon glyphicon-trash'></i></td></tr>")
			$('#item-name').val ''
			$('#item-unit').val ''
			$('#item-quantity').val ''
			$('#item-description').val ''

	$('#items-add').on 'click', ->
		unless $('#items-table tbody').html() == ''
			items = []
			$('#items-table tbody tr').each (index, tr)->
				json = { 
							name: $(tr).children('td').eq(0).html(), 
							unit: $(tr).children('td').eq(1).html(), 
							quantity: $(tr).children('td').eq(2).html(), 
							description: $(tr).children('td').eq(3).html()
						}
				items.push JSON.stringify(json)
			$('#request_items').val "[ #{items} ]"
			$('#request-items-table').html $('#items-table').html()
			$('#request-items-table i.glyphicon-trash').remove()
			$('#items-table tbody tr').remove()

	$('#items-cancel').on 'click', ->
		$('#items-table tbody tr').remove()

	$('#question-type').on 'change', ->
		if $(this).val() == 'Choose from a list' || $(this).val() == 'Checkboxes'
			$('#question-options-div').show()
		else
			$('#question-options-div').hide()

	$('body').on 'keydown', '.question-option', (e) ->
		if e.keyCode == 13
			e.preventDefault()
			unless $(this).val() == ''
				exists = false
				$('.question-option').each (index, input)->
					if $(input).val() == ''
						exists = true
				unless exists
					value = $(this).val()
					$(this).val('').parent().clone().appendTo('#question-options-div>div')
					$(this).val(value)

	$('body').on 'click', '#question-options-div i.glyphicon-remove', (event) ->
		if $('#question-options-div i.glyphicon-remove').length > 1
			$(this).parent().parent().remove()

	$('#question-save').on 'click', ->
		title 			= $('#question-title').val()
		description 	= $('#question-description').val()
		type 			= $('#question-type').val()
		enable_attach 	= $('#question-attach').prop 'checked'
		mandatory 		= $('#question-mandatory').prop 'checked'
		options 		= []
		$('.question-option').each (index, input) ->
			options.push $(input).val()
		options = options.toString()

		if title != '' && description != '' && type != ''
			if type == 'Choose from a list' || type == 'Checkboxes'
				if options == ''
					return
			else
				options = ''
				$('.question-option').val ''

			$('#questions-table tbody').append "<tr><td>#{title}</td><td>#{description}</td><td>#{type}</td><td>#{options}</td><td>#{enable_attach}</td><td>#{mandatory}</td><td><i class='glyphicon glyphicon-trash'></i></td></tr>"
			$('#question-title').val ''
			$('#question-description').val ''
			$('#question-type').val ''
			$('.question-option').val ''
			$('#question-attach').bootstrapToggle 'on'
			$('#question-mandatory').bootstrapToggle 'on'

	$('#questions-save').on 'click', ->
		unless $('#questions-table tbody').html() == ''
			items = []
			$('#questions-table tbody tr').each (index, tr)->
				json = { 
							title: $(tr).children('td').eq(0).html(), 
							description: $(tr).children('td').eq(1).html(), 
							question_type: $(tr).children('td').eq(2).html(), 
							options: $(tr).children('td').eq(3).html(),
							enable_attatch: $(tr).children('td').eq(4).html(),
							mandatory: $(tr).children('td').eq(5).html(),
						}
				items.push JSON.stringify(json)
			$('#request_questions').val "[ #{items} ]"
			$('#request-questions-table').html $('#questions-table').html()
			$('#request-questions-table i.glyphicon-trash').remove()
			$('#questions-table tbody tr').remove()
	

	$('body').on 'click', '.table i.glyphicon-trash', (event) ->
		$(this).parent().parent().remove()


	if $('div#request-document').length
		document = new Dropzone 'div#request-document',
            url: $('div#request-document').attr('data-url')
            method: 'post'
            maxFiles: 1
            timeout: 18000000
            sending: (data, xhr, formData)->
            	$.each JSON.parse($('div#request-document').attr('data-fields')), (key, value)->
                    formData.append key, value
            success: (file, result)->
            	res_data    = $.parseXML result
            	document_url   = $(res_data).find("Location").text()
            	$('#request_attach').val document_url

	$('.answer-cell textarea').keydown (event) ->
		if event.keyCode == 13
			event.preventDefault()
			if $(this).val() == ''
				return
			comment = $(this).val()
			url		= $(this).parent().attr 'data-url'
			_this   = this
			$.ajax
				type: 'PUT'
				url: url
				dataType: 'json'
				data: { 'qanswer': {'comments': comment}}
				success: (res) ->
					if res.status == 'success'
						$(_this).blur().attr 'disabled', true

	$('.answer-cell>div>a').on 'click', ->
		url  	= $(this).parent().parent().attr 'data-url'
		like 	= $(this).children('i').hasClass('glyphicon-thumbs-up')
		_this 	= this

		$.ajax
			type: 'PUT'
			url: url
			dataType: 'json'
			data: { 'qanswer': {'like': like}}
			success: (res) ->
				if res.status == 'success'
					$(_this).parent().children('a').removeClass('btn-success').removeClass('btn-danger')
					if $(_this).children('i').hasClass('glyphicon-thumbs-up')
						$(_this).addClass('btn-success')
					else
						$(_this).addClass('btn-danger')

	$('.set-winner').on 'click', ->
		data = JSON.parse $(this).attr 'data-winner'
		$('#winnerModal #winner-name').html "#{data.company}<small>( #{data.name} )</small>"
		$('#winnerModal #winner-budget').html data.bid_budget
		$('#winnerModal #winner_subject1').val "Your bid got selected on request: #{data.request}"
		$('#winnerModal #winner_subject2').val "Unfortunately your bid did not get selected on request: #{data.request}"
		$('#winnerModal #winner_content1').val "Hello,\nThank you for your bid on request: #{data.request}!\nWe are pleased to announce that we have decided to select your bid!\nWe will contact you shortly to specify any necessary details.\n\nKind regards,\n[your name]\n[your company]\n[contact number]"
		$('#winnerModal #winner_content2').val "Hello,\nThank you for your bid on request: #{data.request}!\nUnfortunately your bid was not selected. We have decided to award this request.\nWe are looking forward to working with you in the future and hope you will participate on our upcoming requests.\n\nKind regards,\n[your name]\n[your company]\n[contact number]"
		$('#winnerModal #winner_winner_id').val data.id

	$('#request_items').val ''
	$('#list-items-document').on 'change', ->
		parseExcel this.files[0], 'list'

	$('#request_questions').val ''
	$('#questions-document').on 'change', ->
		console.log $(this)
		parseExcel this.files[0], 'question'


validateEmail = (email) ->
	re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
	re.test email

parseExcel = (file, type) ->
	reader = new FileReader
	reader.onload = (e) ->
		data = e.target.result
		workbook = XLSX.read(data, type: 'binary')
		workbook.SheetNames.forEach (sheetName) ->
			XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName])
			json_object = JSON.stringify(XL_row_object)
			
			if type == 'list'				
				unless $('#request_items').val() == json_object
					unless XL_row_object[0].name?
						alert "Invalid format Excel file..."
						$('#list-items-document').val ''
						return
					$('#request_items').val json_object
					XL_row_object.forEach (json)->
						$('#request-items-table tbody').append("<tr><td>#{json.name}</td><td>#{json.unit}</td><td>#{json.quantity}</td><td>#{json.description}</td></tr>")

			if type == 'question'
				unless $('#request_questions').val() == json_object
					unless XL_row_object[0].title?
						alert "Invalid format Excel file..."
						$('#questions-document').val ''
						return
					$('#request_questions').val json_object
					XL_row_object.forEach (json)->
						$('#request-questions-table tbody').append("<tr><td>#{json.title}</td><td>#{json.description}</td><td>#{json.question_type}</td><td>#{json.options}</td><td>#{json.enable_attatch}</td><td>#{json.mandatory}</td></tr>")


	reader.onerror = (ex) ->
		alert ex

	reader.readAsBinaryString(file)