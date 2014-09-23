# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready -> 
	$('#button1id').on 'click' , =>	
		valid = true
		for i in [1..10] by 1
			hideMessage i
			unless $("input[name=question-"+i+"]:checked").size() > 0
				valid = false
				alertMessage i
		if valid			
			saveTest 1		

alertMessage = (messageId) ->
  $("#alert-"+messageId).show();
  return

hideMessage = (messageId) ->
  $("#alert-"+messageId).hide();
  return  

saveTest = (arg) ->
	alert('chao')
	$.ajax '/habitos_alcohol',
    type: 'POST'
    data:
    	param : 'param' 
    error: (jqXHR, textStatus, errorThrown) ->  window.location.href = "/habitos_alcohol/show"      
    success: (data, textStatus, jqXHR) ->
   
	  