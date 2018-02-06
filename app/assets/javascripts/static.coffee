# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.flexslider1').flexslider
    animation: 'slide'
    controlNav: 'thumbnails'

  $('.flexslider1 .flex-control-nav li').each (index, element) ->
    setTimeout (->
      $(element).addClass 'animated slideOutDown'
      return
    ), 100 * index
    return

  $(window).scroll ->
    if $('#testimonial').length
      top = $('#testimonial').offset().top - 600
      if $(this).scrollTop() >= top
        $('.flexslider1 .flex-control-nav li').each (index, element) ->
          setTimeout (->
            $(element).removeClass('slideOutDown').addClass 'animated bounceInUp'
            return
          ), 100 * index
          return
    return
    
  return