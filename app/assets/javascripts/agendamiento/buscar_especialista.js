$(document).ready(function() {

  $('select.select_especialidad_agregar').select2({ width: '80%', placeholder: 'Seleccione una especialidad', allowClear: true });
  $('select.select_especialista_agregar').select2({ width: '80%', placeholder: 'Seleccione un especialista', allowClear: true });

});

$('.agregar_horas').click( function() {

  var centro = this.id;
  var especialidad = $("#select_especialidad_agregar").val();
  var especialista = $("#select_especialista_agregar").val();
  
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

$("#select_especialidad_agregar").on("change", function(e) { 

  var value = $("#select_especialidad_agregar").val();

  $("#select_especialista_agregar").val('');
  
  $.ajax({
    type: 'POST',
    url: '/filtrar_profesionales',
    data: { especialidad: value},
    success: function(response) {
      $('#select_especialista_agregar').val('');
      $('#select_especialista_agregar').empty(); //remove all child nodes
      var newOption = response
      $('#select_especialista_agregar').append(response);
    },
    error: function(xhr, status, error){ alert("Error al filtrar por especialidad.5"); }
  });  

})