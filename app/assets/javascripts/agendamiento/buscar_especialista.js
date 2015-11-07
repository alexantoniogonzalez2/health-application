$(document).ready(function() {
  $('select.select_especialidad_agregar').select2({ width: '80%', placeholder: 'Selecciona una especialidad', allowClear: true });
  $('select.select_especialista_agregar').select2({ width: '80%', placeholder: 'Selecciona un especialista', allowClear: true });
});

$('.agregar_horas').click( function() {

  var centro = this.id;
  var especialidad = $("#select_especialidad_agregar").val();
  var especialista = $("#select_especialista_agregar").val();
  
  if (especialista == '' )
    alert('Selecciona un especialista');
  else if (centro == '')
    alert('Selecciona un centro médico.'); 
  else if (especialidad == '' && especialista != ''){
    $.ajax({
      type: 'POST',
      url: '/filtrar_especialidad',
      data: { especialista: especialista},
      success: function(response) {
        if (response == 'multiples')
          alert('Este especialista tiene más de una especialidad, se debe seleccionar especialidad.');
        else
          window.location="/agendamiento/generarHora"+"/"+response+"/"+centro+"/"+especialista;
      },
      error: function(xhr, status, error){ alert("Error al filtrar por especialidad.5"); }
    }); 

  }    
  else if(especialidad != '' && especialista != '' && centro != '') {
    window.location="/agendamiento/generarHora"+"/"+especialidad+"/"+centro+"/"+especialista;
  }

});

$("#select_especialidad_agregar").on("change", function(e) { 
  var value = $("#select_especialidad_agregar").val();  
  $.ajax({
    type: 'POST',
    url: '/filtrar_profesionales',
    data: { especialidad: value},
    success: function(response) {
      $('#select_especialista_agregar').val(null).trigger("change");
      $('#select_especialista_agregar').empty(); //remove all child nodes
      var newOption = response
      $('#select_especialista_agregar').append(response);
    },
    error: function(xhr, status, error){ alert("Error al filtrar por especialidad.5"); }
  });  
})