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
		document = new Dropzone 'div#bid-document',
            url: $('div#bid-document').attr('data-url')
            method: 'post'
            maxFiles: 1
            timeout: 18000000
            sending: (data, xhr, formData)->
            	$.each JSON.parse($('div#bid-document').attr('data-fields')), (key, value)->
                    formData.append key, value
            # renameFile: (file)->
            # 	extention = file.name.split('.').pop()
            # 	return "document.#{extention}"
            success: (file, result)->
            	res_data    = $.parseXML result
            	document_url   = $(res_data).find("Location").text()
            	$('#bid_document').val document_url