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
  nivel_escolaridad = $('input[name=nivel-escolaridad]:checked').val()
  $.ajax '/guardar_antecedentes_sociales',
    type: 'POST'
    data:
      grupo_familiar : grupo_familiar
      nivel_escolaridad : nivel_escolaridad
    error: (jqXHR, textStatus, errorThrown) ->
    success: (data, textStatus, jqXHR) ->
  return 

$('input[type=radio][name^=rad-act-fis-]').change ->
  id = $(this).attr "name"
  pregunta_id = id.substring(12)
  estado = $(this).val()
  $('#preg-'+pregunta_id).show() if estado == '1'
  $('#preg-'+pregunta_id).hide() if estado == '0'
  guardarActividad(estado,pregunta_id) 
  return

$('input[id^=input-act-fis-]').keyup ->
  id = $(this).attr "id"
  pregunta_id = id.substring(14)
  valor = $(this).val()
  guardarActividad(valor,pregunta_id) 

guardarActividad = (valor,pregunta) ->
  $.ajax '/actividad_fisica',
    type: 'POST'
    data:
      valor : valor
      pregunta : pregunta     
    error: (jqXHR, textStatus, errorThrown) ->       
    success: (data, textStatus, jqXHR) -> 

$(document).ready ->
  $("#form_act_fis").bootstrapValidator
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"
    fields:
      'dias_actividad[]':
        validators: 
          between:
            message: 'Ingrese un valor positivo entre 1 y 7.'
            min: 1
            max: 7
          notEmpty:
            message: 'Ingrese un valor positivo entre 1 y 7.' 
          integer:   
            message: 'Ingrese un valor entero.'
      'minutos_actividad[]':
        validators: 
          between:
            message: 'Ingrese un valor positivo entre 1 y 1.440.'
            min: 1
            max: 1440
          notEmpty:
            message: 'Ingrese un valor positivo entre 1 y 1.440.' 
          integer:   
            message: 'Ingrese un valor entero.'  
        