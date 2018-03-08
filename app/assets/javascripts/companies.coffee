# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
	if $('div#companylogo').length
		companylogo = new Dropzone 'div#companylogo',
            url: $('div#companylogo').attr('data-url')
            method: 'post'
            maxFiles: 1
            timeout: 18000000
            sending: (data, xhr, formData)->
            	$.each JSON.parse($('div#companylogo').attr('data-fields')), (key, value)->
                    formData.append key, value
            renameFile: (file)->
            	extention = file.name.split('.').pop()
            	return "logoimage.#{extention}"
            success: (file, result)->
            	res_data    = $.parseXML result
            	image_url   = $(res_data).find("Location").text()
            	$('#company_logo').val image_url
            	$('.company-logo').attr 'src', image_url

    $('#companyLogoModal .close').on 'click', ->
    	companylogo.removeAllFiles()