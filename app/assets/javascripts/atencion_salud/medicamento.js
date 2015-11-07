function actualizarDiagnosticosMedicamentos(med,tipo){

  $('#div-diagnosticos-'+med).empty();
  $.ajax({
    type: 'POST',
    url: '/agregar_diag_med',
    data: { id: atencion_salud_id, med: med, tipo: tipo },
    success: function(response) { },
    error: function(xhr, status, error){ }
  });
}