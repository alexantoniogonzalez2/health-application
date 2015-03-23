$('select.select_prestadores_proc').select2({ width: '80%', placeholder: 'Seleccione un establecimiento', allowClear: true });
$('select.select_prestadores_proc').on("change", function(e) { 
  var p_p = $(this).attr('id').substring(18); 
  value = $(this).select2('data') != null ? $(this).select2('data').id : null; 
   
  agregarInfoPrestacion(p_p,value,'prestador');
})
