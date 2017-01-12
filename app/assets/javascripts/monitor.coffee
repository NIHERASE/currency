# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  if $('.js-ruble-monitor').length > 0
    App.cable.subscriptions.create { channel: "CurrencyChannel" },
      received: (data) ->
        console.log(data)
        $('.js-ruble-monitor').html(data)
