# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(window).load ->
	$('#persona_examen_examen_id').change ->
		examen = this;
		$.ajax
		  type: "POST"
		  url: '/agregar_examen'
		  data:
		    persona_id: 2
		    examen_id: $(this).val()
		    atencion_salud_id: 1
		  success: (response) ->
		    $(examen).after "</br>" + $(examen).val() 



	
	


