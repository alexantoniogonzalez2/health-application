$("#contactForm").submit(function (e) { return false; });
$("#sign-in-form").submit(function (e) { return false; });
/*
$('#sign-in-form').bootstrapValidator({

   framework: 'bootstrap',
            icon: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                'user[email]': {
                    validators: {
                        notEmpty: {
                            message: 'The name is required'
                        }
                    }
                },
            }


});*/

$('#contactForm').bootstrapValidator();

$('#user_email').change(function () {
  if ($('#user_email').val().length > 0 ){
    if (!$('#lb_labeluser_email').length)
      ajuste_label_better('user_email');
    if (!$('#lb_labeluser_password').length)
      ajuste_label_better('user_password');    
  }
  else {
    if ( $('#user_password').val().length < 1 )
     ajuste2_label_better('user_password');
  }
})

function ajuste2_label_better (label_better_id) {
  var settings = {
    position: "top",
    animationTime: 500,
    easing: "ease-in-out",
    offset: 5,
    hidePlaceholderOnFocus: true
  };
  btn = $('#'+label_better_id); 
  btn.parent().find(".lb_label").bind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd", function(){ $(this).remove(); }).removeAnimate(settings, btn)
  btn.parent().find(".lb_label").removeClass("active");
}

function ajuste_label_better (label_better_id) {
  var settings = {
    position: "top",
    animationTime: 500,
    easing: "ease-in-out",
    offset: 5,
    hidePlaceholderOnFocus: true
  };
  btn = $('#'+label_better_id); 
  var text = btn.data("new-placeholder")  || btn.attr("placeholder"),
  position = btn.data("position")  || settings.position;
  $("<div id='lb_label" + btn.attr("id") + "' class='lb_label " + position + "'>"+ text + "</div>").css("opacity", "0").insertAfter(btn).animateLabel(settings, btn);      
  btn.parent().find(".lb_label").addClass("active");
}

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
    	$('.home').css("background-image", "url(../assets/bg5.jpg)");
    if ( 1600 <= height &&  height < 2430 )	
    	$('.home').css("background-image", "url(../assets/bg3.jpg)");
    if ( 2430 <= height &&  height < 3630 )	
    	$('.home').css("background-image", "url(../assets/bg4.jpg)");
    if ( 3630 <= height &&  height < 4530 )	
    	$('.home').css("background-image", "url(../assets/bg2.jpg)");
    
  });
});

$(".label_better").label_better({
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
  
