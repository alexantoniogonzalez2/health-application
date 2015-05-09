function cargarMotivos(){

	$('select.select_especialidad').select2({ width: '80%', placeholder: 'Seleccione una especialidad', allowClear: true });
	$('select.select_especialista').select2({ width: '80%', placeholder: 'Seleccione un especialista', allowClear: true });

	$('input[type=radio][name^=radios-motivo-]').change(function() {
	  var id_agend = $(this).attr('name').substring(14);
	  var m_c = $('#m_c_'+id_agend).find('input[name=radios-motivo-'+id_agend+']:checked').val();
	  if (m_c == 1 ){
	  	$('#select-motivo-'+id_agend).hide();
	  	$('#select-motivo-'+id_agend).prop('selectedIndex',0);
	  	$('#select-capitulo-'+id_agend).show();
	  } 
	  else {
	  	$('#select-motivo-'+id_agend).show();
	  	
	  	if($('#select-motivo-'+id_agend).length ){
	  		$('#select-capitulo-'+id_agend).hide();
	  		$('#select-capitulo-'+id_agend).prop('selectedIndex',0)

			} else { $('#select-capitulo-'+id_agend).show(); };
	  
	  };

	  return m_c;

	});

}

if ( $( "#profesional" ).length ){
	  
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

	$('select.select_especialidad').select2({ width: '80%', placeholder: 'Seleccione una especialidad', allowClear: true });
	$('select.select_especialista').select2({ width: '80%', placeholder: 'Seleccione un especialista', allowClear: true });

});


$("#select_especialidad").on("change", function(e) { 

  var value = $("#select_especialidad").val();

  $("#select_especialista").val('');
  
  $.ajax({
    type: 'POST',
    url: '/filtrar_profesionales',
    data: {
      especialidad: value,     
    },
    success: function(response) {
    	$('#select_especialista').val('');
    	$('#select_especialista').empty(); //remove all child nodes
      var newOption = response
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
			
			content: {text: event.description,title: event.custom },
			style: {
				classes: 'qtip-bootstrap',					
			},
			position: {
			   viewport: $(window)
			}
		})
	},
	eventAfterRender: function(event, element, view) {
		var span = element.find("span");
		var div = element.find(".fc-time");
		div.attr('data-start', span.text());
	},
	eventClick: function(calEvent, jsEvent, view){
				
		// Mostramos el detalle del evento
		$.ajax({
			type: 'POST',
			url: '/aux/detalleEvento',
			data: {	agendamiento_id: calEvent.id },
			success: function(response) {

			$('#modal-content').html(response);
    	$('#modal-container').modal('show')	
    	motivo = cargarMotivos();


			// Si existe el botón "cancelar-hora", le pondrá la siguiente acción al hacer click
			$('#modal-content .modal-footer .cancelar-hora').click(function(){

				$.ajax({
					type: 'POST',
					url: '/aux/cancelarHora',
					data: {	agendamiento_id: calEvent.id},
					success: function(response) {

						id=calEvent.id
						$('#buscadorHora').fullCalendar('removeEvents',id)

						if ( response=="1"){ $('#modal-container').modal('hide') }
						else{	alert("No se puede cancelar la hora")	}

						// Re-cargamos el evento modificado
						$.ajax({
							type: 'POST',
							url: '/aux/mostrarEventos',
							data: {
								evento_id: id,
								especialidad_id: especialidad_id,
								profesional_id: profesional_id,
								prestador_id: prestador_id,
							},
							success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response);	},
							error: function(xhr, status, error){	alert("No se pudieron cargar las horas de atención");	}
						});
					},
					error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
				});	 				
 			});

			// Si existe el botón "bloquear-hora", le pondrá la siguiente acción al hacer click
			$('#modal-content .modal-footer .bloquear-hora').click(function(){

				$.ajax({
					type: 'POST',
					url: '/bloquear_hora',
					data: {	agendamiento_id: calEvent.id},
					success: function(response) {

						id=calEvent.id
						$('#buscadorHora').fullCalendar('removeEvents',id)

						if ( response=="1"){ $('#modal-container').modal('hide') }
						else{	alert("No se pudo bloquear la hora")	}

						// Re-cargamos el evento modificado
						$.ajax({
							type: 'POST',
							url: '/aux/mostrarEventos',
							data: {
								evento_id: id,
								especialidad_id: especialidad_id,
								profesional_id: profesional_id,
								prestador_id: prestador_id,
							},
							success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response);	},
							error: function(xhr, status, error){	alert("Hubo un problema al bloquear la hora de atención.");	}
						});
					},
					error: function(xhr, status, error){ alert("No se pudo bloquear la hora de atención."); }
				});	 				
 			});

 			// Si existe el botón "bloquear-hora", le pondrá la siguiente acción al hacer click
			$('#modal-content .modal-footer .desbloquear-hora').click(function(){

				$.ajax({
					type: 'POST',
					url: '/desbloquear_hora',
					data: {	agendamiento_id: calEvent.id},
					success: function(response) {

						id=calEvent.id
						$('#buscadorHora').fullCalendar('removeEvents',id)

						if ( response=="1"){ $('#modal-container').modal('hide') }
						else{	alert("No se pudo desbloquear la hora")	}

						// Re-cargamos el evento modificado
						$.ajax({
							type: 'POST',
							url: '/aux/mostrarEventos',
							data: {
								evento_id: id,
								especialidad_id: especialidad_id,
								profesional_id: profesional_id,
								prestador_id: prestador_id,
							},
							success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response);	},
							error: function(xhr, status, error){	alert("Hubo un problema al desbloquear la hora de atención.");	}
						});
					},
					error: function(xhr, status, error){ alert("No se pudo desbloquear la hora de atención."); }
				});	 				
 			});
				
				
			// Si existe el botón "confirmar-hora", le pondrá la siguiente acción al hacer click
			$('#modal-content .modal-footer .confirmar-hora').click(function(){

				$.ajax({
			 		type: 'POST',
			 		url: '/aux/confirmarHora',
			 		data: {	agendamiento_id: calEvent.id	},
					success: function(response) {

						id=calEvent.id
						$('#buscadorHora').fullCalendar('removeEvents',id)
						if (response=="1"){	$('#modal-container').modal('hide') }
						else{	alert("No se puede confirmar la hora") }

						// Re-cargamos el evento modificado
						$.ajax({
							type: 'POST',
							url: '/aux/mostrarEventos',
							data: {
								evento_id: id,
								especialidad_id: especialidad_id,
								profesional_id: profesional_id,
								prestador_id: prestador_id,
							},
							success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response);	},
							error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención");}
						});
					},
					error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención");}
				});					
			});


			// Si existe el botón "marcar-llegada", le pondrá la siguiente acción al hacer click
			$('#modal-content .modal-footer .marcar-llegada').click(function(){

				$.ajax({
					type: 'POST',
					url: '/aux/marcarLlegada',
					data: {	agendamiento_id: calEvent.id	},
					success: function(response) {
						id=calEvent.id
						$('#buscadorHora').fullCalendar('removeEvents',id)
						if (response=="1"){ $('#modal-container').modal('hide') }
						else{	alert("No se puede confirmar la hora")			}

						// Re-cargamos el evento modificado
						$.ajax({
							type: 'POST',
							url: '/aux/mostrarEventos',
							data: {
								evento_id: id,
								especialidad_id: especialidad_id,
								profesional_id: profesional_id,
								prestador_id: prestador_id,
							},
							success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response);	},
							error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
						});
					},
					error: function(xhr, status, error){alert("No se pudieron cargar las horas de atención");	}
				});
			});


			// Si existe el botón "pedir-hora", le pondrá la siguiente acción al hacer click
			$('#modal-content .modal-footer .pedir-hora').click(function(){

				id_agend = calEvent.id
				m_c = $('#m_c_'+id_agend).find('input[name=radios-motivo-'+id_agend+']:checked').val();	
				s_m = $('#select-motivo-'+id_agend).val();
				s_c = $('#select-capitulo-'+id_agend).val();	
				s_p = $('#select-paciente-'+id_agend).val();	
				
				$.ajax({
					type: 'POST',
					url: '/aux/pedirHoraEvento',
					data: {	
						agendamiento_id: id_agend,
						motivo: m_c,
						antecedente: s_m,
						capitulo_cie_10: s_c,
						paciente: s_p
					},
					success: function(response) {

						$('#buscadorHora').fullCalendar('removeEvents',id_agend)
						response == "1" ? $('#modal-container').modal('hide')	:	alert("La hora ya fue tomada");

						// Re-cargamos el evento modificado
						$.ajax({
							type: 'POST',
							url: '/aux/mostrarEventos',
							data: {
								evento_id: id_agend,
								especialidad_id: especialidad_id,
								profesional_id: profesional_id,
								prestador_id: prestador_id
							},
							success: function(response) {	$('#buscadorHora').fullCalendar('addEventSource',response);	},
							error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
						});
					},
					error: function(xhr, status, error){alert("No se pudieron cargar las horas de atención");	}
				});
			});

			},
			error: function(xhr, status, error){	alert("No se pudieron cargar las horas de atención");	}
		});
	}	

})

function actualizarCentro(){

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
	
	if(especialidad != '' || especialista != ''){

	  $.ajax({
	    type: 'POST',
	    url: '/buscar_horas',
	    data: {
	      centros: centros_seleccionados, 
	      especialidad: especialidad,
	      especialista: especialista,    
	    },
	    success: function(response) {
	    	  $('#buscadorHora').fullCalendar('addEventSource',response);
	    },
	    error: function(xhr, status, error){ alert("Error al filtrar por especialidad.4"); }
	  }); 		
	}
	else{	alert('Seleccione una especialidad o un especialista.'); }
	 
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


//Este código es para simular el efecto árbol del checkbox
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
	      function() {
	          $(this).parents('fieldset:eq(0)').find('.childCheckBox').prop('checked', this.checked);
	      }
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

//Muestra la agenda que no se renderiza al estar oculta
$('#nav-antecedentes').on('shown.bs.tab', function (e) {
  var target = $(e.target).attr("href") // activated tab
  if (target == "#agenda" || target == "#horas" )
  	jQuery('#buscadorHora').fullCalendar('render');
});
