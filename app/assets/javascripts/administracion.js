  if ( $.fn.dataTable.isDataTable( '#lista_atenciones_para_pago' ) ) { }
  else {
    $('#lista_atenciones_para_pago').DataTable({
      "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]],
      "language": {
        "lengthMenu": "Mostrar _MENU_ atenciones por página",
        "zeroRecords": "La búsqueda no arrojó resultados.",
        "info": "Página _PAGE_ de _PAGES_",
        "infoEmpty": "No hay atenciones que mostrar",
        "infoFiltered": "(filtrados de un total de _MAX_ atenciones de salud)",
        "search": "Búsqueda",
        "oPaginate": {
          "sPrevious": "Página anterior",
          "sNext": "Página siguiente"
        }      
      }
    });
  }

$(function () {
  $('#datetimepicker6').datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
  });
  $('#datetimepicker7').datetimepicker({
      locale: 'es',
      format: 'YYYY-MM-DD'
  });
  $("#datetimepicker6").on("dp.change", function (e) {
      $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
  });
  $("#datetimepicker7").on("dp.change", function (e) {
      $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
  });
});

$('input[type=radio][name=radios-boletas]').change(function() {
  
  var valor = $('input[name=radios-boletas]:checked').val();
 
  if(valor == 2) { 
    $('#algunos_profesionales').modal('show'); 
    
  }
  else { 
    $('#algunos_profesionales').modal('hide');    
  }

  guardarDiagnostico(pers_diag);

});