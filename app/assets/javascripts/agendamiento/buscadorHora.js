$(document).ready(function() {

		$(".chosen-select").chosen({
			allow_single_deselect: false,
	    no_results_text: 'No hubo coincidencias.',
	    width: '300px',
	    allow_single_deselect: true

		});  


});

$('#buscadorHora').fullCalendar({

	header: {
		left: 'prev,next month,agendaWeek,agendaDay',
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
		week: 'MMM d{ - MMM d}',
		day: 'd MMMM yyyy'
	},
	slotMinutes: 15,
	firstHour: 9,
	columnFormat: {
		day: 'dddd',
		week:'ddd d/M'
	},
	selectable: true,
	buttonText: {
	   // today:    'Hoy',
	    month:    'Mes',
	    week:     'Semana',
	    day:      'Día'
	},
	axisFormat: 'H:mm',
	allDaySlot:false,
	firstDay: 1,
	editable: false,
	defaultView: 'month',
     // will hide Saturdays and Sundays
  dayClick: function() {
 		alert('a day has been clicked!');
 		//$('#buscadorHora').fullCalendar('next');
 		var myCalendar = $('#buscadorHora'); 
		myCalendar.fullCalendar();
		var myEvent = {
		  title:"my new event",
		  allDay: true,
		  start: new Date(),
		  end: new Date()
		};
		myCalendar.fullCalendar( 'renderEvent', myEvent );
	}

})

$("#select_especialidad").on("change", function(e) { 

  var value = $("#select_especialidad").val();
  var text = $('#select_especialidad option:selected').html();
  $.ajax({
    type: 'POST',
    url: '/filtrar_profesionales',
    data: {
      especialidad: value,     
    },
    success: function(response) {
    	$('#select_especialista').empty(); //remove all child nodes
      var newOption = response
      $('#select_especialista').append(response);
      $('#select_especialista').trigger("chosen:updated");     
    },
    error: function(xhr, status, error){ alert("Error al filtrar por especialidad."); }
  });  

})



function actualizarCentro(){

	var centros_seleccionados = new Array();
	var div = document.getElementById("checkbox_centros")
  var cent_sel = div.getElementsByTagName("input");	

	for (var i=1;i<cent_sel.length;i++){ 

		if( cent_sel[i].checked )			
			centros_seleccionados.push(cent_sel[i].value); 	

	}

}

function actualizarTodosLosCentros(){

  var cent_sel = document.getElementById("parentCheckBox");	

	if(cent_sel.checked ){
		var especialidades = $('#select_especialidad option').attr('disabled', false);
		$('#select_especialidad').trigger("chosen:updated");

		var especialistas = $('#select_especialista option').attr('disabled', false);
		$('#select_especialista').trigger("chosen:updated"); 
	}
	else{
		var especialidades = $('#select_especialidad option').attr('disabled', true);
		$('#select_especialidad').trigger("chosen:updated");

		var especialistas = $('#select_especialista option').attr('disabled', true);
		$('#select_especialista').trigger("chosen:updated");    
		
	}	

}



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