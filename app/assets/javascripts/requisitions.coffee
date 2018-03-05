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
