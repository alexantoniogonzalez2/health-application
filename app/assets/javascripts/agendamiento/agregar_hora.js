var lastT=0;
var lastDate=null;
var especialidad_id = -1;
var profesional_id = -1;
var prestador_id = -1;

function cargarHoras(){

	if ( $('#calendar').length > 0 ){		
		$.ajax({
	    type: 'POST',
	    url: '/buscar_horas',
	    data: {
	      centros: prestador_id, 
	      especialidad: especialidad_id,
	      especialista: profesional_id,    
	    },
	    success: function(response) { $('#calendar').fullCalendar('addEventSource',response); },
	    error: function(xhr, status, error){ alert("Error al filtrar por especialidad.1"); }
	  });
	}
}

$(function(){

	$.validator.addMethod("hourFormat", function(value, element){
		if (!/^\d{2}:\d{2}$/.test(value)) return false;
	    var parts = value.split(':');
	    if (parts[0] > 23 || parts[1] > 59) return false;
	    return true;
	});

	$.validator.addMethod("positive", function(value, element){
		return value >= 5;
	});

	$.validator.addMethod("oneRequired", function(value, element){
		return value >= 0;
	});

	$.validator.addMethod("greaterOrEqualThan1",function(value, element, params){
		var ti=params[0].split('-')
		var tf=value.split('-');

		d_i=new Date(ti[2]+"-"+ti[1]+"-"+ti[0]+" 00:00:00.0")
		d_f=new Date(tf[2]+"-"+tf[1]+"-"+tf[0]+" 00:00:00.0")

		if (d_i>d_f) return false;
		return true;
	});

	

	$.validator.addMethod("greaterThan1",function(value, element, params){
		di=params[0].split('-');
		ti=params[1].split(':');
		df=params[2].split('-');
		tf=value.split(':');

		d_i=new Date(di[0]+"-"+di[1]+"-"+di[2]+" "+ti[0]+":"+ti[1]+":00.0");
		d_f=new Date(df[0]+"-"+df[1]+"-"+df[2]+" "+tf[0]+":"+tf[1]+":00.0");

		if (d_i>=d_f) return false;
		return true;
	});

	$.validator.addMethod("intervalOk", function(value,element,params){
		di=params[0].split('-');
		ti=params[1].split(':');
		df=params[2].split('-');
		tf=params[3].split(':');

		step=parseInt(value);

		d_i=new Date(di[0]+"-"+di[1]+"-"+di[2]+" "+ti[0]+":"+ti[1]+":00.0");
		d_f=new Date(df[0]+"-"+df[1]+"-"+df[2]+" "+tf[0]+":"+tf[1]+":00.0");

		while(d_i < d_f)
			{
				tmp_i=d_i;
				tmp_f=new Date(tmp_i.getTime()+(step*60*1000));
				col='yellow';
				txt='red';
				if(tmp_f>d_f){
					tmp_f=d_f;
					return false;
				}

				d_i=tmp_f;
			}

		return true;
	});

	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today month,agendaWeek,agendaDay',
			center: 'title',
			right: '',
		},
		lang: 'es',
		allDaySlot: false,
		slotMinutes: 15,
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
		events: cargarHoras(), 
		dayClick: function(date, allDay, jsEvent, view){
			if(jsEvent.timeStamp-lastT<1000 && ''+date==''+lastDate){
				$('#calendar').fullCalendar('gotoDate',date);
				$('#calendar').fullCalendar('changeView','agendaDay');
			}
			else if(date!=lastDate){
				lastDate=date
			}
			lastT=jsEvent.timeStamp;
		},
		eventRender: function(event,element){
			element.qtip({
				content: event.description,
				style: {
					classes: 'qtip-bootstrap'
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
				url: detalleEvento,
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
							$('#calendar').fullCalendar('removeEvents',id)

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
								success: function(response) {	$('#calendar').fullCalendar('addEventSource',response);	},
								error: function(xhr, status, error){	alert("No se pudieron cargar las horas de atención");	}
							});
						},
						error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
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
							$('#calendar').fullCalendar('removeEvents',id)
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
								success: function(response) {	$('#calendar').fullCalendar('addEventSource',response);	},
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
							$('#calendar').fullCalendar('removeEvents',id)
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
								success: function(response) {	$('#calendar').fullCalendar('addEventSource',response);	},
								error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
							});
						},
						error: function(xhr, status, error){alert("No se pudieron cargar las horas de atención");	}
					});
				});

				// Si existe el botón "bloquear-hora", le pondrá la siguiente acción al hacer click
				$('#modal-content .modal-footer .bloquear-hora').click(function(){

					$.ajax({
						type: 'POST',
						url: '/bloquear_hora',
						data: {	agendamiento_id: calEvent.id	},
						success: function(response) {
							id=calEvent.id
							$('#calendar').fullCalendar('removeEvents',id)
							if (response=="1"){ $('#modal-container').modal('hide') }
							else{	alert("No se puede bloquear la hora")			}

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
								success: function(response) {	$('#calendar').fullCalendar('addEventSource',response);	},
								error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
							});
						},
						error: function(xhr, status, error){alert("No se pudieron cargar las horas de atención");	}
					});
				});	

				// Si existe el botón "desbloquear-hora", le pondrá la siguiente acción al hacer click
				$('#modal-content .modal-footer .desbloquear-hora').click(function(){

					$.ajax({
						type: 'POST',
						url: '/desbloquear_hora',
						data: {	agendamiento_id: calEvent.id	},
						success: function(response) {
							id=calEvent.id
							$('#calendar').fullCalendar('removeEvents',id)
							if (response=="1"){ $('#modal-container').modal('hide') }
							else{	alert("No se puede desbloquear la hora")			}

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
								success: function(response) {	$('#calendar').fullCalendar('addEventSource',response);	},
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
							$('#calendar').fullCalendar('removeEvents',id)
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
								success: function(response) {	$('#calendar').fullCalendar('addEventSource',response);	},
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
	});

	$('#diaForm input[name="di"],#diaForm input[name="dt"],#comportamientoForm input[name="di"],#comportamientoForm input[name="dt"]').datepicker({
	    format: "dd/mm/yyyy",
	    weekStart: 1,
	    todayBtn: "linked",
	    language: "es",
	    calendarWeeks: true,
	    todayHighlight: true,
	    autoclose: true,
	    dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
	    minDate: '0',
	});

	$('#diaForm input[name="di"]').change(function(){
		tmp=$('#diaForm input[name="dt"]');
		if(tmp.val()==''){
			tmp.val($('#diaForm input[name="di"]').val());
		}
	});

	// Validar form
	$('#comportamientoForm').validate({
		rules: {
			di: "required",
			dt: {
				required: true,
				greaterOrEqualThan1: function(e){
					tmp=$(e).parents("form:first");
					ti=tmp.find('input[name="di"]').val();
					return [ti];
				}
			},
			hi: {
				required: true,
				hourFormat: true
			},
			ht: {
				required: true,
				hourFormat: true	
			},
			i: {
				required: true,
				number: true,
				max: 30,
				positive: true,
				intervalOk: function(e){
					tmp=$(e).parents("form:first");
					di='01/01/2000';
					df='01/01/2000';
					ti=tmp.find('input[name="hi"]').val();
					tf=tmp.find('input[name="ht"]').val();

					t_di=di.split("/");
					t_df=df.split("/");
					t_ti=ti.split(":");
					t_tf=tf.split(":");

					d_i=new Date(t_di[2]+"-"+t_di[1]+"-"+t_di[0]+" "+t_ti[0]+":"+t_ti[1]+":00.0");
					d_f=new Date(t_df[2]+"-"+t_df[1]+"-"+t_df[0]+" "+t_tf[0]+":"+t_tf[1]+":00.0");

					if(d_f<=d_i){
						df='02/01/2000';
					}
					return [di,ti,df,tf];
				}

		},
		'checkboxes[]': 'required'
	},
	messages: {
		di: "Ingrese fecha válida",
		dt: "Ingrese fecha válida",
		hi: "Ingrese hora válida",
		ht: "Ingrese hora válida",
		i: {
			
			required: "Ingrese intervalo válido",
			number: "Ingrese intervalo válido",
			max: "El intervalo es entre 5 y 30",
			positive: "El intervalo es entre 5 y 30",
			intervalOk: "Intervalo dado no calza con fechas"
		},
		'checkboxes[]': 'Debe elegir al menos 1 día'

	},
	errorPlacement: '',
	submitHandler: function(form){

		console.log("Ok");

		$('#calendar').fullCalendar('removeEvents','tmp');
		$('#calendar').fullCalendar('removeEvents','err');

		di=$(form).find('input[name="di"]').val().split('-');
		dt=$(form).find('input[name="dt"]').val().split('-');

		
		daysOfWeek=[];

		for(a=0; a < 7; a++){
			daysOfWeek[a]=$($(form).find('input[type="checkbox"]')[(a+6)%7]).is(':checked');
		}

		

		d_inicio=di[0]+"-"+di[1]+"-"+di[2]+" 00:00:00.0";
		d_final=dt[0]+"-"+dt[1]+"-"+dt[2]+" 23:59:59.0";

		d_i=new Date(d_inicio);
		d_f=new Date(d_final);

		i=0;
		days=[];
		while(d_i < d_f)
		{
			tmp_i=d_i;
			tmp_f=new Date(tmp_i.getTime()+24*60*60*1000);
			if(daysOfWeek[tmp_i.getDay()])
				days[i++]=tmp_i;
			d_i=tmp_f;
		}

		hi=$(form).find('input[name="hi"]').val().split(':');
		ht=$(form).find('input[name="ht"]').val().split(':');

		step=parseInt($(form).find('input[name="i"]').val());

		add_events=[];
		i=0;

		for(j=0; j < days.length; j++){
			tmp=days[j].toString('yyyy-MM-dd')+" "+hi[0]+":"+hi[1]+":00.0";
			d_i=new Date(tmp);
			tmp=days[j].toString('yyyy-MM-dd')+" "+ht[0]+":"+ht[1]+":00.0";
			d_f=new Date(tmp);
			if(d_f<=d_i)
			{
				tmp_date=new Date(days[j].getTime()+24*60*60*1000);
				tmp=tmp_date.toString('yyyy-MM-dd')+" "+ht[0]+":"+ht[1]+":00.0";
				d_f=new Date(tmp);
			}

			if(j==0) $('#calendar').fullCalendar('gotoDate',days[j]);
			
			while(d_i < d_f)
			{

			tmp_i=d_i;
			tmp_f=new Date(tmp_i.getTime()+(step*60*1000));
			col='#A8A899';
			txt='#FFFFFF';
			if(tmp_f>d_f){
				tmp_f=d_f;
				col='red';
				txt='#FFFFFF';
			}

			add_events[i++]={	
					id: 'tmp',
					title: '',
					start: tmp_i, 
					end: tmp_f,
					color: col,
					textColor: txt,
					allDay:false
				};
			d_i=tmp_f;	
			}

		}
		$('#calendar').fullCalendar('addEventSource', add_events);


		$('#comportamientoForm .status').html(link_loading);
		$.ajax({
			type: 'POST',
			url: agregarHoraURL,
			data: {
				especialidad_id: especialidad_id,
				profesional_id: profesional_id,
				prestador_id: prestador_id,
				date_i:d_inicio,
				date_f:d_final,
				hora_i:$(form).find('input[name="hi"]').val(),
				hora_t:$(form).find('input[name="ht"]').val(),
				step: step,
				days: JSON.stringify(daysOfWeek),
				tipo: 'comportamiento'
			},
			success: function(response) {
			    $('#comportamientoForm .status').html('Completado!');
			    $('#calendar').fullCalendar('removeEvents','tmp');
			    $('#calendar').fullCalendar('addEventSource',response);

        	},
        	error: function(xhr, status, error){
        		alert("No se pudo concretar la acción");
        	}
     });

	}

	});


	$('#diaForm').validate({ 
		rules: {
			di: "required",
			dt: {
				required: true,
				greaterOrEqualThan1: function(e){
					tmp=$(e).parents("form:first");
					ti=tmp.find('input[name="di"]').val();
					return [ti];
				}
			},
			hi: {
				required: true,
				hourFormat: true
			},
			ht: {
				required: true,
				hourFormat: true,
				greaterThan1: function(e){
					tmp=$(e).parents("form:first");
					di=tmp.find('input[name="di"]').val();
					df=tmp.find('input[name="dt"]').val();
					ti=tmp.find('input[name="hi"]').val();
					return [di,ti,df];
				}
			},
			i: {
				required: true,
				number: true,
				max: 30,
				positive: true,
				intervalOk: function(e){
					tmp=$(e).parents("form:first");
					di=tmp.find('input[name="di"]').val();
					df=tmp.find('input[name="dt"]').val();
					ti=tmp.find('input[name="hi"]').val();
					tf=tmp.find('input[name="ht"]').val();
					return [di,ti,df,tf];
				}
			}
		},
		messages: {
			di: "Ingrese fecha válida",
			dt: "Ingrese fecha válida",
			hi: "Ingrese hora válida",
			ht: {
				required: "Ingrese hora válida",
				hourFormat: "Ingrese hora válida",
				greaterThan1: "Término debe ser mayor que inicio"
			},
			i: {				
				required: "Ingrese intervalo válido",
				number: "Ingrese intervalo válido",
				max: "El intervalo es entre 5 y 30",
				positive: "El intervalo es entre 5 y 30",
				intervalOk: "Intervalo dado no calza con fechas"
			}

		},
		errorPlacement: '',

		submitHandler: function(form){

			$('#calendar').fullCalendar('removeEvents','tmp');
			$('#calendar').fullCalendar('removeEvents','err');

			di=$(form).find('input[name="di"]').val().split('-');
			dt=$(form).find('input[name="dt"]').val().split('-');
			hi=$(form).find('input[name="hi"]').val().split(':');
			ht=$(form).find('input[name="ht"]').val().split(':');
			step=parseInt($(form).find('input[name="i"]').val());

			d_i_s=di[0]+"-"+di[1]+"-"+di[2]+" "+hi[0]+":"+hi[1]+":00.0";
			d_f_s=dt[0]+"-"+dt[1]+"-"+dt[2]+" "+ht[0]+":"+ht[1]+":00.0";
			d_i=new Date(d_i_s);
			d_f=new Date(d_f_s);
			add_events=[];
			i=0;
			$('#calendar').fullCalendar('gotoDate',di[0],parseInt(di[1])-1,di[2]);
			while(d_i < d_f)
			{
				tmp_i=d_i;
				tmp_f=new Date(tmp_i.getTime()+(step*60*1000));
				col='#A8A899';
				txt='#FFFFFF';
				if(tmp_f>d_f){
					tmp_f=d_f;
					col='red';
					txt='#FFFFFF';
				}

				add_events[i++]={	
						id: 'tmp',
						title: '',
						start: tmp_i, 
						end: tmp_f,
						color: col,
						textColor: txt,
						allDay:false
					};
				d_i=tmp_f;
			}
			$('#calendar').fullCalendar('addEventSource', add_events);
			
			$('#diaForm .status').html(link_loading);
			$.ajax({
				type: 'POST',
				url: agregarHoraURL,
				data: {
					especialidad_id: especialidad_id,
					profesional_id: profesional_id,
					prestador_id: prestador_id,
					date_i:d_i_s,
					date_f:d_f_s,					
					step: step,
					tipo: 'diario'
				},
				success: function(response) {
				    $('#diaForm .status').html('Completado!');
				    $('#calendar').fullCalendar('removeEvents','tmp');
				    $('#calendar').fullCalendar('addEventSource',response);
				    // reRenderCalendar();

	        	},
	        	error: function(xhr, status, error){
	        		alert("No se pudo concretar la acción");
	        	}
	       	});
		}

	});	

	function Mostrar(){
		$('#action button').unbind('click');
		$('#form-container').toggle('slide', function(){
			$('#action button').html('Ocultar >>');
			$('#action button').click(function(){
				Esconder();
			});
		});
		
	}

	function Esconder(){
		$('#action button').unbind('click');
		$('#form-container').toggle('slide', function(){
			$('#action button').html('Agregar horas <<');
			$('#action button').click(function(){
				Mostrar()
			});
		});
	}

	function reRenderCalendar(){
		tmp=$('#calendar').fullCalendar('getView').name;
		$('#calendar').fullCalendar('changeView','month');
		$('#calendar').fullCalendar('changeView','agendaWeek');
		$('#calendar').fullCalendar('changeView','agendaDay');
		$('#calendar').fullCalendar('changeView',tmp);
	}


	$('#action button').click(function(){
		Mostrar();
	});



});