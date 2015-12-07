# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

saveTest = ->
	if typeof atencion_salud_id != 'undefined'
    at_salud_id = atencion_salud_id
  else
    at_salud_id = 'persona'

	param_1 = $('input[name=question-1]:checked').val()
	param_2 = $('input[name=question-2]:checked').val()
	param_3 = $('input[name=question-3]:checked').val()
	param_4 = $('input[name=question-4]:checked').val()
	param_5 = $('input[name=question-5]:checked').val()
	param_6 = $('input[name=question-6]:checked').val()
	param_7 = $('input[name=question-7]:checked').val()
	param_8 = $('input[name=question-8]:checked').val()
	param_9 = $('input[name=question-9]:checked').val()
	param_10 = $('input[name=question-10]:checked').val()
	$.ajax '/habitos_alcohol',
    type: 'POST'
    data:
    	atencion_salud_id: at_salud_id
    	param_1 : param_1
    	param_2 : param_2
    	param_3 : param_3
    	param_4 : param_4
    	param_5 : param_5
    	param_6 : param_6
    	param_7 : param_7
    	param_8 : param_8
    	param_9 : param_9
    	param_10 : param_10
    error: (jqXHR, textStatus, errorThrown) ->       
    success: (data, textStatus, jqXHR) -> 
    	cerrarModalHabAlc 'new'
    	$('#hab_alc').addClass 'active-ant'

alertMessage = (messageId) ->
  $('#alert-'+messageId).show()

hideMessage = (messageId) ->
  $('#alert-'+messageId).hide()
   
$('#button1id').on 'click' , =>	
	valid = true
	for i in [1..10] by 1
		hideMessage i
		unless $('input[name=question-'+i+']:checked').size() > 0
			valid = false
			alertMessage i
	if valid			
		saveTest()


guardarHabitoAlcoholResumen = (tipo_texto) ->
  if typeof atencion_salud_id != 'undefined'
    at_salud_id = atencion_salud_id
  else
    at_salud_id = 'persona'
  switch tipo_texto
    when 'fre'
      texto = $('#hab_alc_fre').val()
    when 'tip'
      texto = $('#hab_alc_tip').val()
    when 'can'
      texto = $('#hab_alc_can').val()  
  $.ajax
    type: 'POST'
    url: '/guardar_habito_alcohol_resumen'
    data:
      atencion_salud_id: at_salud_id
      campo: tipo_texto
      valor: texto
    success: (response) ->
      $('#auto-hab_alc_' + tipo_texto).show 'hide'
      setTimeout (->
        $('#auto-hab_alc_' + tipo_texto).hide 'hide'
        return
      ), 2000
      return
    error: (xhr, status, error) ->
      alert 'No se pudo guardar este antecedente'
      return
  return

root = exports ? this 

$('#hab_alc_fre').keyup (e) ->
  if typeof root.contador_hab_alc_fre == 'undefined'
  else
    clearTimeout root.contador_hab_alc_fre

  root.contador_hab_alc_fre = setTimeout((->
    guardarHabitoAlcoholResumen 'fre'
    return
  ), 2000)
  return

$('#hab_alc_tip').keyup (e) ->
  if typeof root.contador_hab_alc_tip == 'undefined'
  else
    clearTimeout root.contador_hab_alc_tip

  root.contador_hab_alc_tip = setTimeout((->
    guardarHabitoAlcoholResumen 'tip'
    return
  ), 2000)
  return

$('#hab_alc_can').keyup (e) ->
  if typeof root.contador_hab_alc_can == 'undefined'
  else
    clearTimeout root.contador_hab_alc_can

  root.contador_hab_alc_can = setTimeout((->
    guardarHabitoAlcoholResumen 'can'
    return
  ), 2000)
  return