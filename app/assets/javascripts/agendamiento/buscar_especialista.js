$(document).ready(function() {

  $('select.select_especialidad').select2({ width: '80%', placeholder: 'Seleccione una especialidad', allowClear: true });
  $('select.select_especialista').select2({ width: '80%', placeholder: 'Seleccione un especialista', allowClear: true });

});

$('.agregar_horas').click( function() {

  var centro = this.id;
  var especialidad = $("#select_especialidad").val();
  var especialista = $("#select_especialista").val();
  
  if (especialidad == '' ) 
    alert('Seleccione una especialidad.');
  else if (especialista == '' )
    alert('Seleccione un especialista');
  else if (centro == '')
    alert('Seleccione un centro médico.');   
  else if(especialidad != '' && especialista != '' && centro != '') {
    window.location="/agendamiento/pedirHora"+"/"+especialidad+"/"+centro+"/"+especialista;
  }

});