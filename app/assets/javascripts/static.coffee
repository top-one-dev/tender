# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
	initComparisons()
	$(window).scroll (event) ->
		event.preventDefault()
		top = $(this).scrollTop()
		if top > 100
			$('nav.navbar-fixed-top').css 'background-color', '#fff'
		else
			$('nav.navbar-fixed-top').css 'background-color', 'transparent'

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


initComparisons = ->
  x = undefined
  i = undefined

  compareImages = (img) ->
    `var img`
    clicked = 0
    w = img.offsetWidth
    h = img.offsetHeight
    img.style.width = w / 2 + 'px'
    slider = document.createElement('DIV')
    slider.setAttribute 'class', 'img-comp-slider'

    slideReady = (e) ->
      e.preventDefault()
      clicked = 1
      window.addEventListener 'mousemove', slideMove
      window.addEventListener 'touchmove', slideMove
      return

    slideFinish = ->
      clicked = 0
      return

    slideMove = (e) ->
      pos = undefined
      if clicked == 0
        return false
      pos = getCursorPos(e)
      if pos < 0
        pos = 0
      if pos > w
        pos = w
      slide pos
      return

    getCursorPos = (e) ->
      `var x`
      a = undefined
      x = 0
      e = e or window.event
      a = img.getBoundingClientRect()
      x = e.pageX - (a.left)
      x = x - (window.pageXOffset)
      x

    slide = (x) ->
      img.style.width = x + 'px'
      slider.style.left = img.offsetWidth - (slider.offsetWidth / 2) + 'px'
      return    

    img.parentElement.insertBefore slider, img

    slider.style.top = h / 2.05 - (slider.offsetHeight / 2) + 'px'
    slider.style.left = w / 2 - (slider.offsetWidth / 2) + 'px'
    slider.addEventListener 'mousedown', slideReady
    window.addEventListener 'mouseup', slideFinish
    slider.addEventListener 'touchstart', slideReady
    window.addEventListener 'touchstop', slideFinish
    return

  x = document.getElementsByClassName('img-comp-overlay')
  i = 0
  while i < x.length
    compareImages x[i]
    i++
  return