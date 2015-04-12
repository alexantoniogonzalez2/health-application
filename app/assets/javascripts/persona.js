$("form[id^='form-agregar-persona-'").submit(function (e) { return false; });

$("form[id^='form-agregar-persona-'").bootstrapValidator({
	live: 'submitted',
	fields: {
		sexo: { validators: { notEmpty: { message: 'Este campo es requerido' } } },
		email: { validators: { emailAddress: { message: 'Ingresa una dirección válida de correo electrónico' } } } ,
		rut: { validators: { digits: { message: 'Ingresa solo números' } } },
		rut: { validators: { validarRut: { message: 'El RUT ingresado no es válido' } } },
	},
  onSuccess: function(e) {
  	var id = $(e.target).attr('id').substring(21);
  	var nombre = $('#nombre'+id).val();
  	var apep = $('#apellido_paterno'+id).val();
  	var apem = $('#apellido_materno'+id).val();
  	var relacion = $('#select-relacion'+id).val();
  	var rut = $('#rut'+id).val();
  	var dv = $('#dv'+id).val();
  	var correo = $('#email'+id).val();
  	var celular =  $('#telefono'+id).val();
    var codigo = $('#codigo'+id).val();
  	var fecha_nacimiento = $('#fecha'+id).val();
    var sexo = $('#sexo'+id).val();
  	var otro = $('#otro'+id).val();

    if (typeof atencion_salud_id !== 'undefined') 
      at_salud_id = atencion_salud_id;
    else
      at_salud_id = 'persona';

  	$.ajax({
      type: 'POST',
      url: '/agregar_persona',
      data: { 
        nombre: nombre ,
        apep: apep,
        apem: apem,
        relacion: relacion,
        rut: rut,
        dv: dv,
        correo: correo,
        celular: celular,
        codigo: codigo,
        fecha_nacimiento: fecha_nacimiento,
        atencion_salud_id: at_salud_id,
        sexo: sexo,
        otro: otro,
      },
      success: function(response){
        if (response.success){       
        	$("#select_"+id).append('<option value='+response.id+'>'+response.text+'</option>');
          $("#select_"+id).val(response.id);
         	cerrarModalAgregarPersona(id); 
          $("#select_"+id).trigger("change");
          $(e.target).data('bootstrapValidator').resetForm();
        }
        else
           alert("Ya existe ese correo electrónico en la base de datos."); 

      },
      error: function(xhr, status, error){ alert("No se pudo cargar la persona."); }
    }); 
    
  }
});

 $.fn.bootstrapValidator.validators.validarRut = {
    
    validate: function(validator, $field, options) {
    	var rut = $field.val();
    	var id = $field.attr('id').substring(3);
			var respuesta = false;

		  if (rut != '' ){
		    dv = $('#dv'+id).val();
		    if (dv === 'k')
		      dv = 'K';
		    verificacion = jQuery.calculaDigitoVerificador(rut);
		    if (dv == verificacion)
		      respuesta = true;     
		  } 

		  return respuesta;

    }
  }

$(".label_better").label_better({
    position: "top",
    animationTime: 500,
    easing: "ease-in-out",
    offset: 5
});