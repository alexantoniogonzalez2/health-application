# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('input[type=radio][name^=rad-act-fis-]').change ->
  id = $(this).attr "name"
  pregunta_id = id.substring(12)
  estado = $(this).val()
  $('#preg-'+pregunta_id).show() if estado == '1'
  $('#preg-'+pregunta_id).hide() if estado == '0'
  guardarActividad(estado,pregunta_id) 
  return

$(document).ready -> 
  $('input[id^=input-act-fis-]').keyup ->
    act_vig = calculaActVig()
    act_mod = calculaActMod() 
    $('#min_act_fis_vig').html(act_vig)
    $('#min_act_fis_mod').html(act_mod) 

guardarActividad = (valor,pregunta) ->
  $.ajax '/actividad_fisica',
    type: 'POST'
    data:
      valor : valor
      pregunta : pregunta     
    error: (jqXHR, textStatus, errorThrown) ->       
    success: (data, textStatus, jqXHR) -> 

$("#form_act_fis")
  .bootstrapValidator
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
  .on("success.field.bv", "[name=\"dias_actividad[]\"]", (e, data) -> guardarActividad( $(this).val(),$(this).attr "id".substring(14) ))
  .on("success.field.bv", "[name=\"min_actividad[]\"]", (e, data) -> guardarActividad( $(this).val(),$(this).attr "id".substring(14) ))

calculaActVig = ->
  preg_2 = $('#input-act-fis-2').val()
  preg_3 = $('#input-act-fis-3').val()
  preg_11 = $('#input-act-fis-11').val()
  preg_12 = $('#input-act-fis-12').val()
  return preg_2*preg_3 + preg_11*preg_12

calculaActMod = ->
  preg_5 = $('#input-act-fis-5').val()
  preg_6 = $('#input-act-fis-6').val()
  preg_8 = $('#input-act-fis-8').val()
  preg_9 = $('#input-act-fis-9').val()
  preg_14 = $('#input-act-fis-14').val()
  preg_15 = $('#input-act-fis-15').val()
  return preg_5*preg_6 + preg_8*preg_9 + preg_14*preg_15
