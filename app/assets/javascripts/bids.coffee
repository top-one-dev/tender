# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
	$('.price-input').on 'change', (event)->
		event.preventDefault()
		id = $(this).attr('id')
		id = $(this).attr('id').replace('-', '')
		price = (parseFloat($(this).val())*parseFloat($(this).attr('data-quantity'))).toFixed 2
		$("##{id}").html price
		total_price = 0
		$('.item-price').each (index)->
			price = parseFloat $(this).html()
			total_price += price
		$('#total-price').html total_price.toFixed(2)
		$('#bid_bid_budget').val total_price.toFixed(2)

	if $('div#bid-document').length
		dz_document = new Dropzone 'div#bid-document',
						url: $('div#bid-document').attr('data-url')
						method: 'post'
						maxFiles: 1
						timeout: 18000000
						sending: (data, xhr, formData)->
							$.each JSON.parse($('div#bid-document').attr('data-fields')), (key, value)->
								formData.append key, value
						success: (file, result)->
							res_data		= $.parseXML result
							document_url	= $(res_data).find("Location").text()
							delete_url 		= $("#bid_document_view").attr "data-url"
							$('#bid_document').val document_url
							$('#bid_document_view').append "<a href='#{document_url}'><i class='glyphicon glyphicon-file'></i> #{file.name}</a>&nbsp;&nbsp;&nbsp;<i class='glyphicon glyphicon-remove text-danger' data-key='#{document_url}' data-url='#{delete_url}' ></i>"

		$('body').on 'click', '#bid_document_view i.glyphicon-remove', (event) ->
			if confirm('Are you sure to delete this document?')
				url 	= $(this).attr 'data-url'
				key 	= $(this).attr 'data-key'
				_this 	= this
				$.ajax
					type: 'POST'
					url: url
					dataType: 'json'
					data: { 'key': key }
					success: (res) ->
						if res.status == 'ok'
							$(_this).parent().html ""
							$("#bid_document").val ""
							dz_document.removeAllFiles()
						else
							alert res.message

	$('#bid_bid_currency').on 'change', (event)->
		$('#currency').html $('#bid_bid_currency option:selected').attr('value')

		if $('.qanswer-checkbox').length
			qanswers = []
			$('.qanswer-checkbox').each (index)->
				if $(this).is(':checked')
					qanswers.push $(this).attr('data-value')
		if qanswers.length > 0
			$('#qanswers-checkbox').val qanswers.join()   	
 	

	$('.qanswer-checkbox').on 'click', (event)->
		qanswers = []
		$('.qanswer-checkbox').each (index)->
			if $(this).is(':checked')
					qanswers.push $(this).attr('data-value')
			console.log qanswers
		if qanswers.length > 0
			$('#qanswers-checkbox').val qanswers.join()


	if $('.qanswer_document').length
		qanswer_document = {}
		$('.qanswer_document').each (index, el) ->
			id = $(el).attr 'id'
			qanswer_document["#{id}"] = new Dropzone "div##{id}",
											url: $(el).attr('data-url')
											method: 'post'
											maxFiles: 1
											timeout: 18000000
											sending: (data, xhr, formData)->
												$.each JSON.parse($(el).attr('data-fields')), (key, value)->
													formData.append key, value
											success: (file, result)->
												res_data    	= $.parseXML result
												document_url   	= $(res_data).find("Location").text()
												delete_url 		= $("##{id}_view").attr "data-url"
												$("##{id}_value").val document_url
												$("##{id}_view").append "<a href='#{document_url}'><i class='glyphicon glyphicon-file'></i> #{file.name}</a>&nbsp;&nbsp;&nbsp;<i class='glyphicon glyphicon-remove text-danger' data-key='#{document_url}' data-url='#{delete_url}' data-dzid='#{id}'></i>"

		$('body').on 'click', '.qanswer_document_view i.glyphicon-remove', (event) ->
			if confirm('Are you sure to delete this document?')
				url 	= $(this).attr 'data-url'
				key 	= $(this).attr 'data-key'
				dz_id	= $(this).attr 'data-dzid'
				_this 	= this
				$.ajax
					type: 'POST'
					url: url
					dataType: 'json'
					data: { 'key': key }
					success: (res) ->
						if res.status == 'ok'
							$(_this).parent().html ""
							$("##{dz_id}_value").val ""
							qanswer_document["#{dz_id}"].removeAllFiles()
						else
							alert res.message



