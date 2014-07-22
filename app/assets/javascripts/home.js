

$("#actualizar").on("click", function(){

	 actualizar_atenciones();

 });

function actualizar_atenciones(){
	$.ajax({
	    type: 'POST',
	    url: '/actualizar_atenciones',
	    data: {
	     
	    },
	    success: function(response) {  },
	    error: function(xhr, status, error){}
	  });
}

$( document ).ready(function() {

  $("#actualizar").on("click", function(){ actualizar_atenciones();	});

  if ($('#horas-agendadas').length){	

		window.setInterval(function(){

		 $.ajax({
		    type: 'POST',
		    url: '/revisar_actualizaciones',
		    data: {
		     
		    },
		    success: function(response) { 
		    	if (response.respuesta)
		    		actualizar_atenciones();
		     },
		    error: function(xhr, status, error){}
		  });
		  
		}, 30000);

	}
  
});