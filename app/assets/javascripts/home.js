$(document).ready(function() {
    $('#contactForm').bootstrapValidator();
});

$(window).scroll(function() {
  var height = $(window).scrollTop();

  if(height  > 50) {
    $(".navbar-fixed-top").removeClass( 'navbar-ajuste' );
    $(".navbar-fixed-top").addClass( 'navbar-ajuste2' );
    $("a").removeClass( 'active-ajuste' );
    $("a.active").addClass( 'active-ajuste' );
  }
  else {
  	$(".navbar-fixed-top").addClass( 'navbar-ajuste' );
  	$(".navbar-fixed-top").removeClass( 'navbar-ajuste2' );
  	$("a").removeClass( 'active-ajuste' );
  }   
      
  $('section').each(function(i) {
  	var position = $(this).position().top;
    if ( position <= height + 50 ) {   	
        $('.navbar-fixed-top a.active').removeClass('active');
        $('.navbar-fixed-top a').eq(i+1).addClass('active');        
    }
    if ( 0 < height &&  height < 930 )
    	$('.home').css("background-image", "url(../assets/bg1.jpg)");
    if ( 930 <= height &&  height < 1600 )
    	$('.home').css("background-image", "url(../assets/bg2.jpg)");
    if ( 1600 <= height &&  height < 2430 )	
    	$('.home').css("background-image", "url(../assets/bg3.jpg)");
    if ( 2430 <= height &&  height < 3630 )	
    	$('.home').css("background-image", "url(../assets/bg4.jpg)");
    if ( 3630 <= height &&  height < 4530 )	
    	$('.home').css("background-image", "url(../assets/bg5.jpg)");
    if ( 4530 <= height  )	
    	$('.home').css("background-image", "url(../assets/bg6.jpg)");

  });
});


$("input.label_better").label_better({
    position: "top",
    animationTime: 500,
    easing: "ease-in-out",
    offset: 5
});

$("input.label_better2").label_better({
    position: "top",
    animationTime: 500,
    easing: "ease",
    offset: 40
});

$("textarea.label_better2").label_better({
    position: "top",
    animationTime: 500,
    easing: "ease",
    offset: 180,
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
  
