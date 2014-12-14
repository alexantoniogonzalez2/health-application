$("input.label_better").label_better({
    position: "top",
    animationTime: 500,
    easing: "ease-in-out",
    offset: 20
  });

function actualizar_atenciones(){
  $('a, button').toggleClass('active'); 
	$.ajax({
	    type: 'POST',
	    url: '/actualizar_atenciones',
	    data: { },
	    success: function(response) { $('a, button').toggleClass('active');},
	    error: function(xhr, status, error ){}
	  });
}

$("#actualizar , #actualizar2 ").on("click", function(){ actualizar_atenciones();	});

if ($('#horas-agendadas').length || $('#atencion-salud').length ){	

	window.setInterval(function(){

	 $.ajax({
	    type: 'POST',
	    url: '/revisar_actualizaciones',
	    data: {  },
	    success: function(response) { 
	    	
	    	if (response.respuesta){
	    		actualizar_atenciones();
	    		if ( $('#atencion-salud').length ){

						for (var index = 0; index < response.llegadas.length; ++index) {
						    createGrowl(false,'Llegó paciente de las '+response.llegadas[index].hora_comienzo);
						}
	    			
	    		}
	    	}	
	    },
	    error: function(xhr, status, error){}
	  });
	  
	}, 30000);

}
  
