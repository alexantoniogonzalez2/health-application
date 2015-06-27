function actualizarDiagCert(cert){

  $('#div-diag-cert'+cert).empty();
  $.ajax({
    type: 'POST',
    url: '/agregar_diag_cert',
    data: { id: cert },
    success: function(response) { },
    error: function(xhr, status, error){ }
  });
}