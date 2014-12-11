# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".datepicker").attr("placeholder", "Seleccione una fecha").datepicker
	showOtherMonths: true
	selectOtherMonths: true
	changeMonth: true
	changeYear: true
	dateFormat: 'yy-mm-dd'
	dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sa']
	showButtonPanel: true
	onSelect: (dateText) -> calcularPaquetes()

$("#cigarrosdia").keyup ->
	calcularPaquetes()

$('.guardar-consumo').on 'click' , ->	
 	tipo = $(this).attr "name"
 	id = $(this).attr "id"
 	f_i = $('#f_i').datepicker("getDate")
 	f_f = $('#f_f').datepicker("getDate")
 	cigarrosDia = $("#cigarrosdia").val()
 	paquetesAgno = $("#paquetesAgno").val()
 	$("#alert-cigarros-dia").show() if cigarrosDia < 1
 	$("#alert-fecha-inicio").show() if f_i == null
 	$("#alert-fecha-final").show() if f_f == null
 	valid = if cigarrosDia < 1 or f_i == null or f_f == null then false else true
 	guardarConsumo(f_i,f_f,cigarrosDia,paquetesAgno,tipo,id) if valid
			
		
alertMessage = ->
  $('#alert-fecha').show()
  $("#paquetesAgno").val('')
  $('#f_f').datepicker('setDate', null);

hideMessage = ->
  $('#alert-fecha').hide() 
  $('#alert-fecha-inicio').hide()
  $('#alert-fecha-final').hide()
  $('#alert-cigarros-dia').hide()  	

calcularPaquetes = ->	
	hideMessage()
	cigarrosDia = $("#cigarrosdia").val()
	f_i = $('#f_i').datepicker("getDate")
	f_f = $('#f_f').datepicker("getDate")
	unless f_i == null or f_f == null
		if f_i > f_f 
			alertMessage()
		else 	
			paquetesAgno = (cigarrosDia/20*(f_f - f_i)/(86400000*365)).toFixed(2)
			$("#paquetesAgno").val(paquetesAgno)

guardarConsumo = (f_i,f_f,cigarrosDia,paquetesAgno,tipo,id) ->
	$.ajax '/habitos_tabaco',
    type: 'POST'
    data:
    	f_i : f_i
    	f_f : f_f
    	cigarrosDia : cigarrosDia
    	paquetesAgno : paquetesAgno
    	tipo: tipo
    	id: id 
    error: (jqXHR, textStatus, errorThrown) ->       
    success: (data, textStatus, jqXHR) -> window.location.href = '/habitos_tabaco/index'							