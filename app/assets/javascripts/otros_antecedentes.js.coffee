# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#guardar-ant-soc").click ->
  if typeof atencion_salud_id != 'undefined'
    at_salud_id = atencion_salud_id
  else
    at_salud_id = 'persona'
  grupo_familiar = $("#personas-grupo-familiar").val()
  nivel_escolaridad = $('input[name=nivel-escolaridad]:checked').val()
  $.ajax '/guardar_antecedentes_sociales',
    type: 'POST'
    data:
      grupo_familiar : grupo_familiar
      nivel_escolaridad : nivel_escolaridad
      atencion_salud_id : at_salud_id
    error: (jqXHR, textStatus, errorThrown) ->
    success: (data, textStatus, jqXHR) -> 
      $('#ant_soc').addClass 'active-ant'
      $('#guardar-ant-soc-span').show 'hide'
      setTimeout (->
        $('#guardar-ant-soc-span').hide 'hide'
        return
      ), 2000
  return 