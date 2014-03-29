$(document).ready(function() {

	$(".chosen-select").chosen({
    no_results_text: 'No hubo coincidencias.',
    width: '300px',
    allow_single_deselect: true

	}); 

  /* 
$('#form_hora').validate({
  rules: {
    e1: { required: true },
    e2: { required: true },
    e3: { required: true },
  },
  messages: {
  	e3: "No se ha seleccionado una especialista",
    e2: "No se ha seleccionado una especialidad",
    e1: "No se ha seleccionado un centro médico"
  },
  submitHandler: function(form){
    window.location="/agendamiento/pedirHora"+"/"+$("#e2").val()+"/"+$("#e1").val()+"/"+$("#e3").val();

  }
})*/

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