# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#guardar-ant-soc").click ->
  grupo_familiar = $("#personas-grupo-familiar").val()
  nivel_escolaridad = $('input[name=nivel-escolaridad]:checked').val()
  $.ajax '/guardar_antecedentes_sociales',
    type: 'POST'
    data:
      grupo_familiar : grupo_familiar
      nivel_escolaridad : nivel_escolaridad
    error: (jqXHR, textStatus, errorThrown) ->
    success: (data, textStatus, jqXHR) ->
  return 