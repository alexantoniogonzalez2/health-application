( function($) {
$(document).ready(function(){

  $(".diagnostico_select").select2({
        
  });

    $(".diagnostico_select").on("change", function(e) { 

      $.ajax({
        type: 'POST',
        url: '/agregar_diagnostico',
        data: {
        persona_id: persona_id,
        diagnostico_id: $(".diagnostico_select").select2("val"),
        atencion_salud_id: atencion_salud_id,
        },
        success: function(response) {

        if (response.success)
          $('#diagnostico-div').append('<a href="#" class="list-group-item" id="pd'+response.per_diag+'"><p class="list-group-item-text">'+$(".diagnostico_select").select2('data').text+'<button type="button" class="btn btn-xs btn-danger" onclick="eliminarDiagnostico('+response.per_diag+')"  >Eliminar</button><button type="button" class="btn btn-xs btn-primary">Editar</button></p></a>');
        },
        error: function(xhr, status, error){ alert("No se pudieron cargar las horas de atención"); }
      });

  })




});

} ) ( jQuery );

function eliminarDiagnostico(pers_diag)
{
  //var element = document.getElementById('pd'+pers_diag);
 
  //element.parentNode.removeChild(element);
  $.ajax({
    type: 'POST',
    url: '/eliminar_diagnostico',
    data: {
      persona_diagnostico_id: pers_diag,
        
    },
    success: function(response) {

       $( "#pd"+pers_diag).remove();



    },
    error: function(xhr, status, error){

    }
  });

}
