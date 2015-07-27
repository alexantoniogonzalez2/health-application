function actualizarDiagCert(cert,tipo){

  $('#div-diag-cert'+cert).empty();
  $.ajax({
    type: 'POST',
    url: '/agregar_diag_cert',
    data: { id: cert, tipo: tipo },
    success: function(response) { },
    error: function(xhr, status, error){ }
  });
}