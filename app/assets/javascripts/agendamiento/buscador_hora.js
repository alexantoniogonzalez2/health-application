if ( $( "#profesional" ).length ){
	  
	$.ajax({
    type: 'POST',
    url: '/buscar_horas_profesional',
    data: {  },
    success: function(response) {
    	  $('#buscadorHora').fullCalendar('addEventSource',response);
    },
    error: function(xhr, status, error){ alert("Error al filtrar por especialidad."); }
  });
}

$(document).ready(function() {	

	$(".chosen-select").chosen({
    no_results_text: 'No hubo coincidencias.',
    width: '300px',
    allow_single_deselect: true

	}); 

});

$('#buscadorHora').fullCalendar({

	header: {
		left: 'prev,next month,agendaWeek,agendaDay,today',
		center: '',
		right: 'title',
	},
	dayNames: ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'],
	dayNamesShort: ['Dom','Lun','Mar','Mie','Jue','Vie','Sáb'],
	monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
	monthNamesShort:['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'],
	timeFormat: {
		agenda: 'H:mm{ - H:mm}',
		'': 'H:mm {- H:mm}'
	},
	titleFormat:{
		month: 'MMMM yyyy',
		week: 'd MMMM { - d MMMM}',
		day: 'd MMMM yyyy',

	},
	slotMinutes: 30,
	firstHour: 8,
	maxTime: 20,
	minTime: 8,
	columnFormat: {
		day: 'dddd d',
		week: 'dddd d',
		month: 'dddd',
	},
	selectable: true,
	buttonText: {
    today: 'Hoy',
    month: 'Mes',
    week: 'Semana',
    day: 'Día'
	},
	axisFormat: 'H:mm',
	allDaySlot:false,
	firstDay: 1,
	editable: false,
	defaultView: 'agendaWeek',     
  eventRender: function(event,element){
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
	eventClick: function(calEvent, jsEvent, view){
				
		// Mostramos el detalle del evento
		$.ajax({
			type: 'POST',
			url: '/aux/detalleEvento',
			data: {	agendamiento_id: calEvent.id },
			success: function(response) {

			$('#modal-content').html(response);
    	$('#modal-container').modal('show')	

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
				
				$.ajax({
					type: 'POST',
					url: '/aux/pedirHoraEvento',
					data: {	agendamiento_id: calEvent.id	},
					success: function(response) {

						id=calEvent.id
						$('#buscadorHora').fullCalendar('removeEvents',id)
						if (response=="1"){	$('#modal-container').modal('hide')	}
						else{	alert("La hora ya fue tomada")}

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

			},
			error: function(xhr, status, error){	alert("No se pudieron cargar las horas de atención");	}
		});
	}	

})

$("#select_especialidad").on("change", function(e) { 

  var value = $("#select_especialidad").val();
  var text = $('#select_especialidad option:selected').html();

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
      $('#select_especialista').trigger("chosen:updated");     
    },
    error: function(xhr, status, error){ alert("Error al filtrar por especialidad."); }
  });  

  $('#buscadorHora').fullCalendar('removeEvents');
  actualizarCentro();

})

$("#select_especialista").on("change", function(e) { 

  var value = $("#select_especialista").val();
  var text = $('#select_especialista option:selected').html();
  
  $('#buscadorHora').fullCalendar('removeEvents');
  actualizarCentro();

})



function actualizarCentro(){

	var centros_seleccionados = new Array();
	var fieldset = document.getElementById("checkbox_centros")
  var cent_sel = fieldset.getElementsByTagName("input");	

	for (var i=1;i<cent_sel.length;i++){ 

		if( cent_sel[i].checked )			
			centros_seleccionados.push(cent_sel[i].value); 	

	}

	var especialidad = $("#select_especialidad").val();
	var especialista = $("#select_especialista").val();
	
	if (centros_seleccionados.length > 0 ){
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
		    error: function(xhr, status, error){ alert("Error al filtrar por especialidad."); }
		  }); 		
		}
		else{
			alert('Seleccione una especialidad o un especialista.');
		}
	}
	else{
		
	}  



}

function actualizarTodosLosCentros(){

  var cent_sel = document.getElementById("parentCheckBox");	

	if(cent_sel.checked ){
		var especialidades = $('#select_especialidad option').attr('disabled', false);		
		$('#select_especialidad').trigger("chosen:updated");

		var especialistas = $('#select_especialista option').attr('disabled', false);
		$('#select_especialista').trigger("chosen:updated"); 

		 actualizarCentro();
	}
	else{
		var especialidades = $('#select_especialidad option').attr('disabled', true);
		$('#select_especialidad').trigger("chosen:updated");

		var especialistas = $('#select_especialista option').attr('disabled', true);
		$('#select_especialista').trigger("chosen:updated");  

		$('#select_especialidad').val('');
		$('#select_especialidad').trigger("chosen:updated");
		$('#select_especialista').val('');
		$('#select_especialista').trigger("chosen:updated");
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