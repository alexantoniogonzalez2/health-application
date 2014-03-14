$(document).ready(function(){

 
  $('.chosen-select').chosen({
    allow_single_deselect: false,
    no_results_text: 'No hubo coincidencias.',
    width: '200px'
  });
   
});

$(".chosen-select").on("change", function(e) { 

  var value = $(".chosen-select").val();
  var text = $('.chosen-select option:selected').html();

  $.ajax({
    type: 'POST',
    url: '/agregar_diagnostico',
    data: {
    persona_id: persona_id,
    diagnostico_id: value,
    atencion_salud_id: atencion_salud_id,
    },
    success: function(response) {

    if (response.success)
      $('#diagnostico-div').append('<a href="#" class="list-group-item" id="pd'+response.per_diag+'"><p class="list-group-item-text">'+text+'<button type="button" class="btn btn-xs btn-danger" onclick="eliminarDiagnostico('+response.per_diag+')"  >Eliminar</button><button type="button" class="btn btn-xs btn-primary">Editar</button></p></a>');
    },
    error: function(xhr, status, error){ alert("No se pudieron los diagnósticos del paciente."); }
  });

})

$(function() {
    $( ".fechas" ).datepicker({
      option: "es",
      changeMonth: true,
      changeYear: true,
      showOtherMonths: true,
      selectOtherMonths: true
    });
});


$(function($){
    $.datepicker.regional['es'] = {
        closeText: 'Cerrar',
        prevText: 'Anterior',
        nextText: 'Siguiente',
        currentText: 'Hoy',
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
        dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
        dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
        weekHeader: 'Sm',
        dateFormat: 'dd/mm/yy',
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ''
    };
    $.datepicker.setDefaults($.datepicker.regional['es']);
});



function eliminarDiagnostico(pers_diag) {


  $.ajax({
    type: 'POST',
    url: '/eliminar_diagnostico',
    data: { persona_diagnostico_id: pers_diag, },

    success: function(response) { $( "#pd"+pers_diag).remove();$( "#bc"+pers_diag).remove(); },
    error: function(xhr, status, error){ alert("No se pudo cargar el diagnóstico del paciente.");   }
  });

}
