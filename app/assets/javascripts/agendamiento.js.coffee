# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
###
 $(document).ready ->
  $("#e1").select2 allowClear: true
  $("#e2").select2 allowClear: true
  $("#e3").select2 allowClear: true
  $("#form_hora").validate
    rules:
      e1:
        required: true

      e2:
        required: true

      e3:
        required: true

    messages:
      e1: "No se ha seleccionado un recinto de salud."
      e2: "No se ha seleccionado una especialidad."
      e3: "No se ha seleccionado un especialista."

    submitHandler: (form) ->
      window.location = "/agendamiento/pedirHora" + "/" + $("#e2").select2("val") + "/" + $("#e1").select2("val") + "/" + $("#e3").select2("val")
      return

  return
###
