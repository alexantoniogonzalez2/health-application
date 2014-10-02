# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready -> 
	$(".datepicker").attr("placeholder", "Seleccione una fecha").datepicker
		showOtherMonths: true
		selectOtherMonths: true
		changeMonth: true
		changeYear: true
		dateFormat: 'yy-mm-dd'
		dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sa']
		showButtonPanel: true
		onSelect: hola = (dateText) -> calcularPaquetes 1

	$("#cigarrosdia").keyup ->
		calcularPaquetes 1

calcularPaquetes = (arg) ->
	alert 'hola'		