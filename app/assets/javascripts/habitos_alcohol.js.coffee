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