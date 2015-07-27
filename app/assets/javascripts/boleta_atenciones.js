if ( $.fn.dataTable.isDataTable( '#lista_atenciones_boletas' ) ) { }
else {
  $('#lista_atenciones_boletas').DataTable({
    "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todas"]], 
    "language": {
      "lengthMenu": "Mostrar _MENU_ atenciones por página",
      "zeroRecords": "La búsqueda no arrojó resultados.",
      "info": "Mostrando _START_ a _END_ de un total de _TOTAL_ atenciones",
      "infoEmpty": "No hay atenciones que mostrar",
      "infoFiltered": "(filtrados de un total de _MAX_)",
      "search": "Búsqueda",
      "oPaginate": {
        "sPrevious": "Página anterior",
        "sNext": "Página siguiente"
      }
    }
  });
}