$(document).ready(function() {

if ( $.fn.dataTable.isDataTable( '#lista_agendamientos_sin_cancelar' ) ) { }
else {
  $('#lista_agendamientos_sin_cancelar').DataTable({
    "lengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "Todas"]],
    "language": {
      "lengthMenu": "Mostrar _MENU_ agendamientos por página",
      "zeroRecords": "La búsqueda no arrojó resultados.",
      "info": "Página _PAGE_ de _PAGES_",
      "infoEmpty": "No hay agendamientos que mostrar",
      "infoFiltered": "(filtrados de un total de _MAX_ agendamientos",
      "search": "Búsqueda",
      "oPaginate": {
        "sPrevious": "Página anterior",
        "sNext": "Página siguiente"
      }      
    }
  });
}

if ( $.fn.dataTable.isDataTable( '#lista_agendamientos_para_cancelar' ) ) { }
else {
  $('#lista_agendamientos_para_cancelar').DataTable({
    "lengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "Todas"]],
    "language": {
      "lengthMenu": "Mostrar _MENU_ agendamientos por página",
      "zeroRecords": "La búsqueda no arrojó resultados.",
      "info": "Página _PAGE_ de _PAGES_",
      "infoEmpty": "No hay agendamientos que mostrar",
      "infoFiltered": "(filtrados de un total de _MAX_ agendamientos",
      "search": "Búsqueda",
      "oPaginate": {
        "sPrevious": "Página anterior",
        "sNext": "Página siguiente"
      }      
    }
  });
}
})

function cargarCancelarAccion(accion_masiva_id){
  $.ajax({
    type: 'POST',
    url: '/cargar_cancelar_accion',
    data: { accion_masiva: accion_masiva_id},
    success: function(response) {  },
    error: function(xhr, status, error){ alert('No se pudo completar la acción.'); }
  });
}

function cargarVistaSinCancelar(accion_masiva_id){
  $.ajax({
    type: 'POST',
    url: '/cargar_vista_sin_cancelar',
    data: { accion_masiva: accion_masiva_id},
    success: function(response) {  },
    error: function(xhr, status, error){ alert('No se pudo completar la acción.'); }
  });
}

function cancelarAccionMasiva(accion_masiva_id){
  $.ajax({
    type: 'POST',
    url: '/cancelar_accion_masiva',
    data: { accion_masiva: accion_masiva_id},
    success: function(response) { $('#cancelar_accion').modal('hide'); },
    error: function(xhr, status, error){ alert('No se pudo completar la acción.'); }
  });
}