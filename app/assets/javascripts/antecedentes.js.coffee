# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("input[type=checkbox][id^=checkboxes-aler-]").change ->
  alergia = $(this).attr("id").substring(16)
  estado = $(this).is(":checked")
  $.ajax '/editar_alergia',
  	type: 'POST'
  	data:
  		alergia : alergia
  		estado : estado
		error: (jqXHR, textStatus, errorThrown) ->
		success: (data, textStatus, jqXHR) ->
  return

$("#guardar-ant-soc").click ->
  grupo_familiar = $("#personas-grupo-familiar").val()
  alert grupo_familiar
  nivel_escolaridad = $('input[name=nivel-escolaridad]:checked').val()
  alert nivel_escolaridad
  $.ajax '/guardar_antecedentes_sociales',
    type: 'POST'
    data:
      grupo_familiar : grupo_familiar
      nivel_escolaridad : nivel_escolaridad
    error: (jqXHR, textStatus, errorThrown) ->
    success: (data, textStatus, jqXHR) ->
  return 