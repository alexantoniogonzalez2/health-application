$(document).ready(function() {

	$(".chosen-select").chosen({
    no_results_text: 'No hubo coincidencias.',
    width: '300px',
    allow_single_deselect: true

	}); 

});

$('#save').click( function() {

  var centro = $("#e1").val();
  var especialidad = $("#e2").val();
  var especialista = $("#e3").val();
  
  if (especialidad == '' ) 
    alert('Seleccione una especialidad.');
  if (especialista == '' )
    alert('Seleccione un especialista');
  if (centro == '')
    alert('Seleccione un centro médico.');     
  
  if(especialidad != '' && especialista != '' && centro != '') {
    window.location="/agendamiento/pedirHora"+"/"+$("#e2").val()+"/"+$("#e1").val()+"/"+$("#e3").val();
  }

});