$('.agregar-alergia').on 'click' , =>
  alergia = $('#agregar-alergia').val()
  if typeof atencion_salud_id != 'undefined'
    at_salud_id = atencion_salud_id
  else
    at_salud_id = 'persona'
  $.ajax '/agregar_alergia',
    type: 'POST'
    data:
      atencion_salud_id: at_salud_id
      alergia: alergia  
    error: (jqXHR, textStatus, errorThrown) ->       
    success: (data, textStatus, jqXHR) ->

$('#alergias').submit (e) ->
  false

$('#alergias')
  .bootstrapValidator
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"
    fields:
      input_alergia:
        validators:
         notEmpty:
          message: 'Este campo es requerido'

$("input[type=checkbox][id^=checkboxes-aler-]").change ->
  if typeof atencion_salud_id != 'undefined'
    at_salud_id = atencion_salud_id
  else
    at_salud_id = 'persona'
  alergia = $(this).attr("id").substring(16)
  estado = $(this).is(":checked")
  $.ajax '/editar_alergia',
    type: 'POST'
    data:
      alergia : alergia
      estado : estado
      atencion_salud_id: at_salud_id
    error: (jqXHR, textStatus, errorThrown) ->
    success: (data, textStatus, jqXHR) -> if $('input[name="checkboxes-alergia"]:checked').length > 0 then $('#ale').addClass 'active-ant' else $('#ale').removeClass 'active-ant'
  return