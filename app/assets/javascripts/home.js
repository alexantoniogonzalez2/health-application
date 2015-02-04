var current = $('#datetimepicker1').val();
function keep_checking() {

    if (current != $('#datetimepicker1').val()) {
        $('#new_user').bootstrapValidator('revalidateField', 'date');
        current = $('#datetimepicker1').val();
    }
    setTimeout(keep_checking, 2000);
}
keep_checking();

$('#rut').keyup( function(e) { $('.error-rut').hide(); })
$('#user_password,#user_password_confirmation').keyup( function(e) { $('.error-password').hide(); })

if (($('#span-sign-in').text()).trim() ){
  $('#sign-in-error').css( "display", "block !important");
  $('#sign-in-error').show(); 
}

if (($('#span-recuperar').text()).trim() ){
  $('#recuperar-error').css( "display", "block !important");
  $('#recuperar-error').show(); 
}

if (($('#span-cuenta').text()).trim() ){
  $('#cuenta-error').css( "display", "block !important");
  $('#cuenta-error').show(); 
}

if (($('#span-password').text()).trim() ){
  $('#password-error').css( "display", "block !important");
  $('#password-error').show(); 
}

$("#sign-in-form").submit(function (e) { 
  var respuesta = false;
  if ( $('#user_email').val().length > 0 && $('#user_password').val().length  )
    respuesta = true;
  return respuesta;
});

$("#new_user").submit(function (e) { 
  
  var respuesta = true;

  rut = $('#rut').val();
  if (rut != '' ){
    dv = $('#dv').val();
    if (dv === 'k')
      dv = 'K';
    verificacion = jQuery.calculaDigitoVerificador(rut);
    if (dv != verificacion){
      respuesta = false;
      $('.error-rut').show();
    }      
  } 
  else
    respuesta = false;

  password = $('#user_password').val();
  password_confirmation = $('#user_password_confirmation').val();
  if ( password != password_confirmation ){
    respuesta = false; 
     $('.error-password').show();
  }
  
  return respuesta;
});

$("#new_password").submit(function (e) { 
  
  var respuesta = true;
  password = $('#user_password').val();
  password_confirmation = $('#user_password_confirmation').val();
  if ( password != password_confirmation ){
    respuesta = false; 
     $('.error-password').show();
  }
  
  return respuesta;
});


$("#contactForm").submit(function (e) { return false; });

$('#sign-in-form').bootstrapValidator({
  fields: {
    'user[email]': {
        validators: {
          emailAddress: { message: 'Ingresa una dirección válida de correo electrónico' }
        }
    }
  },
  onError: function(e) {
    $('#inicia_sesion').prop("disabled", false);
  }
})

$('#sign-in-form2').bootstrapValidator({
  fields: { 'user[email]': { validators: { emailAddress: { message: 'Ingresa una dirección válida de correo electrónico' } } } }
})

$('#datetimepicker1').datetimepicker({
    locale: 'es',
    format: 'DD/MM/YYYY',
    viewMode: 'years',
});

$('#new_user').bootstrapValidator({
  fields: { 
    'user[email]': { validators: { emailAddress: { message: 'Ingresa una dirección válida de correo electrónico' } } } ,
    sexo: { validators: { notEmpty: { message: 'Este campo es requerido' } } },
    rut: { validators: { digits: { message: 'Ingresa solo números' } } },
    'user[password]': { validators: { stringLength: { message: 'Ingresa una contraseña de al menos 6 carácteres' }, notEmpty: { message: 'La contraseña es requerida' } } },
    'user[password_confirmation]': { validators: { stringLength: { message: 'Ingresa una contraseña de al menos 6 carácteres', notEmpty: { message: 'La contraseña es requerida' } } } },
    date: { validators: { notEmpty: { message: 'La fecha de nacimiento es requerida' }, date: { format: 'DD/MM/YYYY', min: '01/01/1900', max: '01/01/2016',  message: 'Formato no válido o fecha incorrecta' } } }
  }
})

$('#new_password').bootstrapValidator({
  fields: { 
    'user[password]': { validators: { stringLength: { message: 'Ingresa una contraseña de al menos 6 carácteres' }, notEmpty: { message: 'La contraseña es requerida' } } },
    'user[password_confirmation]': { validators: { stringLength: { message: 'Ingresa una contraseña de al menos 6 carácteres', notEmpty: { message: 'La contraseña es requerida' } } } },
  }
})

$('#contactForm').bootstrapValidator({
  fields: { 'email': { validators: { emailAddress: { message: 'Ingresa una dirección válida de correo electrónico' } } } }
});

$('#recuperar').bootstrapValidator({
  fields: { 'user[email]': { validators: { emailAddress: { message: 'Ingresa una dirección válida de correo electrónico' } } } }
})

$('#sign-in-form').find('#user_email').change(function () {
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
	    success: function(response) { $('a, button').toggleClass('active');  },
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

$( ".datepicker" ).attr("placeholder", "Ingresa tu fecha de nacimiento").datepicker({
  yearRange: '1910:2015',
  showOtherMonths: true,
  selectOtherMonths: true,
  changeMonth: true,
  changeYear: true,
  dateFormat: 'yy-mm-dd',
  dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
  showButtonPanel: true, 
  
});
  

$.datepicker.regional['es'] = {
  closeText: 'Cerrar',
  prevText: 'Anterior',
  nextText: 'Siguiente',
  currentText: 'Hoy',
  monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
  monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
  dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
  dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
  weekHeader: 'Sm',
  dateFormat: 'yy-mm-dd',
  firstDay: 1,
  isRTL: false,
  showMonthAfterYear: false,
  yearSuffix: ''
};
$.datepicker.setDefaults($.datepicker.regional['es']);

/*
 * Calcula digito verificador
 */
$.calculaDigitoVerificador = function (rut) {
  // type check
  if (!rut || !rut.length || typeof rut !== 'string') {
    return -1;
  }
  // serie numerica
  var secuencia = [2,3,4,5,6,7,2,3];
  var sum = 0;
  //
  for (var i=rut.length - 1; i >=0; i--) {
    var d = rut.charAt(i)
    sum += new Number(d)*secuencia[rut.length - (i + 1)];
  };
  // sum mod 11
  var rest = 11 - (sum % 11);
  // si es 11, retorna 0, sino si es 10 retorna K,
  // en caso contrario retorna el numero
  return rest === 11 ? 0 : rest === 10 ? "K" : rest;
};