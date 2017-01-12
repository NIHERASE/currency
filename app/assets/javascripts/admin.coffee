$(document).on 'turbolinks:load', ->
  $('#js-override-datetimepicker').datetimepicker
    format: 'YYYY-MM-DDTHH:mmZ',
    locale: 'ru',
    inline: true,
    sideBySide: true,
    defaultDate: moment().add(5, 'minutes')
    minDate: new Date()
