# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#diag").select2
		ajax:
		  type: "POST"
		  url: "/agregar_diagnostico"
		  data:
		    persona_id: 1
		    diagnostico_id: $("#diag").select2("val")
		    atencion_salud_id: 1
		  success: (response) ->
		    $("#diagnostico-div").append "hola"
		    return
		  error: (xhr, status, error) ->
		    alert "No se pudieron cargar las horas de atención"
		    return
		  



	
	


