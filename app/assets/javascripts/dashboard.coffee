# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  $('.market-dashboard .panel .panel-heading .pull-right a[data-toggle="collapse"]').on 'click', (event) ->
    event.preventDefault()

    if $(this).children('.glyphicon').hasClass('glyphicon-minus')
      $(this).children('.glyphicon').removeClass('glyphicon-minus').addClass 'glyphicon-plus'
    else
      $(this).children('.glyphicon').removeClass('glyphicon-plus').addClass 'glyphicon-minus'
    return

  if $('.input-date').length
    $('.input-date').datepicker {}

  if $('[data-toggle="tooltip"]').length
    $('[data-toggle="tooltip"]').tooltip()

  if $('.multi-select').length
    $('.multi-select').multiselect()

  $('.sidebar-toggle').on 'click', ->
    $('#sidebar').toggleClass 'active'
    return

  $('#showFolders').click (event) ->

    $('#sidebar-menu').css 'left', '0'
    return

  $('#hideFolders').click (event) ->

    $('#sidebar-menu').css 'left', '-350px'
    return

  # charts
  if $('#report-chart').length
    $('#report-chart').highcharts
      title: text: '<b>Report Chart</b>'
      chart:
        type: 'column'
        margin: 75
        options3d:
          enabled: true
          alpha: 10
          beta: 15
          depth: 50
      plotOptions: column: depth: 25
      yAxis: [ { title: text: '...' } ]
      series: [ {
        name: 'Requests'
        data: [
          30
          72
          106
          129
          144
          176
          135
          148
          216
          194
          95
          54
        ]
      } ]
      
  return