$("form[id^='form-agregar-persona-'").submit(function (e) { return false; });

$("form[id^='form-agregar-persona-'").bootstrapValidator({
  live: 'disabled',
	fields: {
		sexo: { validators: { notEmpty: { message: 'Este campo es requerido' } } },
		email: { validators: { emailAddress: { message: 'Ingresa una dirección válida de correo electrónico' } } } ,
		rut: { validators: { digits: { message: 'Ingresa solo números' } } },
		rut: { validators: { validarRut: { message: 'El RUT ingresado no es válido' } } },
    telefono: { validators: { digits: { message: 'Ingresa solo números' } } },
    otra_relacion: {  validators: {
                        callback: {
                            message: 'Especificar otra relación',
                            callback: function(value, validator, $field) {
                              var hook = $field[0].id.substring(4);                                
                              var relacion = $('#form-agregar-persona-'+hook).find('[name="select_relacion"]').val();
                              return (relacion !== '5') ? true : (value !== '');
                            }
                        }
                    }
                  },
    codigo: {  validators: {
                    callback: {
                        message: 'Especificar tipo de teléfono',
                        callback: function(value, validator, $field) {
                            var hook = $field[0].id.substring(6);
                            var telefono = $('#form-agregar-persona-'+hook).find('[name="telefono"]').val();                           
                            return (telefono == '') ? true : (value != null );
                        }
                    }
                }
              },              

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
    var sexo = $('input[name=sexo'+id+']:checked').val();
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
        iniciador: id,
      },
      success: function(response){
          if (id == 'fam'){
            if ( typeof response.success !== 'undefined' ){
              if (response.success){ 
                cerrarModalAgregarPersona(id);      
                $(e.target).data('bootstrapValidator').resetForm(); 
              } else
                alert("Ya existe ese correo electrónico en la base de datos."); 
            } else { 
              cerrarModalAgregarPersona(id);      
              $(e.target).data('bootstrapValidator').resetForm(); 
            }     

          }
          else {
            if (response.success){ 
              $("#select_"+id).append('<option value='+response.id+'>'+response.text+'</option>');
              $("#select_"+id).val(response.id);            
              $("#select_"+id).trigger("change");             
              cerrarModalAgregarPersona(id);      
            	$(e.target).data('bootstrapValidator').resetForm(); 
            } else
              alert("Ya existe ese correo electrónico en la base de datos."); 
        }
        

      },
      error: function(xhr, status, error){ alert("No se pudo agregar la persona."); }
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