function cargarMotivos(){

	$('select.select_especialidad').select2({ width: '80%', placeholder: 'Selecciona una especialidad', allowClear: true });
	$('select.select_especialista').select2({ width: '80%', placeholder: 'Selecciona un especialista', allowClear: true});

	$('input[type=radio][name^=radios-motivo-]').change(function() {
	  var id_agend = $(this).attr('name').substring(14);
	  var m_c = $('#m_c_'+id_agend).find('input[name=radios-motivo-'+id_agend+']:checked').val();
	  if (m_c == '1' ){
	  	
	  	$('#div-sel-ant-'+id_agend).hide();
	  	$('#select-antecedente-'+id_agend).val('').trigger('change');
	  	$('#div-sel-cap-'+id_agend).show();	  	
	  } 
	  else {
	  	
	  	$('#div-sel-ant-'+id_agend).show();
	  	if($('#div-sel-ant-'+id_agend).length ){	  		
	  		$('#div-sel-cap-'+id_agend).hide();
	  		$('#select-capitulo-'+id_agend).val('').trigger('change');
			} else { $('#div-sel-cap-'+id_agend).show(); };
	  
	  };

	  return m_c;

	});

}

if ( $("#iconos-leyenda").length > 0 ){	  
	$.ajax({
    type: 'POST',
    url: '/buscar_horas_profesional',
    data: {  },
    success: function(response) {
    	$('#buscadorHora').fullCalendar('addEventSource',response);
    },
    error: function(xhr, status, error){ alert("Error al filtrar por especialidad.2"); }
  });
}

$(document).ready(function() {	
	$('select.select_especialidad').select2({ width: '80%', allowClear: true, placeholder: 'Selecciona una especialidad'});
	$('select.select_especialista').select2({ width: '80%', allowClear: true, placeholder: 'Selecciona un especialista'});
});


$("#select_especialidad").on("change", function(e) { 

	var centros_seleccionados = new Array();
	var fieldset = document.getElementById("checkbox_centros");  
  if (fieldset != null){
	  var cent_sel = fieldset.getElementsByTagName("input");	
	  for (var i=1;i<cent_sel.length;i++){
			if( cent_sel[i].checked )			
				centros_seleccionados.push(cent_sel[i].value); 	
		}
	}

  var value = $("#select_especialidad").val();
  if (value != '' )
  	addLittleSpinner('cargando-especialistas');

  $("#select_especialista").val('');
  
  $.ajax({
    type: 'POST',
    url: '/filtrar_profesionales',
    data: { especialidad: value, centros: centros_seleccionados },
    success: function(response) {
    	$('#select_especialista').val('');
    	$('#select_especialista').empty(); //remove all child nodes
      var newOption = response;
      $('#select_especialista').append(response);
    },
    error: function(xhr, status, error){ alert("Error al filtrar por especialidad.3"); }
  });  

  $('#buscadorHora').fullCalendar('removeEvents');
  actualizarCentro();

})

$("#select_especialista").on("change", function(e) { 

  var value = $("#select_especialista").val();  
  $('#buscadorHora').fullCalendar('removeEvents');
  actualizarCentro();

})

$('#buscadorHora').fullCalendar({
	header: {
		left: 'prev,next today',
		center: 'title',
		right: 'month,agendaWeek,agendaDay',
	},
	lang: 'es',
	allDaySlot: false,
	slotMinutes: 30,
	minTime: '08:00:00',
	maxTime: '20:00:00',
	height: 'auto',
	selectable: true,
	buttonText: {
    today: 'Hoy',
    month: 'Mes',
    week: 'Semana',
    day: 'Día'
	},
	firstDay: 1,
	editable: false,
	defaultView: 'agendaWeek', 
	axisFormat: 'H:mm',
  eventRender: function(event,element,view){
		element.qtip({			
			content: { text: event.description, title: event.custom },
			style: { classes: 'qtip-bootstrap' },
			position: { viewport: $(window)}
		});
		if (event.icon != '')	
			element.find("div.fc-content").append("<img class='" + event.classIcon +"'' src='" + event.icon +"'>");

		
	},
	eventAfterRender: function(event, element, view) {
		var span = element.find("span");
		var div = element.find(".fc-time");
		div.attr('data-start', span.text());
	},
	eventClick: function(calEvent, jsEvent, view){
		$.ajax({
			type: 'POST',
			url: '/aux/detalleEvento',
			data: {	agendamiento_id: calEvent.id },
			success: function(response) { $('#modal-container-2').modal('show');	motivo = cargarMotivos(); },
			error: function(xhr, status, error){	alert("No se pudieron cargar las horas de atención");	}
		});
	}	

})

function actualizarCentro(){	
	$('#buscadorHora').fullCalendar('removeEvents');

	var centros_seleccionados = new Array();
	var fieldset = document.getElementById("checkbox_centros")
  
  if (fieldset != null){
	  var cent_sel = fieldset.getElementsByTagName("input");	

		for (var i=1;i<cent_sel.length;i++){
			if( cent_sel[i].checked )			
				centros_seleccionados.push(cent_sel[i].value); 	
		}
	}

	var especialidad = $("#select_especialidad").val();
	var especialista = $("#select_especialista").val();	
		
	if(especialidad != null || especialista != null){
		
		$("#select_especialista").prop("disabled", true);		
		$.ajax({
	    type: 'POST',
	    url: '/buscar_horas',
	    data: { centros: centros_seleccionados, especialidad: especialidad, especialista: especialista },
	    success: function(response) {																    	
    	  $('#buscadorHora').fullCalendar('addEventSource',response);	    	  
    	  $("#select_especialista").prop("disabled", false);
    	  $('#cargando-especialistas').html('');	    	 
	    },
	    error: function(xhr, status, error){ alert("Error al filtrar por especialidad.4"); }
	  }); 		
	}
	else {	/*alert('Selecciona una especialidad o un especialista.'); */}
}

function actualizarTodosLosCentros(){
  var cent_sel = document.getElementById("parentCheckBox");	
	if(cent_sel.checked ){
		var especialidades = $('#select_especialidad option').attr('disabled', false);	
		var especialistas = $('#select_especialista option').attr('disabled', false);
		actualizarCentro();
	}
	else{
		var especialidades = $('#select_especialidad option').attr('disabled', true);
		var especialistas = $('#select_especialista option').attr('disabled', true);
		$('#select_especialidad').val('');
		$('#select_especialista').val('');
		$('#buscadorHora').fullCalendar('removeEvents');		
	}	
}

//Efecto árbol de checkbox
$(document).ready(    
	function() {
	  $('fieldset').each(function(){
	  	var $childCheckboxes = $(this).find('input.childCheckBox'),
	  	no_checked = $childCheckboxes.filter(':checked').length;
	  	if($childCheckboxes.length == no_checked){
	   		$(this).find('.parentCheckBox').prop('checked',true);
	 		}
		});	    
	  $('input.childCheckBox').change(function() {
	    $(this).closest('fieldset').find('.parentCheckBox').prop('checked', $(this).closest('.content').find('.childCheckBox:checked').length === $(this).closest('.content').find('.childCheckBox').length ); 
	  });
	  //clicking the parent checkbox should check or uncheck all child checkboxes
	  $(".parentCheckBox").click(
      function() { $(this).parents('fieldset:eq(0)').find('.childCheckBox').prop('checked', this.checked); }
	  );
	  //clicking the last unchecked or checked checkbox should check or uncheck the parent checkbox
	  $('.childCheckBox').click(
      function() {
        if ($(this).parents('fieldset:eq(0)').find('.parentCheckBox').attr('checked') == true && this.checked == false)
            $(this).parents('fieldset:eq(0)').find('.parentCheckBox').attr('checked', false);
        if (this.checked == true) {
            var flag = true;
            $(this).parents('fieldset:eq(0)').find('.childCheckBox').each(
                function() {
                    if (this.checked == false)
                        flag = false;
                }
            );
            $(this).parents('fieldset:eq(0)').find('.parentCheckBox').attr('checked', flag);
        }
      }
	  );
	}
); 

//Muestra agenda que no se renderiza al estar oculta
$('#nav-antecedentes').on('shown.bs.tab', function (e) {
  var target = $(e.target).attr("href") // activated tab
  if (target == "#agenda" || target == "#horas" )
  	jQuery('#buscadorHora').fullCalendar('render');
});

function cancelarHora(id_agend){
	$.ajax({
		type: 'POST',
		url: '/aux/cancelarHora',
		data: {	agendamiento_id: id_agend},
		success: function(response) {
			$('#buscadorHora').fullCalendar('removeEvents',id_agend);
			$('#calendar').fullCalendar('removeEvents',id_agend);
			response == "1" ? $('[id^=modal-container-]').modal('hide') : alert("No se puede cancelar la hora");	
			$.ajax({
				type: 'POST',
				url: '/aux/mostrarEventos',
				data: { evento_id: id_agend, especialidad_id: especialidad_id, profesional_id: profesional_id, prestador_id: prestador_id },
				success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response); $('#calendar').fullCalendar('addEventSource',response);	},
				error: function(xhr, status, error){	alert("No se pudieron cargar las horas de atención");	}
			});
		},
		error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
	});	 				
}

function bloquearHora(id_agend){
	$.ajax({
		type: 'POST',
		url: '/bloquear_hora',
		data: {	agendamiento_id: id_agend},
		success: function(response) {
			$('#buscadorHora').fullCalendar('removeEvents',id_agend);
			$('#calendar').fullCalendar('removeEvents',id_agend);
			response == "1" ?	$('[id^=modal-container-]').modal('hide') :	alert("No se pudo bloquear la hora")
			$.ajax({
				type: 'POST',
				url: '/aux/mostrarEventos',
				data: {	evento_id: id_agend, especialidad_id: especialidad_id, profesional_id: profesional_id, prestador_id: prestador_id	},
				success: function(response) {	
					$('#buscadorHora').fullCalendar('addEventSource',response);
					$('#calendar').fullCalendar('addEventSource',response); 
					actualizar_atenciones();
				},
				error: function(xhr, status, error){	alert("Hubo un problema al bloquear la hora de atención.");	}
			});
		},
		error: function(xhr, status, error){ alert("No se pudo bloquear la hora de atención."); }
	});	 				
}

function desbloquearHora(id_agend){
	$.ajax({
		type: 'POST',
		url: '/desbloquear_hora',
		data: {	agendamiento_id: id_agend},
		success: function(response) {
			$('#buscadorHora').fullCalendar('removeEvents',id_agend);
			$('#calendar').fullCalendar('removeEvents',id_agend);
			response=="1" ? $('[id^=modal-container-]').modal('hide') :	alert("No se pudo desbloquear la hora");
			$.ajax({
				type: 'POST',
				url: '/aux/mostrarEventos',
				data: {	evento_id: id_agend, especialidad_id: especialidad_id, profesional_id: profesional_id, prestador_id: prestador_id	},
				success: function(response) {	
					$('#buscadorHora').fullCalendar('addEventSource',response);
					$('#calendar').fullCalendar('addEventSource',response);
					actualizar_atenciones();
				},
				error: function(xhr, status, error){	alert("Hubo un problema al desbloquear la hora de atención.");	}
			});
		},
		error: function(xhr, status, error){ alert("No se pudo desbloquear la hora de atención."); }
	});	
}			

function confirmarHora(id_agend){	
	$.ajax({
 		type: 'POST',
 		url: '/aux/confirmarHora',
 		data: {	agendamiento_id: id_agend},
		success: function(response) {
			$('#buscadorHora').fullCalendar('removeEvents',id_agend);
			$('#calendar').fullCalendar('removeEvents',id_agend);
			response=="1" ? $('[id^=modal-container-]').modal('hide') : alert("No se puede confirmar la hora");
			$.ajax({
				type: 'POST',
				url: '/aux/mostrarEventos',
				data: {	evento_id: id_agend, especialidad_id: especialidad_id, profesional_id: profesional_id, prestador_id: prestador_id	},
				success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response); $('#calendar').fullCalendar('addEventSource',response);	},
				error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención");}
			});
		},
		error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención");}
	});					
}

function marcarLlegada(id_agend){
	$.ajax({
		type: 'POST',
		url: '/aux/marcarLlegada',
		data: {	agendamiento_id: id_agend	},
		success: function(response) {
			$('#buscadorHora').fullCalendar('removeEvents',id_agend);
			$('#calendar').fullCalendar('removeEvents',id_agend);
			response=="1" ? $('[id^=modal-container-]').modal('hide'): alert("No se puede confirmar la hora");
			$.ajax({
				type: 'POST',
				url: '/aux/mostrarEventos',
				data: {	evento_id: id_agend, especialidad_id: especialidad_id, profesional_id: profesional_id, prestador_id: prestador_id },
				success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response); $('#calendar').fullCalendar('addEventSource',response);	},
				error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
			});
		},
		error: function(xhr, status, error){alert("No se pudieron cargar las horas de atención");	}
	});
}

function tomarHora(id_agend){
	m_c = $('#m_c_'+id_agend).find('input[name=radios-motivo-'+id_agend+']:checked').val();	
	s_m = $('#select-antecedente-'+id_agend).val();
	s_c = $('#select-capitulo-'+id_agend).val();	
	s_p = $('#select_pac_'+id_agend).val();
	s_qp = $('#select_ped_'+id_agend).val();
	s_ph = $('#select_age_'+id_agend).val();	

	if (s_p == '' || s_ph == '')
		alert("Selecciona una persona para asignar la hora.");
	else if (s_p != '' && s_qp == '' )
		alert("Selecciona quien pide la hora.");
	else {	
		$.ajax({
			type: 'POST',
			url: '/aux/pedirHoraEvento',
			data: {	agendamiento_id: id_agend, motivo: m_c,	antecedente: s_m,	capitulo_cie_10: s_c,	paciente: s_p, persona_hora: s_ph, quien_pide_hora: s_qp },
			success: function(response) {
				$('#buscadorHora').fullCalendar('removeEvents',id_agend);
				$('#calendar').fullCalendar('removeEvents',id_agend);
				if (response == "1") 
					$('[id^=modal-container-]').modal('hide');
				else if (response == "2")
				 	alert("La hora ya fue tomada");
				else if (response == "3")
				 	alert("La hora de inicio de esta hora ya pasó."); 
				$.ajax({
					type: 'POST',
					url: '/aux/mostrarEventos',
					data: {	evento_id: id_agend, especialidad_id: especialidad_id, profesional_id: profesional_id, prestador_id: prestador_id	},
					success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response);	$('#calendar').fullCalendar('addEventSource',response);},
					error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
				});
			},
			error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
		});
	}
}