$('select.select_prestadores_proc').select2({ width: '50%', placeholder: 'Seleccione un establecimiento', allowClear: true });
$('select.select_prestadores_proc').on("change", function(e) { 
  var p_p = $(this).attr('id').substring(18);   
  value = $("#select_prestadores"+p_p).select2('data') != null ? $("#select_prestadores"+p_p).select2('data').id : null; 
  agregarInfoPrestacion(p_p,value,'prestador');
})
